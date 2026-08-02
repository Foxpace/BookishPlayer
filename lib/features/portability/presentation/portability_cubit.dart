import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../library/domain/audiobook.dart';
import '../../library/domain/audiobook_repository.dart';
import '../../player/domain/book_note.dart';
import '../../settings/domain/settings_repository.dart';
import '../../settings/domain/theme_preference.dart';
import '../domain/local_export_repository.dart';
import 'portability_state.dart';

@injectable
class PortabilityCubit extends Cubit<PortabilityState> {
  PortabilityCubit(this._books, this._settings, this._files)
    : super(const PortabilityState());

  final AudiobookRepository _books;
  final SettingsRepository _settings;
  final LocalExportRepository _files;

  Future<void> backup() async {
    emit(const PortabilityState(status: PortabilityStatus.working));
    try {
      final books = await _books.getBooks();
      final notes = await _books.getAllNotes();
      final theme = await _settings.getThemePreference();
      final saved = await _files.exportBackup({
        'schemaVersion': 1,
        'exportedAt': DateTime.now().toIso8601String(),
        'books': books.map((book) => book.toJson()).toList(),
        'notes': notes.map((note) => note.toJson()).toList(),
        'settings': {'theme': theme.name},
      });
      emit(
        PortabilityState(
          status: saved ? PortabilityStatus.success : PortabilityStatus.idle,
          message: saved ? 'Backup exported.' : null,
        ),
      );
    } catch (_) {
      emit(
        const PortabilityState(
          status: PortabilityStatus.failure,
          message: 'Could not export the backup.',
        ),
      );
    }
  }

  Future<void> restore() async {
    emit(const PortabilityState(status: PortabilityStatus.working));
    try {
      final backup = await _files.pickBackup();
      if (backup == null) {
        emit(const PortabilityState());
        return;
      }
      if (backup['schemaVersion'] != 1) {
        throw const FormatException('Unsupported backup version');
      }
      final books = (backup['books'] as List)
          .map(
            (value) =>
                Audiobook.fromJson(Map<String, dynamic>.from(value as Map)),
          )
          .toList();
      final notes = (backup['notes'] as List)
          .map(
            (value) =>
                BookNote.fromJson(Map<String, dynamic>.from(value as Map)),
          )
          .toList();
      final settings = Map<String, dynamic>.from(
        backup['settings'] as Map? ?? {},
      );
      final theme = ThemePreference.fromStorage(settings['theme'] as String?);
      await _books.replaceLibrary(books, notes);
      await _settings.setThemePreference(theme);
      emit(
        const PortabilityState(
          status: PortabilityStatus.success,
          message:
              'Backup restored. Audio files must remain available locally.',
        ),
      );
    } catch (_) {
      emit(
        const PortabilityState(
          status: PortabilityStatus.failure,
          message: 'This backup could not be restored.',
        ),
      );
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/presentation/app_message.dart';
import '../use_cases/note_use_case_bundle.dart';
import '../models/note_models.dart';
import 'notes_cubits.dart';

@injectable
class NoteGalleryCubit extends Cubit<NoteGalleryState> {
  NoteGalleryCubit(this._useCases) : super(const NoteGalleryState());

  final NoteGalleryUseCases _useCases;

  Future<void> load() async {
    emit(
      state.copyWith(
        status: NoteGalleryStatus.loading,
        metadata: const [],
        notes: const [],
        message: null,
      ),
    );
    try {
      await _loadNotesAndEmit();
    } catch (_) {
      _emitNotesLoadFailure();
    }
  }

  Future<void> _loadNotesAndEmit() async {
    final content = await _useCases.loadGallery();
    emit(
      state.copyWith(
        status: NoteGalleryStatus.ready,
        metadata: content.metadata,
        notes: content.notes,
      ),
    );
  }

  void _emitNotesLoadFailure() => emit(
    state.copyWith(
      status: NoteGalleryStatus.failure,
      message: AppMessage.notesLoadFailed,
      effectRevision: state.effectRevision + 1,
    ),
  );

  Future<void> updateNote(
    BookNote note, {
    required String? title,
    required String text,
  }) async {
    final updated = await _useCases.updateNote(note, title: title, text: text);
    if (updated == null) {
      return;
    }
    emit(
      state.copyWith(
        notes: [
          for (final current in state.notes)
            if (current.id == note.id) updated else current,
        ],
      ),
    );
  }
}

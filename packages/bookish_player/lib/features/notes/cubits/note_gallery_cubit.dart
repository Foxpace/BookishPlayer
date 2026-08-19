import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/foundation/result.dart';
import '../../../core/presentation/app_message.dart';
import '../use_cases/note_gallery_application.dart';
import '../models/book_note.dart';
import 'notes_cubits.dart';

@injectable
class NoteGalleryCubit extends Cubit<NoteGalleryState> {
  NoteGalleryCubit(this._application) : super(const NoteGalleryState());

  final NoteGalleryApplication _application;

  Future<void> load() async {
    emit(
      state.copyWith(
        status: NoteGalleryStatus.loading,
        metadata: const [],
        notes: const [],
        message: null,
      ),
    );
    await _loadNotesAndEmit();
  }

  Future<void> _loadNotesAndEmit() async {
    switch (await _application.load()) {
      case ResultSuccess(:final value):
        emit(
          state.copyWith(
            status: NoteGalleryStatus.ready,
            metadata: value.metadata,
            notes: value.notes,
          ),
        );
      case ResultFailure():
        _emitNotesLoadFailure();
    }
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
    switch (await _application.update(note, title: title, text: text)) {
      case ResultSuccess(value: final updated?):
        _emitUpdatedNote(note.id, updated);
      case ResultSuccess(value: null):
        return;
      case ResultFailure():
        _emitNotesLoadFailure();
    }
  }

  void _emitUpdatedNote(String noteId, BookNote updated) => emit(
    state.copyWith(
      notes: [
        for (final current in state.notes)
          if (current.id == noteId) updated else current,
      ],
    ),
  );
}

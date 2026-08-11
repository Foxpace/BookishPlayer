import 'package:bookish_player/features/library/repos/book_metadata_repository.dart';
import 'package:bookish_player/features/notes/cubits/note_gallery_cubit.dart';
import 'package:bookish_player/features/notes/cubits/voice_note_cubit.dart';
import 'package:bookish_player/features/notes/repos/book_note_repository.dart';
import 'package:bookish_player/features/notes/repos/voice_note_transcription_repository.dart';
import 'package:bookish_player/features/notes/use_cases/note_use_case_bundle.dart';

NoteGalleryCubit createNoteGalleryCubit(
  BookNoteRepository notes,
  BookMetadataRepository metadata,
) => NoteGalleryCubit(
  NoteGalleryUseCases(
    loadGallery: LoadNoteGalleryUseCase(notes, metadata),
    updateNote: UpdateGalleryNoteUseCase(notes),
  ),
);

VoiceNoteCubit createVoiceNoteCubit(VoiceNoteTranscriptionRepository speech) =>
    VoiceNoteCubit(
      VoiceNoteUseCases(
        start: StartVoiceNoteUseCase(speech),
        stop: StopVoiceNoteUseCase(speech),
      ),
    );

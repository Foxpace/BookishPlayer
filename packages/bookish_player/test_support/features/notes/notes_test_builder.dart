import 'package:bookish_player/features/library/repos/book_metadata_repository.dart';
import 'package:bookish_player/features/notes/cubits/note_gallery_cubit.dart';
import 'package:bookish_player/features/notes/cubits/voice_note_cubit.dart';
import 'package:bookish_player/features/notes/repos/book_note_repository.dart';
import 'package:bookish_player/features/notes/repos/voice_note_transcription_repository.dart';
import 'package:bookish_player/features/notes/use_cases/note_gallery_application.dart';
import 'package:bookish_player/features/notes/use_cases/voice_note_application.dart';

NoteGalleryCubit createNoteGalleryCubit(
  BookNoteRepository notes,
  BookMetadataRepository metadata,
) => NoteGalleryCubit(NoteGalleryApplication(notes, metadata));

VoiceNoteCubit createVoiceNoteCubit(VoiceNoteTranscriptionRepository speech) =>
    VoiceNoteCubit(VoiceNoteApplication(speech));

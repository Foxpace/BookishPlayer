import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection.dart';
import 'note_gallery_cubit.dart';
import 'note_gallery_screen.dart';

class NoteGalleryScreenRoot extends StatelessWidget {
  const NoteGalleryScreenRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NoteGalleryCubit>()..load(),
      child: const NoteGalleryScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection.dart';
import 'metadata_editor_cubit.dart';
import 'metadata_editor_screen.dart';

class MetadataEditorScreenRoot extends StatelessWidget {
  const MetadataEditorScreenRoot({required this.bookId, super.key});

  final String bookId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MetadataEditorCubit>()..load(bookId),
      child: const MetadataEditorScreen(),
    );
  }
}

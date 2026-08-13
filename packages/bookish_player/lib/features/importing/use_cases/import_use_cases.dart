import 'package:injectable/injectable.dart';

import 'audiobook_import_workflow.dart';
import '../models/import_models.dart';
import 'remove_transferred_sources_use_case.dart';
import 'copy_import_diagnostics_use_case.dart';

part 'import_book_use_case.dart';

@injectable
class ImportUseCases {
  const ImportUseCases({
    required this.importBook,
    required this.removeTransferredSources,
    required this.copyDiagnostics,
  });

  final ImportBookUseCase importBook;
  final RemoveTransferredSourcesUseCase removeTransferredSources;
  final CopyImportDiagnosticsUseCase copyDiagnostics;
}

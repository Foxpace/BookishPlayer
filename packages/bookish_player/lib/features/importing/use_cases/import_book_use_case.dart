part of 'import_use_cases.dart';

@injectable
class ImportBookUseCase {
  const ImportBookUseCase(this._workflow);

  final AudiobookImportWorkflow _workflow;

  Future<ImportResult> call({
    required bool finderTransfer,
    required ImportProgressCallback onProgress,
  }) => _workflow.run(finderTransfer: finderTransfer, onProgress: onProgress);
}

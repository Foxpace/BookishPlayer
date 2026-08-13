import 'package:injectable/injectable.dart';
import '../repos/import_repositories.dart';
import 'audiobook_import_workflow.dart';

@injectable
class RemoveTransferredSourcesUseCase {
  const RemoveTransferredSourcesUseCase(this._workflow);

  final AudiobookImportWorkflow _workflow;

  Future<void> call(List<SelectedAudioFile> files) =>
      _workflow.retryOriginalRemoval(files);
}

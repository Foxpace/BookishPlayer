import '../models/import_models.dart';
import '../repos/selected_audio_file.dart';

typedef ImportItem = ({
  SelectedAudioFile selected,
  int index,
  int total,
  String title,
});

extension ImportItemCopying on ImportItem {
  ImportItem withTitle(String value) =>
      (selected: selected, index: index, total: total, title: value);

  ImportProgress progressFor(ImportStage stage) => ImportProgress(
    stage: stage,
    selected: selected,
    index: index,
    total: total,
    title: title,
  );
}

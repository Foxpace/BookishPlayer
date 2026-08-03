import 'package:pigeon/pigeon.dart';

class CarBookItem {
  CarBookItem({
    required this.id,
    required this.title,
    required this.author,
    required this.series,
    required this.artworkPath,
    required this.durationMs,
    required this.positionMs,
  });

  String id;
  String title;
  String author;
  String series;
  String? artworkPath;
  int durationMs;
  int positionMs;
}

@HostApi()
abstract class CarPlayHostApi {
  void updateLibrary(List<CarBookItem> books);
}

@FlutterApi()
abstract class CarPlayFlutterApi {
  void playBook(String id);
}

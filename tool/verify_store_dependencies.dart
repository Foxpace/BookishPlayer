import 'dart:convert';
import 'dart:io';

// A workspace lockfile includes internal dependencies. Verify only packages
// reachable from the store app, matching Flutter's plugin discovery rules.
void main(List<String> arguments) {
  final graphFile = arguments.isNotEmpty
      ? File(arguments[0])
      : File.fromUri(
          Platform.script.resolve('../.dart_tool/package_graph.json'),
        );
  final metadataFile = arguments.length > 1
      ? File(arguments[1])
      : File.fromUri(
          Platform.script.resolve(
            '../apps/store/.flutter-plugins-dependencies',
          ),
        );

  final graph =
      jsonDecode(graphFile.readAsStringSync()) as Map<String, Object?>;
  final metadata =
      jsonDecode(metadataFile.readAsStringSync()) as Map<String, Object?>;
  _verifyDependencies(_packagesByName(graph));
  _verifyPlugins(metadata);
  stdout.writeln('Store graph and plugin metadata exclude Cactus and FFmpeg.');
}

Map<String, Map<String, Object?>> _packagesByName(Map<String, Object?> graph) {
  final packages = (graph['packages'] as List<Object?>)
      .cast<Map<String, Object?>>();
  return {for (final package in packages) package['name'] as String: package};
}

void _verifyDependencies(Map<String, Map<String, Object?>> packages) {
  final store = packages['bookish_store'];
  if (store == null) {
    _fail('The workspace graph does not contain bookish_store.');
  }
  final pending = <String>[
    'bookish_store',
    ...(store['devDependencies'] as List<Object?>).cast<String>(),
  ];
  final visited = <String>{};
  while (pending.isNotEmpty) {
    final name = pending.removeLast();
    if (!visited.add(name)) {
      continue;
    }
    if (_isForbidden(name)) {
      _fail('Store dependency graph contains $name.');
    }
    final package = packages[name];
    if (package == null) {
      _fail(
        'Incomplete workspace graph: $name is missing. Run flutter pub get.',
      );
    }
    pending.addAll((package['dependencies'] as List<Object?>).cast<String>());
  }
}

void _verifyPlugins(Map<String, Object?> metadata) {
  final platforms = metadata['plugins'] as Map<String, Object?>;
  for (final plugins in platforms.values) {
    for (final plugin
        in (plugins as List<Object?>).cast<Map<String, Object?>>()) {
      final name = plugin['name'] as String;
      if (_isForbidden(name)) {
        _fail('Store plugin metadata contains $name.');
      }
    }
  }
}

bool _isForbidden(String name) =>
    name.toLowerCase().contains('cactus') ||
    name.toLowerCase().contains('ffmpeg');

Never _fail(String message) {
  stderr.writeln(message);
  exit(1);
}

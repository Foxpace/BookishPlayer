import 'dart:io';

import 'package:code_assets/code_assets.dart';
import 'package:hooks/hooks.dart';

void main(List<String> args) async {
  await build(args, (input, output) async {
    if (!input.config.buildCodeAssets) return;

    final target = input.config.code;
    if (target.targetOS != OS.iOS && target.targetOS != OS.android) return;

    _requireArm64(target);

    final projectRoot = input.packageRoot.resolve('../../');
    final cactusBinary = _cactusBinaryFor(projectRoot, target);
    final buildScript = File.fromUri(
      projectRoot.resolve('tool/build_cactus.sh'),
    );
    final localOnlyPatch = File.fromUri(
      projectRoot.resolve('tool/cactus-v2-local-only.patch'),
    );
    final ffiExportsPatch = File.fromUri(
      projectRoot.resolve('tool/cactus-v2-ffi-exports.patch'),
    );
    final ffiExportsSource = File.fromUri(
      projectRoot.resolve('tool/cactus_ffi_exports.cpp'),
    );

    await _ensureCactusBuilt(
      projectRoot: projectRoot,
      target: target,
      cactusBinary: cactusBinary,
      buildScript: buildScript,
      localOnlyPatch: localOnlyPatch,
      ffiExportsPatch: ffiExportsPatch,
      ffiExportsSource: ffiExportsSource,
    );

    _includeCactusInApp(input, output, cactusBinary, target);
    output.dependencies.addAll([
      buildScript.uri,
      localOnlyPatch.uri,
      ffiExportsPatch.uri,
      ffiExportsSource.uri,
    ]);
  });
}

void _requireArm64(CodeConfig target) {
  if (target.targetArchitecture == Architecture.arm64) return;

  throw UnsupportedError(
    'Cactus supports only arm64. On iOS, exclude x86_64 from the '
    'Simulator architectures. On Android, build for android-arm64.',
  );
}

File _cactusBinaryFor(Uri projectRoot, CodeConfig target) {
  if (target.targetOS == OS.android) {
    return File.fromUri(
      projectRoot.resolve('build/cactus-v2.0.1/android/libcactus_engine.so'),
    );
  }

  final simulator = target.iOS.targetSdk == IOSSdk.iPhoneSimulator;
  final slice = simulator ? 'ios-arm64-simulator' : 'ios-arm64';
  return File.fromUri(
    projectRoot.resolve(
      'build/cactus-v2.0.1/apple/cactus-ios.xcframework/'
      '$slice/cactus.framework/cactus',
    ),
  );
}

Future<void> _ensureCactusBuilt({
  required Uri projectRoot,
  required CodeConfig target,
  required File cactusBinary,
  required File buildScript,
  required File localOnlyPatch,
  required File ffiExportsPatch,
  required File ffiExportsSource,
}) async {
  final buildLock = File.fromUri(
    projectRoot.resolve('build/cactus-v2-build.lock'),
  );
  buildLock.parent.createSync(recursive: true);
  final lockHandle = buildLock.openSync(mode: FileMode.append);

  try {
    lockHandle.lockSync();
    if (!_cactusNeedsBuild(cactusBinary, [
      buildScript,
      localOnlyPatch,
      ffiExportsPatch,
      ffiExportsSource,
    ])) {
      return;
    }

    final platform = target.targetOS == OS.iOS ? 'apple' : 'android';
    final result = await Process.run('bash', [
      buildScript.path,
      platform,
    ], workingDirectory: projectRoot.toFilePath());
    if (result.exitCode != 0) {
      throw StateError(
        'Cactus native build failed:\n${result.stdout}\n${result.stderr}',
      );
    }
  } finally {
    lockHandle.unlockSync();
    lockHandle.closeSync();
  }
}

bool _cactusNeedsBuild(File cactusBinary, List<File> buildInputs) {
  if (!cactusBinary.existsSync()) return true;

  final builtAt = cactusBinary.lastModifiedSync();
  return buildInputs.any((input) => builtAt.isBefore(input.lastModifiedSync()));
}

void _includeCactusInApp(
  BuildInput input,
  BuildOutputBuilder output,
  File cactusBinary,
  CodeConfig target,
) {
  final assetName = target.targetOS == OS.iOS
      ? 'cactus.framework/cactus'
      : 'libcactus_engine.so';
  final bundledBinary = File.fromUri(input.outputDirectory.resolve(assetName));
  bundledBinary.parent.createSync(recursive: true);
  cactusBinary.copySync(bundledBinary.path);

  output.assets.code.add(
    CodeAsset(
      package: input.packageName,
      name: 'src/vendor/cactus.dart',
      linkMode: DynamicLoadingBundled(),
      file: bundledBinary.uri,
    ),
  );
}

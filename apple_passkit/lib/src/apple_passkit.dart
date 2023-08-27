import 'package:apple_passkit/src/apple_pk_pass.dart';
import 'package:apple_passkit/src/exception_converter.dart';
import 'package:apple_passkit/src/pk_pass_library_add_passes_status.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class ApplePassKit {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('apple_passkit');

  // ========== Methods of PKPassLibrary
  Future<bool> isPassLibraryAvailable() async =>
      await wrapWithException(
          methodChannel.invokeMethod<bool>('isPassLibraryAvailable')) ??
      false;

  Future<PKPassLibraryAddPassesStatus> addPassesWithoutUI(
    List<Uint8List> passes,
  ) async {
    final resultCode = await wrapWithException(
        methodChannel.invokeMethod<String>('addPasses', passes));
    if (resultCode == null) {
      return PKPassLibraryAddPassesStatus.unknown;
    }
    if (!PKPassLibraryAddPassesStatus.values
        .any((element) => element.name == resultCode)) {
      return PKPassLibraryAddPassesStatus.unknown;
    }
    return PKPassLibraryAddPassesStatus.values
        .where((element) => element.name == resultCode)
        .first;
  }

  Future<List<ApplePkPass>> passes() async {
    final list = await wrapWithException(
        methodChannel.invokeMethod<List<Object>>('getPasses'));

    return list
            ?.cast<Map<Object, Object?>>()
            .map(ApplePkPass.fromMap)
            .toList() ??
        [];
  }

  // ========== Methods of PKAddPassesViewController

  /// Returns a Boolean value that indicates whether the device supports adding passes.
  Future<bool> canAddPasses() async =>
      await wrapWithException(
          methodChannel.invokeMethod<bool>('canAddPasses')) ??
      false;

  Future<void> addPass(Uint8List pass) async => await wrapWithException(
      methodChannel.invokeMethod<void>('addPassViewController', [pass]));

  Future<void> addPasses(List<Uint8List> passes) async =>
      await wrapWithException(
          methodChannel.invokeMethod<void>('addPassesViewController', passes));
}

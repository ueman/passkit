import 'package:apple_passkit/src/apple_pk_pass.dart';
import 'package:apple_passkit/src/exceptions.dart';
import 'package:apple_passkit/src/pk_pass_library_add_passes_status.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// This class allows you to access native PassKits functionality.
///
/// Adding payment passes requires a special entitlement issued by Apple.
/// Your app must include this entitlement before this class can be
/// instantiated. For more information on requesting this entitlement, see the
/// Card Issuers section at developer.apple.com/apple-pay/.
class ApplePassKit {
  @visibleForTesting
  final methodChannel = const MethodChannel('apple_passkit');

  // ========== Methods of PKPassLibrary

  /// Returns a Boolean value that indicates whether the pass library is
  /// available. This method exists because the pass library may be unavailable
  /// even if the PKPassLibrary class exists.
  ///
  /// Don’t use this method to determine whether the user can add passes on the
  /// device. A device may have a pass library, but still not be able to add
  /// passes. Use this class’s [canAddPasses] method instead.
  Future<bool> isPassLibraryAvailable() async =>
      await wrapWithException(
        methodChannel.invokeMethod<bool>('isPassLibraryAvailable'),
      ) ??
      false;

  /// Presents a user interface for adding multiple passes at once.
  ///
  /// A [PKPassLibraryAddPassesStatus] value that indicates whether PassKit adds
  /// the passes. If the user selects to review the passes, PassKit sets the
  /// status to [PKPassLibraryAddPassesStatus.shouldReviewPasses].
  /// In this case, you must add the passes via [addPass] or [addPasses] to let
  /// the user review and add the passes.
  Future<PKPassLibraryAddPassesStatus> addPassesWithoutUI(
    List<Uint8List> passes,
  ) async {
    final nonEmptyPasses = passes.where((p) => p.isNotEmpty).toList();
    if (nonEmptyPasses.isEmpty) {
      return PKPassLibraryAddPassesStatus.unknown;
    }

    final resultCode = await wrapWithException(
      methodChannel.invokeMethod<String>(
        'addPasses',
        nonEmptyPasses,
      ),
    );

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

  /// Returns the passes in the user’s pass library that the app can access.
  /// Your app only has access to certain passes according to its entitlements.
  /// PassKit doesn’t return passes that your app can’t access.
  ///
  /// Passes don’t have a fixed order. Calling this method multiple times may
  /// return the same passes, but in a different order.
  Future<List<ApplePkPass>> passes() async {
    final list = await wrapWithException(
      methodChannel.invokeMethod<List<Object?>?>(
        'getPasses',
      ),
    );

    return list
            ?.cast<Map<Object?, Object?>>()
            .map(ApplePkPass.fromMap)
            .toList() ??
        [];
  }

  /// Returns a Boolean value that indicates whether the user’s pass library
  /// contains the specified pass.
  ///
  /// This method lets you determine that the pass library contains a pass even
  /// though your app can’t read or modify the pass. For example, an email
  /// client doesn’t have entitlements to read or write any passes from the
  /// library.
  ///
  /// Your app can use this method to provide a UI that indicates whether a pass
  /// is already in the library.
  Future<bool> containsPass(Uint8List pass) async {
    if (pass.isEmpty) {
      throw PkPassEmptyException();
    }
    return await wrapWithException(
          methodChannel.invokeMethod<bool>('containsPass', [pass]),
        ) ??
        false;
  }

  // ========== Methods of PKAddPassesViewController

  /// Returns a Boolean value that indicates whether the device supports adding passes.
  Future<bool> canAddPasses() async =>
      await wrapWithException(
        methodChannel.invokeMethod<bool>('canAddPasses'),
      ) ??
      false;

  /// Adding payment passes requires a special entitlement issued by Apple.
  /// If your app does not include this entitlement, this method returns nil.
  /// For more information on requesting this entitlement, see the Card Issuers
  /// section on developer.apple.com/apple-pay/.
  Future<void> addPass(Uint8List pass) async {
    if (pass.isEmpty) {
      throw PkPassEmptyException();
    }
    await wrapWithException(
      methodChannel.invokeMethod<void>(
        'addPassViewController',
        [pass],
      ),
    );
  }

  /// Adding payment passes requires a special entitlement issued by Apple.
  /// If your app does not include this entitlement, this method returns nil.
  /// For more information on requesting this entitlement, see the Card Issuers
  /// section on developer.apple.com/apple-pay/.
  Future<void> addPasses(List<Uint8List> passes) async {
    final nonEmptyPasses = passes.where((p) => p.isNotEmpty).toList();
    if (nonEmptyPasses.isEmpty) {
      return;
    }
    await wrapWithException(
      methodChannel.invokeMethod<void>(
        'addPassesViewController',
        nonEmptyPasses,
      ),
    );
  }
}

import 'dart:async';

import 'package:app/import_pass/import_page.dart';
import 'package:app/router.dart';
import 'package:flutter/services.dart';
import 'package:receive_intent/receive_intent.dart';

Future<void> initReceiveIntent() async {
  try {
    final receivedIntent = await ReceiveIntent.getInitialIntent();
    await _onIntent(receivedIntent);
  } on PlatformException {
    // Handle exception
  }
}

// Does not need to be cancelled, since it's running for the lifetime of the app
// ignore: unused_element
StreamSubscription<Intent?>? _sub;

Future<void> initReceiveIntentWhileRunning() async {
  _sub = ReceiveIntent.receivedIntentStream.listen(
    (Intent? intent) {
      // Validate receivedIntent and warn the user, if it is not correct,
      _onIntent(intent);
    },
    onError: (err) {
      // TODO(ueman): Handle exception
    },
  );
}

Future<void> _onIntent(Intent? receivedIntent) async {
  if (receivedIntent == null || receivedIntent.isNull) {
    // Validate receivedIntent and warn the user, if it is not correct,
    // but keep in mind it could be `null` or "empty"(`receivedIntent.isNull`).
    //
    // TODO(ueman): show error popup?
    return;
  }
  if (receivedIntent.action == 'android.intent.action.MAIN') {
    return;
  }
  final path = receivedIntent.data;

  if (path == null) {
    // TODO(ueman): show error popup?
    return;
  }
  unawaited(
    navigator.pushNamed(
      '/import',
      arguments: PkPassImportSource(contentResolverPath: path),
    ),
  );
}

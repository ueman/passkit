import 'dart:convert';

/// Dart uses a special fast decoder when using a fused [Utf8Decoder] and [JsonDecoder].
/// This speeds up decoding.
/// See https://github.com/dart-lang/sdk/blob/5b2ea0c7a227d91c691d2ff8cbbeb5f7f86afdb9/sdk/lib/_internal/vm/lib/convert_patch.dart#L40
final utf8JsonDecoder = const Utf8Decoder().fuse(const JsonDecoder());

/// Fast encoder for JSON
final utf8JsonEncoder = JsonUtf8Encoder();

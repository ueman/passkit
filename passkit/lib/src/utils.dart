import 'dart:convert';
import 'dart:typed_data';

/// Dart uses a special fast decoder when using a fused [Utf8Decoder] and [JsonDecoder].
/// This speeds up decoding.
/// See https://github.com/dart-lang/sdk/blob/5b2ea0c7a227d91c691d2ff8cbbeb5f7f86afdb9/sdk/lib/_internal/vm/lib/convert_patch.dart#L40
final _utf8JsonDecoder = const Utf8Decoder().fuse(const JsonDecoder());

Map<String, dynamic>? utf8JsonDecode(Uint8List data) =>
    _utf8JsonDecoder.convert(data) as Map<String, dynamic>?;

/// Fast encoder for JSON
final _utf8JsonEncoder = JsonUtf8Encoder();

Uint8List utf8JsonEncode(Object data) =>
    Uint8List.fromList(_utf8JsonEncoder.convert(data));

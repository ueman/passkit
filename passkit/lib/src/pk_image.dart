import 'dart:typed_data';

class PkImage {
  PkImage({this.image1, this.image2, this.image3, this.localizedImages});

  final Uint8List? image1;
  final Uint8List? image2;
  final Uint8List? image3;
  final Map<String, Map<int, Uint8List>>? localizedImages;

  static PkImage? fromImages({
    Uint8List? image1,
    Uint8List? image2,
    Uint8List? image3,
    Map<String, Map<int, Uint8List>>? localizedImages,
  }) {
    if (image1 == null && image2 == null && image3 == null) {
      return null;
    }
    return PkImage(image1: image1, image2: image2, image3: image3);
  }

  /// [locale] is defined according to https://developer.apple.com/documentation/xcode/choosing-localization-regions-and-scripts
  Uint8List fromMultiplier(int multiplier, {String? locale}) {
    multiplier = multiplier.clamp(1, 3);
    if (locale != null) {
      final localizedImage = localizedImages?[locale];
      if (localizedImage != null) {
        return switch (multiplier) {
          1 => (localizedImage[1] ?? localizedImage[2] ?? localizedImage[3])!,
          2 => (localizedImage[2] ?? localizedImage[3] ?? localizedImage[1])!,
          _ => (localizedImage[3] ?? localizedImage[2] ?? localizedImage[1])!,
        };
      }
    }
    return switch (multiplier) {
      1 => (image1 ?? image2 ?? image3)!,
      2 => (image2 ?? image3 ?? image1)!,
      _ => (image3 ?? image2 ?? image1)!,
    };
  }
}

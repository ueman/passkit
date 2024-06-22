import 'dart:typed_data';

class PkPassImage {
  PkPassImage({this.image1, this.image2, this.image3});
  static PkPassImage? fromImages({
    Uint8List? image1,
    Uint8List? image2,
    Uint8List? image3,
  }) {
    if (image1 == null && image2 == null && image3 == null) {
      return null;
    }
    return PkPassImage(image1: image1, image2: image2, image3: image3);
  }

  final Uint8List? image1;
  final Uint8List? image2;
  final Uint8List? image3;

  Uint8List fromMultiplier(int multiplier) {
    assert(multiplier == 1 || multiplier == 2 || multiplier == 3);
    switch (multiplier) {
      case 1:
        return (image1 ?? image2 ?? image3)!;
      case 2:
        return (image2 ?? image3 ?? image1)!;
    }
    return (image3 ?? image2 ?? image1)!;
  }
}

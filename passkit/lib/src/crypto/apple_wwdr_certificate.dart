import 'dart:typed_data';

import 'package:meta/meta.dart';
import 'package:pkcs7/pkcs7.dart';

/// This is the content of https://www.apple.com/certificateauthority/AppleWWDRCAG4.cer
///
/// You can override this property to use a different certificate. Make sure to
/// override it before reading or creating any PkPass or Order files.
///
/// You can find other certificates at:
/// - https://developer.apple.com/help/account/reference/wwdr-intermediate-certificates/
/// - https://www.apple.com/certificateauthority/
final X509 wwdrG4 =
    X509.fromDer(Uint8List.fromList(worldwide_Developer_Relations_G4));

/// This is the content of https://www.apple.com/certificateauthority/AppleWWDRCAG4.cer .
/// It was basically read like this `File('AppleWWDRCAG4.cer').readAsBytesSync()` and then just pasted
/// here.
///
/// More info at:
/// https://developer.apple.com/help/account/reference/wwdr-intermediate-certificates/
/// https://www.apple.com/certificateauthority/
@internal
// ignore: constant_identifier_names, non_constant_identifier_names
final worldwide_Developer_Relations_G4 = Uint8List.fromList([
  48,
  130,
  4,
  85,
  48,
  130,
  3,
  61,
  160,
  3,
  2,
  1,
  2,
  2,
  20,
  19,
  220,
  119,
  149,
  82,
  113,
  229,
  61,
  198,
  50,
  232,
  204,
  255,
  229,
  33,
  243,
  204,
  197,
  206,
  210,
  48,
  13,
  6,
  9,
  42,
  134,
  72,
  134,
  247,
  13,
  1,
  1,
  11,
  5,
  0,
  48,
  98,
  49,
  11,
  48,
  9,
  6,
  3,
  85,
  4,
  6,
  19,
  2,
  85,
  83,
  49,
  19,
  48,
  17,
  6,
  3,
  85,
  4,
  10,
  19,
  10,
  65,
  112,
  112,
  108,
  101,
  32,
  73,
  110,
  99,
  46,
  49,
  38,
  48,
  36,
  6,
  3,
  85,
  4,
  11,
  19,
  29,
  65,
  112,
  112,
  108,
  101,
  32,
  67,
  101,
  114,
  116,
  105,
  102,
  105,
  99,
  97,
  116,
  105,
  111,
  110,
  32,
  65,
  117,
  116,
  104,
  111,
  114,
  105,
  116,
  121,
  49,
  22,
  48,
  20,
  6,
  3,
  85,
  4,
  3,
  19,
  13,
  65,
  112,
  112,
  108,
  101,
  32,
  82,
  111,
  111,
  116,
  32,
  67,
  65,
  48,
  30,
  23,
  13,
  50,
  48,
  49,
  50,
  49,
  54,
  49,
  57,
  51,
  54,
  48,
  52,
  90,
  23,
  13,
  51,
  48,
  49,
  50,
  49,
  48,
  48,
  48,
  48,
  48,
  48,
  48,
  90,
  48,
  117,
  49,
  68,
  48,
  66,
  6,
  3,
  85,
  4,
  3,
  12,
  59,
  65,
  112,
  112,
  108,
  101,
  32,
  87,
  111,
  114,
  108,
  100,
  119,
  105,
  100,
  101,
  32,
  68,
  101,
  118,
  101,
  108,
  111,
  112,
  101,
  114,
  32,
  82,
  101,
  108,
  97,
  116,
  105,
  111,
  110,
  115,
  32,
  67,
  101,
  114,
  116,
  105,
  102,
  105,
  99,
  97,
  116,
  105,
  111,
  110,
  32,
  65,
  117,
  116,
  104,
  111,
  114,
  105,
  116,
  121,
  49,
  11,
  48,
  9,
  6,
  3,
  85,
  4,
  11,
  12,
  2,
  71,
  52,
  49,
  19,
  48,
  17,
  6,
  3,
  85,
  4,
  10,
  12,
  10,
  65,
  112,
  112,
  108,
  101,
  32,
  73,
  110,
  99,
  46,
  49,
  11,
  48,
  9,
  6,
  3,
  85,
  4,
  6,
  19,
  2,
  85,
  83,
  48,
  130,
  1,
  34,
  48,
  13,
  6,
  9,
  42,
  134,
  72,
  134,
  247,
  13,
  1,
  1,
  1,
  5,
  0,
  3,
  130,
  1,
  15,
  0,
  48,
  130,
  1,
  10,
  2,
  130,
  1,
  1,
  0,
  208,
  31,
  120,
  170,
  122,
  39,
  50,
  176,
  70,
  95,
  231,
  23,
  118,
  216,
  160,
  157,
  14,
  41,
  142,
  173,
  61,
  50,
  165,
  196,
  107,
  55,
  201,
  228,
  65,
  145,
  106,
  183,
  121,
  113,
  93,
  12,
  52,
  4,
  96,
  117,
  247,
  174,
  67,
  143,
  71,
  196,
  134,
  30,
  8,
  232,
  191,
  214,
  57,
  82,
  47,
  30,
  103,
  252,
  113,
  241,
  130,
  109,
  60,
  126,
  6,
  82,
  118,
  157,
  44,
  188,
  213,
  67,
  233,
  177,
  180,
  188,
  64,
  58,
  120,
  81,
  93,
  81,
  161,
  37,
  225,
  190,
  108,
  145,
  157,
  107,
  33,
  89,
  24,
  65,
  213,
  15,
  141,
  109,
  65,
  42,
  57,
  74,
  33,
  224,
  144,
  159,
  78,
  19,
  79,
  208,
  140,
  154,
  50,
  184,
  215,
  106,
  146,
  30,
  37,
  106,
  164,
  50,
  206,
  34,
  25,
  133,
  5,
  96,
  220,
  2,
  74,
  242,
  90,
  235,
  119,
  121,
  2,
  125,
  192,
  151,
  84,
  108,
  146,
  142,
  118,
  1,
  230,
  70,
  143,
  229,
  230,
  42,
  251,
  162,
  176,
  173,
  24,
  173,
  109,
  51,
  133,
  56,
  35,
  139,
  234,
  138,
  150,
  237,
  159,
  174,
  102,
  79,
  163,
  12,
  64,
  39,
  109,
  149,
  208,
  98,
  136,
  217,
  67,
  41,
  39,
  253,
  237,
  164,
  191,
  83,
  46,
  144,
  21,
  101,
  60,
  217,
  46,
  98,
  100,
  51,
  29,
  108,
  106,
  221,
  142,
  33,
  170,
  164,
  95,
  21,
  198,
  48,
  237,
  95,
  230,
  140,
  54,
  146,
  148,
  183,
  220,
  57,
  2,
  0,
  251,
  100,
  140,
  212,
  12,
  129,
  242,
  63,
  213,
  52,
  151,
  135,
  117,
  38,
  194,
  111,
  174,
  3,
  99,
  33,
  12,
  123,
  212,
  27,
  177,
  98,
  197,
  2,
  156,
  189,
  253,
  175,
  2,
  3,
  1,
  0,
  1,
  163,
  129,
  239,
  48,
  129,
  236,
  48,
  18,
  6,
  3,
  85,
  29,
  19,
  1,
  1,
  255,
  4,
  8,
  48,
  6,
  1,
  1,
  255,
  2,
  1,
  0,
  48,
  31,
  6,
  3,
  85,
  29,
  35,
  4,
  24,
  48,
  22,
  128,
  20,
  43,
  208,
  105,
  71,
  148,
  118,
  9,
  254,
  244,
  107,
  141,
  46,
  64,
  166,
  247,
  71,
  77,
  127,
  8,
  94,
  48,
  68,
  6,
  8,
  43,
  6,
  1,
  5,
  5,
  7,
  1,
  1,
  4,
  56,
  48,
  54,
  48,
  52,
  6,
  8,
  43,
  6,
  1,
  5,
  5,
  7,
  48,
  1,
  134,
  40,
  104,
  116,
  116,
  112,
  58,
  47,
  47,
  111,
  99,
  115,
  112,
  46,
  97,
  112,
  112,
  108,
  101,
  46,
  99,
  111,
  109,
  47,
  111,
  99,
  115,
  112,
  48,
  51,
  45,
  97,
  112,
  112,
  108,
  101,
  114,
  111,
  111,
  116,
  99,
  97,
  48,
  46,
  6,
  3,
  85,
  29,
  31,
  4,
  39,
  48,
  37,
  48,
  35,
  160,
  33,
  160,
  31,
  134,
  29,
  104,
  116,
  116,
  112,
  58,
  47,
  47,
  99,
  114,
  108,
  46,
  97,
  112,
  112,
  108,
  101,
  46,
  99,
  111,
  109,
  47,
  114,
  111,
  111,
  116,
  46,
  99,
  114,
  108,
  48,
  29,
  6,
  3,
  85,
  29,
  14,
  4,
  22,
  4,
  20,
  91,
  217,
  250,
  29,
  231,
  154,
  26,
  11,
  163,
  153,
  118,
  34,
  80,
  134,
  62,
  145,
  200,
  91,
  119,
  168,
  48,
  14,
  6,
  3,
  85,
  29,
  15,
  1,
  1,
  255,
  4,
  4,
  3,
  2,
  1,
  6,
  48,
  16,
  6,
  10,
  42,
  134,
  72,
  134,
  247,
  99,
  100,
  6,
  2,
  1,
  4,
  2,
  5,
  0,
  48,
  13,
  6,
  9,
  42,
  134,
  72,
  134,
  247,
  13,
  1,
  1,
  11,
  5,
  0,
  3,
  130,
  1,
  1,
  0,
  63,
  86,
  61,
  158,
  229,
  182,
  195,
  121,
  230,
  69,
  32,
  104,
  189,
  191,
  115,
  139,
  44,
  18,
  158,
  2,
  227,
  174,
  128,
  34,
  140,
  4,
  30,
  195,
  82,
  200,
  112,
  128,
  168,
  251,
  206,
  167,
  176,
  213,
  66,
  68,
  130,
  3,
  130,
  79,
  6,
  252,
  59,
  73,
  20,
  251,
  216,
  116,
  82,
  133,
  175,
  167,
  157,
  33,
  231,
  1,
  18,
  3,
  159,
  205,
  64,
  88,
  208,
  1,
  215,
  191,
  50,
  131,
  43,
  83,
  88,
  40,
  60,
  238,
  156,
  159,
  84,
  118,
  61,
  100,
  39,
  198,
  126,
  141,
  29,
  56,
  77,
  45,
  174,
  129,
  230,
  185,
  165,
  184,
  156,
  137,
  148,
  247,
  159,
  199,
  135,
  165,
  81,
  102,
  52,
  27,
  57,
  113,
  57,
  36,
  227,
  135,
  103,
  239,
  165,
  177,
  104,
  123,
  140,
  238,
  61,
  247,
  174,
  182,
  123,
  226,
  210,
  255,
  223,
  97,
  198,
  106,
  117,
  73,
  149,
  34,
  68,
  168,
  4,
  252,
  148,
  184,
  11,
  46,
  57,
  17,
  73,
  18,
  209,
  229,
  129,
  234,
  89,
  0,
  79,
  91,
  60,
  90,
  54,
  218,
  122,
  34,
  115,
  9,
  9,
  105,
  205,
  192,
  124,
  234,
  226,
  36,
  254,
  152,
  68,
  184,
  248,
  239,
  178,
  113,
  63,
  26,
  93,
  212,
  93,
  126,
  51,
  77,
  156,
  29,
  36,
  190,
  0,
  240,
  144,
  3,
  88,
  153,
  65,
  61,
  49,
  90,
  98,
  64,
  175,
  57,
  168,
  81,
  67,
  146,
  171,
  4,
  168,
  156,
  194,
  77,
  177,
  75,
  210,
  171,
  124,
  74,
  95,
  235,
  157,
  59,
  188,
  79,
  136,
  64,
  6,
  19,
  255,
  144,
  23,
  138,
  8,
  71,
  41,
  232,
  98,
  152,
  41,
  165,
  79,
  17,
  5,
  105,
  58,
  207,
  242,
  159,
]);

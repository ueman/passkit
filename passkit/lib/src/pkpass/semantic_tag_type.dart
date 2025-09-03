import 'package:json_annotation/json_annotation.dart';

part 'semantic_tag_type.g.dart';

/// An object that contains information required to connect to a WiFi network.
@JsonSerializable(includeIfNull: false)
class SemanticTagTypeWifiNetwork implements ReadOnlySemanticTagTypeWifiNetwork {
  SemanticTagTypeWifiNetwork({required this.password, required this.ssid});
  factory SemanticTagTypeWifiNetwork.fromJson(Map<String, dynamic> json) =>
      _$SemanticTagTypeWifiNetworkFromJson(json);
  Map<String, dynamic> toJson() => _$SemanticTagTypeWifiNetworkToJson(this);

  /// The password for the WiFi network.
  @override
  @JsonKey(name: 'password')
  String password;

  /// The name for the WiFi network.
  @override
  @JsonKey(name: 'ssid')
  String ssid;

  SemanticTagTypeWifiNetwork copyWith({String? password, String? ssid}) {
    return SemanticTagTypeWifiNetwork(
      password: password ?? this.password,
      ssid: ssid ?? this.ssid,
    );
  }
}

/// An object that represents an amount of money and type of currency.
@JsonSerializable(includeIfNull: false)
class SemanticTagTypeCurrencyAmount
    implements ReadOnlySemanticTagTypeCurrencyAmount {
  SemanticTagTypeCurrencyAmount({
    required this.amount,
    required this.currencyCode,
  });

  factory SemanticTagTypeCurrencyAmount.fromJson(Map<String, dynamic> json) =>
      _$SemanticTagTypeCurrencyAmountFromJson(json);

  Map<String, dynamic> toJson() => _$SemanticTagTypeCurrencyAmountToJson(this);

  /// The amount of money.
  @override
  @JsonKey(name: 'amount')
  String? amount;

  /// The currency code for amount.
  // ISO 4217 currency code as a string
  @override
  @JsonKey(name: 'currencyCode')
  String? currencyCode;

  SemanticTagTypeCurrencyAmount copyWith({
    String? amount,
    String? currencyCode,
  }) {
    return SemanticTagTypeCurrencyAmount(
      amount: amount ?? this.amount,
      currencyCode: currencyCode ?? this.currencyCode,
    );
  }
}

/// An object that represents the coordinates of a location.
@JsonSerializable(includeIfNull: false)
class SemanticTagTypeLocation implements ReadOnlySemanticTagTypeLocation {
  SemanticTagTypeLocation({required this.latitude, required this.longitude});

  factory SemanticTagTypeLocation.fromJson(Map<String, dynamic> json) =>
      _$SemanticTagTypeLocationFromJson(json);

  Map<String, dynamic> toJson() => _$SemanticTagTypeLocationToJson(this);

  /// The latitude, in degrees.
  @override
  @JsonKey(name: 'latitude')
  double latitude;

  /// The longitude, in degrees.
  @override
  @JsonKey(name: 'longitude')
  double longitude;

  SemanticTagTypeLocation copyWith({double? latitude, double? longitude}) {
    return SemanticTagTypeLocation(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}

/// An object that represents the identification of a seat for a transit journey
/// or an event.
@JsonSerializable(includeIfNull: false)
class SemanticTagTypeSeat implements ReadOnlySemanticTagTypeSeat {
  SemanticTagTypeSeat({
    this.seatDescription,
    this.seatIdentifier,
    this.seatNumber,
    this.seatRow,
    this.seatSection,
    this.seatType,
  });

  factory SemanticTagTypeSeat.fromJson(Map<String, dynamic> json) =>
      _$SemanticTagTypeSeatFromJson(json);

  Map<String, dynamic> toJson() => _$SemanticTagTypeSeatToJson(this);

  /// A description of the seat, such as “A flat bed seat”.
  // localizable string
  @override
  @JsonKey(name: 'seatDescription')
  String? seatDescription;

  /// The identifier code for the seat.
  // localizable string
  @override
  @JsonKey(name: 'seatIdentifier')
  String? seatIdentifier;

  /// The number of the seat.
  // localizable string
  @override
  @JsonKey(name: 'seatNumber')
  String? seatNumber;

  /// The row that contains the seat.
  // localizable string
  @override
  @JsonKey(name: 'seatRow')
  String? seatRow;

  /// The section that contains the seat.
  // localizable string
  @override
  @JsonKey(name: 'seatSection')
  String? seatSection;

  /// The type of seat, such as “Reserved seating”.
  // localizable string
  @override
  @JsonKey(name: 'seatType')
  String? seatType;

  SemanticTagTypeSeat copyWith({
    String? seatDescription,
    String? seatIdentifier,
    String? seatNumber,
    String? seatRow,
    String? seatSection,
    String? seatType,
  }) {
    return SemanticTagTypeSeat(
      seatDescription: seatDescription ?? this.seatDescription,
      seatIdentifier: seatIdentifier ?? this.seatIdentifier,
      seatNumber: seatNumber ?? this.seatNumber,
      seatRow: seatRow ?? this.seatRow,
      seatSection: seatSection ?? this.seatSection,
      seatType: seatType ?? this.seatType,
    );
  }
}

/// An object that represents the coordinates of a location.
@JsonSerializable(includeIfNull: false)
class SemanticTagTypePersonNameComponents
    implements ReadOnlySemanticTagTypePersonNameComponents {
  SemanticTagTypePersonNameComponents({
    this.familyName,
    this.givenName,
    this.middleName,
    this.namePrefix,
    this.nameSuffix,
    this.nickname,
    this.phoneticRepresentation,
  });

  factory SemanticTagTypePersonNameComponents.fromJson(
    Map<String, dynamic> json,
  ) => _$SemanticTagTypePersonNameComponentsFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SemanticTagTypePersonNameComponentsToJson(this);

  /// The person’s family name or last name.
  @override
  @JsonKey(name: 'familyName')
  String? familyName;

  /// The person’s given name; also called the forename or first name in some countries.
  @override
  @JsonKey(name: 'givenName')
  String? givenName;

  /// The person’s middle name.
  @override
  @JsonKey(name: 'middleName')
  String? middleName;

  /// The prefix for the person’s name, such as “Dr”.
  @override
  @JsonKey(name: 'namePrefix')
  String? namePrefix;

  /// The suffix for the person’s name, such as “Junior”.
  @override
  @JsonKey(name: 'nameSuffix')
  String? nameSuffix;

  /// The person’s nickname.
  @override
  @JsonKey(name: 'nickname')
  String? nickname;

  /// The phonetic representation of the person’s name.
  @override
  @JsonKey(name: 'phoneticRepresentation')
  String? phoneticRepresentation;

  SemanticTagTypePersonNameComponents copyWith({
    String? familyName,
    String? givenName,
    String? middleName,
    String? namePrefix,
    String? nameSuffix,
    String? nickname,
    String? phoneticRepresentation,
  }) {
    return SemanticTagTypePersonNameComponents(
      familyName: familyName ?? this.familyName,
      givenName: givenName ?? this.givenName,
      middleName: middleName ?? this.middleName,
      namePrefix: namePrefix ?? this.namePrefix,
      nameSuffix: nameSuffix ?? this.nameSuffix,
      nickname: nickname ?? this.nickname,
      phoneticRepresentation:
          phoneticRepresentation ?? this.phoneticRepresentation,
    );
  }
}

abstract class ReadOnlySemanticTagTypeWifiNetwork {
  /// The password for the WiFi network.
  String get password;

  /// The name for the WiFi network.
  String get ssid;
}

abstract class ReadOnlySemanticTagTypeCurrencyAmount {
  /// The amount of money.
  String? get amount;

  /// The currency code for amount.
  // ISO 4217 currency code as a string
  String? get currencyCode;
}

abstract class ReadOnlySemanticTagTypeLocation {
  /// The latitude, in degrees.
  double get latitude;

  /// The longitude, in degrees.
  double get longitude;
}

abstract class ReadOnlySemanticTagTypeSeat {
  /// A description of the seat, such as “A flat bed seat”.
  // localizable string
  String? get seatDescription;

  /// The identifier code for the seat.
  // localizable string
  String? get seatIdentifier;

  /// The number of the seat.
  // localizable string
  String? get seatNumber;

  /// The row that contains the seat.
  // localizable string
  String? get seatRow;

  /// The section that contains the seat.
  // localizable string
  String? get seatSection;

  /// The type of seat, such as “Reserved seating”.
  // localizable string
  String? get seatType;
}

abstract class ReadOnlySemanticTagTypePersonNameComponents {
  /// The person’s family name or last name.
  String? get familyName;

  /// The person’s given name; also called the forename or first name in some countries.
  String? get givenName;

  /// The person’s middle name.
  String? get middleName;

  /// The prefix for the person’s name, such as “Dr”.
  String? get namePrefix;

  /// The suffix for the person’s name, such as “Junior”.
  String? get nameSuffix;

  /// The person’s nickname.
  String? get nickname;

  /// The phonetic representation of the person’s name.
  String? get phoneticRepresentation;
}

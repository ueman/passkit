import 'package:json_annotation/json_annotation.dart';

part 'semantic_tag_type.g.dart';

/// An object that contains information required to connect to a WiFi network.
@JsonSerializable(includeIfNull: false)
class SemanticTagTypeWifiNetwork {
  SemanticTagTypeWifiNetwork({required this.password, required this.ssid});
  factory SemanticTagTypeWifiNetwork.fromJson(Map<String, dynamic> json) =>
      _$SemanticTagTypeWifiNetworkFromJson(json);
  Map<String, dynamic> toJson() => _$SemanticTagTypeWifiNetworkToJson(this);

  /// The password for the WiFi network.
  @JsonKey(name: 'password')
  final String password;

  /// The name for the WiFi network.
  @JsonKey(name: 'ssid')
  final String ssid;

  SemanticTagTypeWifiNetwork copyWith({
    String? password,
    String? ssid,
  }) {
    return SemanticTagTypeWifiNetwork(
      password: password ?? this.password,
      ssid: ssid ?? this.ssid,
    );
  }
}

/// An object that represents an amount of money and type of currency.
@JsonSerializable(includeIfNull: false)
class SemanticTagTypeCurrencyAmount {
  SemanticTagTypeCurrencyAmount({
    required this.amount,
    required this.currencyCode,
  });

  factory SemanticTagTypeCurrencyAmount.fromJson(Map<String, dynamic> json) =>
      _$SemanticTagTypeCurrencyAmountFromJson(json);

  Map<String, dynamic> toJson() => _$SemanticTagTypeCurrencyAmountToJson(this);

  /// The amount of money.
  @JsonKey(name: 'amount')
  final String? amount;

  /// The currency code for amount.
  // ISO 4217 currency code as a string
  @JsonKey(name: 'currencyCode')
  final String? currencyCode;

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
class SemanticTagTypeLocation {
  SemanticTagTypeLocation({required this.latitude, required this.longitude});

  factory SemanticTagTypeLocation.fromJson(Map<String, dynamic> json) =>
      _$SemanticTagTypeLocationFromJson(json);

  Map<String, dynamic> toJson() => _$SemanticTagTypeLocationToJson(this);

  /// The latitude, in degrees.
  @JsonKey(name: 'latitude')
  final double latitude;

  /// The longitude, in degrees.
  @JsonKey(name: 'longitude')
  final double longitude;

  SemanticTagTypeLocation copyWith({
    double? latitude,
    double? longitude,
  }) {
    return SemanticTagTypeLocation(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}

/// An object that represents the identification of a seat for a transit journey
/// or an event.
@JsonSerializable(includeIfNull: false)
class SemanticTagTypeSeat {
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
  @JsonKey(name: 'seatDescription')
  final String? seatDescription;

  /// The identifier code for the seat.
  // localizable string
  @JsonKey(name: 'seatIdentifier')
  final String? seatIdentifier;

  /// The number of the seat.
  // localizable string
  @JsonKey(name: 'seatNumber')
  final String? seatNumber;

  /// The row that contains the seat.
  // localizable string
  @JsonKey(name: 'seatRow')
  final String? seatRow;

  /// The section that contains the seat.
  // localizable string
  @JsonKey(name: 'seatSection')
  final String? seatSection;

  /// The type of seat, such as “Reserved seating”.
  // localizable string
  @JsonKey(name: 'seatType')
  final String? seatType;

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
class SemanticTagTypePersonNameComponents {
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
  ) =>
      _$SemanticTagTypePersonNameComponentsFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SemanticTagTypePersonNameComponentsToJson(this);

  /// The person’s family name or last name.
  @JsonKey(name: 'familyName')
  final String? familyName;

  /// The person’s given name; also called the forename or first name in some countries.
  @JsonKey(name: 'givenName')
  final String? givenName;

  /// The person’s middle name.
  @JsonKey(name: 'middleName')
  final String? middleName;

  /// The prefix for the person’s name, such as “Dr”.
  @JsonKey(name: 'namePrefix')
  final String? namePrefix;

  /// The suffix for the person’s name, such as “Junior”.
  @JsonKey(name: 'nameSuffix')
  final String? nameSuffix;

  /// The person’s nickname.
  @JsonKey(name: 'nickname')
  final String? nickname;

  /// The phonetic representation of the person’s name.
  @JsonKey(name: 'phoneticRepresentation')
  final String? phoneticRepresentation;

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

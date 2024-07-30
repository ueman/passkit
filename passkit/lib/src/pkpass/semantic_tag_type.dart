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
  final String password;

  /// The name for the WiFi network.
  final String ssid;
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
  final String? amount;

  /// The currency code for amount.
  // ISO 4217 currency code as a string
  final String? currencyCode;
}

/// An object that represents the coordinates of a location.
@JsonSerializable(includeIfNull: false)
class SemanticTagTypeLocation {
  SemanticTagTypeLocation({required this.latitude, required this.longitude});

  factory SemanticTagTypeLocation.fromJson(Map<String, dynamic> json) =>
      _$SemanticTagTypeLocationFromJson(json);

  Map<String, dynamic> toJson() => _$SemanticTagTypeLocationToJson(this);

  /// The latitude, in degrees.
  final double latitude;

  /// The longitude, in degrees.
  final double longitude;
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
  final String? seatDescription;

  /// The identifier code for the seat.
  // localizable string
  final String? seatIdentifier;

  /// The number of the seat.
  // localizable string
  final String? seatNumber;

  /// The row that contains the seat.
  // localizable string
  final String? seatRow;

  /// The section that contains the seat.
  // localizable string
  final String? seatSection;

  /// The type of seat, such as “Reserved seating”.
  // localizable string
  final String? seatType;
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
  final String? familyName;

  /// The person’s given name; also called the forename or first name in some countries.
  final String? givenName;

  /// The person’s middle name.
  final String? middleName;

  /// The prefix for the person’s name, such as “Dr”.
  final String? namePrefix;

  /// The suffix for the person’s name, such as “Junior”.
  final String? nameSuffix;

  /// The person’s nickname.
  final String? nickname;

  /// The phonetic representation of the person’s name.
  final String? phoneticRepresentation;
}

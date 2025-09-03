import 'package:json_annotation/json_annotation.dart';
import 'package:passkit/src/pkpass/semantic_tag_type.dart';

part 'semantics.g.dart';

/// https://developer.apple.com/documentation/walletpasses/pass/supporting_semantic_tags_in_wallet_passes
@JsonSerializable(includeIfNull: false)
class Semantics implements ReadOnlySemantics {
  Semantics({
    this.airlineCode,
    this.artistIDs,
    this.awayTeamAbbreviation,
    this.awayTeamLocation,
    this.awayTeamName,
    this.boardingGroup,
    this.boardingSequenceNumber,
    this.carNumber,
    this.confirmationNumber,
    this.currentArrivalDate,
    this.currentBoardingDate,
    this.currentDepartureDate,
    this.departureAirportCode,
    this.departureAirportName,
    this.departureGate,
    this.departureLocationDescription,
    this.departurePlatform,
    this.departureStationName,
    this.departureTerminal,
    this.destinationAirportCode,
    this.destinationAirportName,
    this.destinationGate,
    this.destinationLocationDescription,
    this.destinationPlatform,
    this.destinationStationName,
    this.destinationTerminal,
    this.duration,
    this.eventEndDate,
    this.eventName,
    this.eventStartDate,
    this.eventType,
    this.flightCode,
    this.flightNumber,
    this.genre,
    this.homeTeamAbbreviation,
    this.homeTeamLocation,
    this.homeTeamName,
    this.leagueAbbreviation,
    this.leagueName,
    this.membershipProgramName,
    this.membershipProgramNumber,
    this.originalArrivalDate,
    this.originalBoardingDate,
    this.originalDepartureDate,
    this.performerNames,
    this.priorityStatus,
    this.securityScreening,
    this.silenceRequested,
    this.sportName,
    this.transitProvider,
    this.transitStatus,
    this.transitStatusReason,
    this.vehicleName,
    this.vehicleNumber,
    this.vehicleType,
    this.venueEntrance,
    this.venueName,
    this.venuePhoneNumber,
    this.venueRoom,
    this.balance,
    this.departureLocation,
    this.destinationLocation,
    this.seats,
    this.totalPrice,
    this.venueLocation,
    this.wifiAccess,
    this.passengerName,
  });

  factory Semantics.fromJson(Map<String, dynamic> json) =>
      _$SemanticsFromJson(json);

  Map<String, dynamic> toJson() => _$SemanticsToJson(this);

  /// The IATA airline code, such as “EX” for flightCode “EX123”.
  /// Use this key only for airline boarding passes.
  // localizable string
  @override
  @JsonKey(name: 'airlineCode')
  String? airlineCode;

  /// An array of the Apple Music persistent ID for each artist performing at the event, in decreasing order of significance.
  /// Use this key for any type of event ticket.
  // [localizable string]
  @override
  @JsonKey(name: 'artistIDs')
  List<String>? artistIDs;

  /// The unique abbreviation of the away team’s name. Use this key only for a sports event ticket.
  // localizable string
  @override
  @JsonKey(name: 'awayTeamAbbreviation')
  String? awayTeamAbbreviation;

  /// The home location of the away team. Use this key only for a sports event ticket.
  // localizable string
  @override
  @JsonKey(name: 'awayTeamLocation')
  String? awayTeamLocation;

  /// The name of the away team. Use this key only for a sports event ticket.
  // localizable string
  @override
  @JsonKey(name: 'awayTeamName')
  String? awayTeamName;

  /// The current balance redeemable with the pass. Use this key only for a store card pass.
  @override
  @JsonKey(name: 'balance')
  SemanticTagTypeCurrencyAmount? balance;

  /// A group number for boarding. Use this key for any type of boarding pass.
  // localizable string
  @override
  @JsonKey(name: 'boardingGroup')
  String? boardingGroup;

  /// A sequence number for boarding. Use this key for any type of boarding pass.
  // localizable string
  @override
  @JsonKey(name: 'boardingSequenceNumber')
  String? boardingSequenceNumber;

  /// The number of the passenger car. A train car is also called a carriage, wagon, coach, or bogie in some countries. Use this key only for a train or other rail boarding pass.
  // localizable string
  @override
  @JsonKey(name: 'carNumber')
  String? carNumber;

  /// A booking or reservation confirmation number. Use this key for any type of boarding pass.
  // localizable string
  @override
  @JsonKey(name: 'confirmationNumber')
  String? confirmationNumber;

  /// The updated date and time of arrival, if different from the originally scheduled date and time. Use this key for any type of boarding pass.
  // ISO 8601 date as string
  @override
  @JsonKey(name: 'currentArrivalDate')
  DateTime? currentArrivalDate;

  /// The updated date and time of boarding, if different from the originally scheduled date and time. Use this key for any type of boarding pass.
  // ISO 8601 date as string
  @override
  @JsonKey(name: 'currentBoardingDate')
  DateTime? currentBoardingDate;

  /// The updated departure date and time, if different from the originally scheduled date and time. Use this key for any type of boarding pass.
  // ISO 8601 date as string
  @override
  @JsonKey(name: 'currentDepartureDate')
  DateTime? currentDepartureDate;

  /// The IATA airport code for the departure airport, such as “MPM” or “LHR”. Use this key only for airline boarding passes.
  // localizable string
  @override
  @JsonKey(name: 'departureAirportCode')
  String? departureAirportCode;

  /// The full name of the departure airport, such as “Maputo International Airport”. Use this key only for airline boarding passes.
  // localizable string
  @override
  @JsonKey(name: 'departureAirportName')
  String? departureAirportName;

  /// The gate number or letters of the departure gate, such as “1A”. Do not include the word “Gate.”
  // localizable string
  @override
  @JsonKey(name: 'departureGate')
  String? departureGate;

  /// An object that represents the geographic coordinates of the transit departure location, suitable for display on a map. If possible, use precise locations, which are more useful to travelers; for example, the specific location of an airport gate. Use this key for any type of boarding pass.
  @override
  @JsonKey(name: 'departureLocation')
  SemanticTagTypeLocation? departureLocation;

  /// A brief description of the departure location. For example, for a flight departing from an airport whose code is “LHR,” an appropriate description might be “London, Heathrow“. Use this key for any type of boarding pass.
  // localizable string
  @override
  @JsonKey(name: 'departureLocationDescription')
  String? departureLocationDescription;

  /// The name of the departure platform, such as “A”. Don’t include the word “Platform.” Use this key only for a train or other rail boarding pass.
  // localizable string
  @override
  @JsonKey(name: 'departurePlatform')
  String? departurePlatform;

  /// The name of the departure station, such as “1st Street Station”. Use this key only for a train or other rail boarding pass.
  // localizable string
  @override
  @JsonKey(name: 'departureStationName')
  String? departureStationName;

  /// The name or letter of the departure terminal, such as “A”. Don’t include the word “Terminal.” Use this key only for airline boarding passes.
  // localizable string
  @override
  @JsonKey(name: 'departureTerminal')
  String? departureTerminal;

  /// The IATA airport code for the destination airport, such as “MPM” or “LHR”. Use this key only for airline boarding passes.
  // localizable string
  @override
  @JsonKey(name: 'destinationAirportCode')
  String? destinationAirportCode;

  /// The full name of the destination airport, such as “London Heathrow”. Use this key only for airline boarding passes.
  // localizable string
  @override
  @JsonKey(name: 'destinationAirportName')
  String? destinationAirportName;

  /// The gate number or letter of the destination gate, such as “1A”. Don’t include the word “Gate.” Use this key only for airline boarding passes.
  // localizable string
  @override
  @JsonKey(name: 'destinationGate')
  String? destinationGate;

  /// An object that represents the geographic coordinates of the transit departure location, suitable for display on a map. Use this key for any type of boarding pass.
  @override
  @JsonKey(name: 'destinationLocation')
  SemanticTagTypeLocation? destinationLocation;

  /// A brief description of the destination location. For example, for a flight arriving at an airport whose code is “MPM,” “Maputo“ might be an appropriate description. Use this key for any type of boarding pass.
  // localizable string
  @override
  @JsonKey(name: 'destinationLocationDescription')
  String? destinationLocationDescription;

  /// The name of the destination platform, such as “A”. Don’t include the word “Platform.” Use this key only for a train or other rail boarding pass.
  // localizable string
  @override
  @JsonKey(name: 'destinationPlatform')
  String? destinationPlatform;

  /// The name of the destination station, such as “1st Street Station”. Use this key only for a train or other rail boarding pass.
  // localizable string
  @override
  @JsonKey(name: 'destinationStationName')
  String? destinationStationName;

  /// The terminal name or letter of the destination terminal, such as “A”. Don’t include the word “Terminal.” Use this key only for airline boarding passes.
  // localizable string
  @override
  @JsonKey(name: 'destinationTerminal')
  String? destinationTerminal;

  /// The duration of the event or transit journey, in seconds. Use this key for any type of boarding pass and any type of event ticket.
  @override
  @JsonKey(name: 'duration')
  num? duration;

  /// The date and time the event ends. Use this key for any type of event ticket.
  // ISO 8601 date as string
  @override
  @JsonKey(name: 'eventEndDate')
  DateTime? eventEndDate;

  /// The full name of the event, such as the title of a movie. Use this key for any type of event ticket.
  // localizable string
  @override
  @JsonKey(name: 'eventName')
  String? eventName;

  /// The date and time the event starts. Use this key for any type of event ticket.
  // ISO 8601 date as string
  @override
  @JsonKey(name: 'eventStartDate')
  DateTime? eventStartDate;

  /// The type of event. Use this key for any type of event ticket.
  /// Possible Values: PKEventTypeGeneric, PKEventTypeLivePerformance, PKEventTypeMovie, PKEventTypeSports, PKEventTypeConference, PKEventTypeConvention, PKEventTypeWorkshop, PKEventTypeSocialGathering
  @override
  @JsonKey(name: 'eventType')
  EventType? eventType;

  /// The IATA flight code, such as “EX123”. Use this key only for airline boarding passes.
  // localizable string
  @override
  @JsonKey(name: 'flightCode')
  String? flightCode;

  /// The numeric portion of the IATA flight code, such as 123 for flightCode “EX123”. Use this key only for airline boarding passes.
  @override
  @JsonKey(name: 'flightNumber')
  num? flightNumber;

  /// The genre of the performance, such as “Classical”. Use this key for any type of event ticket.
  // localizable string
  @override
  @JsonKey(name: 'genre')
  String? genre;

  /// The unique abbreviation of the home team’s name. Use this key only for a sports event ticket.
  // localizable string
  @override
  @JsonKey(name: 'homeTeamAbbreviation')
  String? homeTeamAbbreviation;

  /// The home location of the home team. Use this key only for a sports event ticket.
  // localizable string
  @override
  @JsonKey(name: 'homeTeamLocation')
  String? homeTeamLocation;

  /// The name of the home team. Use this key only for a sports event ticket.
  // localizable string
  @override
  @JsonKey(name: 'homeTeamName')
  String? homeTeamName;

  /// The abbreviated league name for a sports event. Use this key only for a sports event ticket.
  // localizable string
  @override
  @JsonKey(name: 'leagueAbbreviation')
  String? leagueAbbreviation;

  /// The unabbreviated league name for a sports event. Use this key only for a sports event ticket.
  // localizable string
  @override
  @JsonKey(name: 'leagueName')
  String? leagueName;

  /// The name of a frequent flyer or loyalty program. Use this key for any type of boarding pass.
  // localizable string
  @override
  @JsonKey(name: 'membershipProgramName')
  String? membershipProgramName;

  /// The ticketed passenger’s frequent flyer or loyalty number. Use this key for any type of boarding pass.
  // localizable string
  @override
  @JsonKey(name: 'membershipProgramNumber')
  String? membershipProgramNumber;

  /// The originally scheduled date and time of arrival. Use this key for any type of boarding pass.
  // ISO 8601 date as string
  @override
  @JsonKey(name: 'originalArrivalDate')
  DateTime? originalArrivalDate;

  /// The originally scheduled date and time of boarding. Use this key for any type of boarding pass.
  // ISO 8601 date as string
  @override
  @JsonKey(name: 'originalBoardingDate')
  DateTime? originalBoardingDate;

  /// The originally scheduled date and time of departure. Use this key for any type of boarding pass.
  // ISO 8601 date as string
  @override
  @JsonKey(name: 'originalDepartureDate')
  DateTime? originalDepartureDate;

  /// An object that represents the name of the passenger. Use this key for any type of boarding pass.
  @override
  @JsonKey(name: 'passengerName')
  SemanticTagTypePersonNameComponents? passengerName;

  /// An array of the full names of the performers and opening acts at the event, in decreasing order of significance. Use this key for any type of event ticket.
  // [localizable string]
  @override
  @JsonKey(name: 'performerNames')
  List<String>? performerNames;

  /// The priority status the ticketed passenger holds, such as “Gold” or “Silver”. Use this key for any type of boarding pass.
  // localizable string
  @override
  @JsonKey(name: 'priorityStatus')
  String? priorityStatus;

  /// An array of objects that represent the details for each seat at an event or on a transit journey. Use this key for any type of boarding pass or event ticket.
  @override
  @JsonKey(name: 'seats')
  List<SemanticTagTypeSeat>? seats;

  /// The type of security screening for the ticketed passenger, such as “Priority”. Use this key for any type of boarding pass.
  // localizable string
  @override
  @JsonKey(name: 'securityScreening')
  String? securityScreening;

  /// A Boolean value that determines whether the user’s device remains silent during an event or transit journey. The system may override the key and determine the length of the period of silence. Use this key for any type of boarding pass or event ticket.
  @override
  @JsonKey(name: 'silenceRequested')
  bool? silenceRequested;

  /// The commonly used name of the sport. Use this key only for a sports event ticket.
  // localizable string
  @override
  @JsonKey(name: 'sportName')
  String? sportName;

  /// The total price for the pass. Use this key for any pass type.
  @override
  @JsonKey(name: 'totalPrice')
  SemanticTagTypeCurrencyAmount? totalPrice;

  /// The name of the transit company. Use this key for any type of boarding pass.
  // localizable string
  @override
  @JsonKey(name: 'transitProvider')
  String? transitProvider;

  /// A brief description of the current boarding status for the vessel, such as “On Time” or “Delayed”. For delayed status, provide currentBoardingDate, currentDepartureDate, and currentArrivalDate where available. Use this key for any type of boarding pass.
  // localizable string
  @override
  @JsonKey(name: 'transitStatus')
  String? transitStatus;

  /// A brief description that explains the reason for the current transitStatus, such as “Thunderstorms”. Use this key for any type of boarding pass.
  // localizable string
  @override
  @JsonKey(name: 'transitStatusReason')
  String? transitStatusReason;

  /// The name of the vehicle to board, such as the name of a boat. Use this key for any type of boarding pass.
  // localizable string
  @override
  @JsonKey(name: 'vehicleName')
  String? vehicleName;

  /// The identifier of the vehicle to board, such as the aircraft registration number or train number. Use this key for any type of boarding pass.
  // localizable string
  @override
  @JsonKey(name: 'vehicleNumber')
  String? vehicleNumber;

  /// A brief description of the type of vehicle to board, such as the model and manufacturer of a plane or the class of a boat. Use this key for any type of boarding pass.
  // localizable string
  @override
  @JsonKey(name: 'vehicleType')
  String? vehicleType;

  /// The full name of the entrance, such as “Gate A”, to use to gain access to the ticketed event. Use this key for any type of event ticket.
  // localizable string
  @override
  @JsonKey(name: 'venueEntrance')
  String? venueEntrance;

  /// An object that represents the geographic coordinates of the venue. Use this key for any type of event ticket.
  @override
  @JsonKey(name: 'venueLocation')
  SemanticTagTypeLocation? venueLocation;

  /// The full name of the venue. Use this key for any type of event ticket.
  // localizable string
  @override
  @JsonKey(name: 'venueName')
  String? venueName;

  /// The phone number for enquiries about the venue’s ticketed event. Use this key for any type of event ticket.
  // localizable string
  @override
  @JsonKey(name: 'venuePhoneNumber')
  String? venuePhoneNumber;

  /// The full name of the room where the ticketed event is to take place. Use this key for any type of event ticket.
  // localizable string
  @override
  @JsonKey(name: 'venueRoom')
  String? venueRoom;

  /// An array of objects that represent the WiFi networks associated with the event; for example, the network name and password associated with a developer conference. Use this key for any type of pass.
  @override
  @JsonKey(name: 'wifiAccess')
  List<SemanticTagTypeWifiNetwork>? wifiAccess;

  Semantics copyWith({
    String? airlineCode,
    List<String>? artistIDs,
    String? awayTeamAbbreviation,
    String? awayTeamLocation,
    String? awayTeamName,
    SemanticTagTypeCurrencyAmount? balance,
    String? boardingGroup,
    String? boardingSequenceNumber,
    String? carNumber,
    String? confirmationNumber,
    DateTime? currentArrivalDate,
    DateTime? currentBoardingDate,
    DateTime? currentDepartureDate,
    String? departureAirportCode,
    String? departureAirportName,
    String? departureGate,
    SemanticTagTypeLocation? departureLocation,
    String? departureLocationDescription,
    String? departurePlatform,
    String? departureStationName,
    String? departureTerminal,
    String? destinationAirportCode,
    String? destinationAirportName,
    String? destinationGate,
    SemanticTagTypeLocation? destinationLocation,
    String? destinationLocationDescription,
    String? destinationPlatform,
    String? destinationStationName,
    String? destinationTerminal,
    num? duration,
    DateTime? eventEndDate,
    String? eventName,
    DateTime? eventStartDate,
    EventType? eventType,
    String? flightCode,
    num? flightNumber,
    String? genre,
    String? homeTeamAbbreviation,
    String? homeTeamLocation,
    String? homeTeamName,
    String? leagueAbbreviation,
    String? leagueName,
    String? membershipProgramName,
    String? membershipProgramNumber,
    DateTime? originalArrivalDate,
    DateTime? originalBoardingDate,
    DateTime? originalDepartureDate,
    SemanticTagTypePersonNameComponents? passengerName,
    List<String>? performerNames,
    String? priorityStatus,
    List<SemanticTagTypeSeat>? seats,
    String? securityScreening,
    bool? silenceRequested,
    String? sportName,
    SemanticTagTypeCurrencyAmount? totalPrice,
    String? transitProvider,
    String? transitStatus,
    String? transitStatusReason,
    String? vehicleName,
    String? vehicleNumber,
    String? vehicleType,
    String? venueEntrance,
    SemanticTagTypeLocation? venueLocation,
    String? venueName,
    String? venuePhoneNumber,
    String? venueRoom,
    List<SemanticTagTypeWifiNetwork>? wifiAccess,
  }) {
    return Semantics(
      airlineCode: airlineCode ?? this.airlineCode,
      artistIDs: artistIDs ?? this.artistIDs,
      awayTeamAbbreviation: awayTeamAbbreviation ?? this.awayTeamAbbreviation,
      awayTeamLocation: awayTeamLocation ?? this.awayTeamLocation,
      awayTeamName: awayTeamName ?? this.awayTeamName,
      balance: balance ?? this.balance,
      boardingGroup: boardingGroup ?? this.boardingGroup,
      boardingSequenceNumber:
          boardingSequenceNumber ?? this.boardingSequenceNumber,
      carNumber: carNumber ?? this.carNumber,
      confirmationNumber: confirmationNumber ?? this.confirmationNumber,
      currentArrivalDate: currentArrivalDate ?? this.currentArrivalDate,
      currentBoardingDate: currentBoardingDate ?? this.currentBoardingDate,
      currentDepartureDate: currentDepartureDate ?? this.currentDepartureDate,
      departureAirportCode: departureAirportCode ?? this.departureAirportCode,
      departureAirportName: departureAirportName ?? this.departureAirportName,
      departureGate: departureGate ?? this.departureGate,
      departureLocation: departureLocation ?? this.departureLocation,
      departureLocationDescription:
          departureLocationDescription ?? this.departureLocationDescription,
      departurePlatform: departurePlatform ?? this.departurePlatform,
      departureStationName: departureStationName ?? this.departureStationName,
      departureTerminal: departureTerminal ?? this.departureTerminal,
      destinationAirportCode:
          destinationAirportCode ?? this.destinationAirportCode,
      destinationAirportName:
          destinationAirportName ?? this.destinationAirportName,
      destinationGate: destinationGate ?? this.destinationGate,
      destinationLocation: destinationLocation ?? this.destinationLocation,
      destinationLocationDescription:
          destinationLocationDescription ?? this.destinationLocationDescription,
      destinationPlatform: destinationPlatform ?? this.destinationPlatform,
      destinationStationName:
          destinationStationName ?? this.destinationStationName,
      destinationTerminal: destinationTerminal ?? this.destinationTerminal,
      duration: duration ?? this.duration,
      eventEndDate: eventEndDate ?? this.eventEndDate,
      eventName: eventName ?? this.eventName,
      eventStartDate: eventStartDate ?? this.eventStartDate,
      eventType: eventType ?? this.eventType,
      flightCode: flightCode ?? this.flightCode,
      flightNumber: flightNumber ?? this.flightNumber,
      genre: genre ?? this.genre,
      homeTeamAbbreviation: homeTeamAbbreviation ?? this.homeTeamAbbreviation,
      homeTeamLocation: homeTeamLocation ?? this.homeTeamLocation,
      homeTeamName: homeTeamName ?? this.homeTeamName,
      leagueAbbreviation: leagueAbbreviation ?? this.leagueAbbreviation,
      leagueName: leagueName ?? this.leagueName,
      membershipProgramName:
          membershipProgramName ?? this.membershipProgramName,
      membershipProgramNumber:
          membershipProgramNumber ?? this.membershipProgramNumber,
      originalArrivalDate: originalArrivalDate ?? this.originalArrivalDate,
      originalBoardingDate: originalBoardingDate ?? this.originalBoardingDate,
      originalDepartureDate:
          originalDepartureDate ?? this.originalDepartureDate,
      passengerName: passengerName ?? this.passengerName,
      performerNames: performerNames ?? this.performerNames,
      priorityStatus: priorityStatus ?? this.priorityStatus,
      seats: seats ?? this.seats,
      securityScreening: securityScreening ?? this.securityScreening,
      silenceRequested: silenceRequested ?? this.silenceRequested,
      sportName: sportName ?? this.sportName,
      totalPrice: totalPrice ?? this.totalPrice,
      transitProvider: transitProvider ?? this.transitProvider,
      transitStatus: transitStatus ?? this.transitStatus,
      transitStatusReason: transitStatusReason ?? this.transitStatusReason,
      vehicleName: vehicleName ?? this.vehicleName,
      vehicleNumber: vehicleNumber ?? this.vehicleNumber,
      vehicleType: vehicleType ?? this.vehicleType,
      venueEntrance: venueEntrance ?? this.venueEntrance,
      venueLocation: venueLocation ?? this.venueLocation,
      venueName: venueName ?? this.venueName,
      venuePhoneNumber: venuePhoneNumber ?? this.venuePhoneNumber,
      venueRoom: venueRoom ?? this.venueRoom,
      wifiAccess: wifiAccess ?? this.wifiAccess,
    );
  }
}

enum EventType {
  @JsonValue('PKEventTypeGeneric')
  generic,

  @JsonValue('PKEventTypeLivePerformance')
  livePerformance,

  @JsonValue('PKEventTypeMovie')
  movie,

  @JsonValue('PKEventTypeSports')
  sports,

  @JsonValue('PKEventTypeConference')
  conference,

  @JsonValue('PKEventTypeConvention')
  convention,

  @JsonValue('PKEventTypeWorkshop')
  workshop,

  @JsonValue('PKEventTypeSocialGathering')
  socialGathering,
}

abstract class ReadOnlySemantics {
  /// The IATA airline code, such as “EX” for flightCode “EX123”.
  /// Use this key only for airline boarding passes.
  // localizable string
  String? get airlineCode;

  /// An array of the Apple Music persistent ID for each artist performing at the event, in decreasing order of significance.
  /// Use this key for any type of event ticket.
  // [localizable string]
  List<String>? get artistIDs;

  /// The unique abbreviation of the away team’s name. Use this key only for a sports event ticket.
  // localizable string
  String? get awayTeamAbbreviation;

  /// The home location of the away team. Use this key only for a sports event ticket.
  // localizable string
  String? get awayTeamLocation;

  /// The name of the away team. Use this key only for a sports event ticket.
  // localizable string
  String? get awayTeamName;

  /// The current balance redeemable with the pass. Use this key only for a store card pass.
  SemanticTagTypeCurrencyAmount? get balance;

  /// A group number for boarding. Use this key for any type of boarding pass.
  // localizable string
  String? get boardingGroup;

  /// A sequence number for boarding. Use this key for any type of boarding pass.
  // localizable string
  String? get boardingSequenceNumber;

  /// The number of the passenger car. A train car is also called a carriage, wagon, coach, or bogie in some countries. Use this key only for a train or other rail boarding pass.
  // localizable string
  String? get carNumber;

  /// A booking or reservation confirmation number. Use this key for any type of boarding pass.
  // localizable string
  String? get confirmationNumber;

  /// The updated date and time of arrival, if different from the originally scheduled date and time. Use this key for any type of boarding pass.
  // ISO 8601 date as string
  DateTime? get currentArrivalDate;

  /// The updated date and time of boarding, if different from the originally scheduled date and time. Use this key for any type of boarding pass.
  // ISO 8601 date as string
  DateTime? get currentBoardingDate;

  /// The updated departure date and time, if different from the originally scheduled date and time. Use this key for any type of boarding pass.
  // ISO 8601 date as string
  DateTime? get currentDepartureDate;

  /// The IATA airport code for the departure airport, such as “MPM” or “LHR”. Use this key only for airline boarding passes.
  // localizable string
  String? get departureAirportCode;

  /// The full name of the departure airport, such as “Maputo International Airport”. Use this key only for airline boarding passes.
  // localizable string
  String? get departureAirportName;

  /// The gate number or letters of the departure gate, such as “1A”. Do not include the word “Gate.”
  // localizable string
  String? get departureGate;

  /// An object that represents the geographic coordinates of the transit departure location, suitable for display on a map. If possible, use precise locations, which are more useful to travelers; for example, the specific location of an airport gate. Use this key for any type of boarding pass.
  SemanticTagTypeLocation? get departureLocation;

  /// A brief description of the departure location. For example, for a flight departing from an airport whose code is “LHR,” an appropriate description might be “London, Heathrow“. Use this key for any type of boarding pass.
  // localizable string
  String? get departureLocationDescription;

  /// The name of the departure platform, such as “A”. Don’t include the word “Platform.” Use this key only for a train or other rail boarding pass.
  // localizable string
  String? get departurePlatform;

  /// The name of the departure station, such as “1st Street Station”. Use this key only for a train or other rail boarding pass.
  // localizable string
  String? get departureStationName;

  /// The name or letter of the departure terminal, such as “A”. Don’t include the word “Terminal.” Use this key only for airline boarding passes.
  // localizable string
  String? get departureTerminal;

  /// The IATA airport code for the destination airport, such as “MPM” or “LHR”. Use this key only for airline boarding passes.
  // localizable string
  String? get destinationAirportCode;

  /// The full name of the destination airport, such as “London Heathrow”. Use this key only for airline boarding passes.
  // localizable string
  String? get destinationAirportName;

  /// The gate number or letter of the destination gate, such as “1A”. Don’t include the word “Gate.” Use this key only for airline boarding passes.
  // localizable string
  String? get destinationGate;

  /// An object that represents the geographic coordinates of the transit departure location, suitable for display on a map. Use this key for any type of boarding pass.
  SemanticTagTypeLocation? get destinationLocation;

  /// A brief description of the destination location. For example, for a flight arriving at an airport whose code is “MPM,” “Maputo“ might be an appropriate description. Use this key for any type of boarding pass.
  // localizable string
  String? get destinationLocationDescription;

  /// The name of the destination platform, such as “A”. Don’t include the word “Platform.” Use this key only for a train or other rail boarding pass.
  // localizable string
  String? get destinationPlatform;

  /// The name of the destination station, such as “1st Street Station”. Use this key only for a train or other rail boarding pass.
  // localizable string
  String? get destinationStationName;

  /// The terminal name or letter of the destination terminal, such as “A”. Don’t include the word “Terminal.” Use this key only for airline boarding passes.
  // localizable string
  String? get destinationTerminal;

  /// The duration of the event or transit journey, in seconds. Use this key for any type of boarding pass and any type of event ticket.
  num? get duration;

  /// The date and time the event ends. Use this key for any type of event ticket.
  // ISO 8601 date as string
  DateTime? get eventEndDate;

  /// The full name of the event, such as the title of a movie. Use this key for any type of event ticket.
  // localizable string
  String? get eventName;

  /// The date and time the event starts. Use this key for any type of event ticket.
  // ISO 8601 date as string
  DateTime? get eventStartDate;

  /// The type of event. Use this key for any type of event ticket.
  /// Possible Values: PKEventTypeGeneric, PKEventTypeLivePerformance, PKEventTypeMovie, PKEventTypeSports, PKEventTypeConference, PKEventTypeConvention, PKEventTypeWorkshop, PKEventTypeSocialGathering
  EventType? get eventType;

  /// The IATA flight code, such as “EX123”. Use this key only for airline boarding passes.
  // localizable string
  String? get flightCode;

  /// The numeric portion of the IATA flight code, such as 123 for flightCode “EX123”. Use this key only for airline boarding passes.
  num? get flightNumber;

  /// The genre of the performance, such as “Classical”. Use this key for any type of event ticket.
  // localizable string
  String? get genre;

  /// The unique abbreviation of the home team’s name. Use this key only for a sports event ticket.
  // localizable string
  String? get homeTeamAbbreviation;

  /// The home location of the home team. Use this key only for a sports event ticket.
  // localizable string
  String? get homeTeamLocation;

  /// The name of the home team. Use this key only for a sports event ticket.
  // localizable string
  String? get homeTeamName;

  /// The abbreviated league name for a sports event. Use this key only for a sports event ticket.
  // localizable string
  String? get leagueAbbreviation;

  /// The unabbreviated league name for a sports event. Use this key only for a sports event ticket.
  // localizable string
  String? get leagueName;

  /// The name of a frequent flyer or loyalty program. Use this key for any type of boarding pass.
  // localizable string
  String? get membershipProgramName;

  /// The ticketed passenger’s frequent flyer or loyalty number. Use this key for any type of boarding pass.
  // localizable string
  String? get membershipProgramNumber;

  /// The originally scheduled date and time of arrival. Use this key for any type of boarding pass.
  // ISO 8601 date as string
  DateTime? get originalArrivalDate;

  /// The originally scheduled date and time of boarding. Use this key for any type of boarding pass.
  // ISO 8601 date as string
  DateTime? get originalBoardingDate;

  /// The originally scheduled date and time of departure. Use this key for any type of boarding pass.
  // ISO 8601 date as string
  DateTime? get originalDepartureDate;

  /// An object that represents the name of the passenger. Use this key for any type of boarding pass.
  SemanticTagTypePersonNameComponents? get passengerName;

  /// An array of the full names of the performers and opening acts at the event, in decreasing order of significance. Use this key for any type of event ticket.
  // [localizable string]
  List<String>? get performerNames;

  /// The priority status the ticketed passenger holds, such as “Gold” or “Silver”. Use this key for any type of boarding pass.
  // localizable string
  String? get priorityStatus;

  /// An array of objects that represent the details for each seat at an event or on a transit journey. Use this key for any type of boarding pass or event ticket.
  List<SemanticTagTypeSeat>? get seats;

  /// The type of security screening for the ticketed passenger, such as “Priority”. Use this key for any type of boarding pass.
  // localizable string
  String? get securityScreening;

  /// A Boolean value that determines whether the user’s device remains silent during an event or transit journey. The system may override the key and determine the length of the period of silence. Use this key for any type of boarding pass or event ticket.
  bool? get silenceRequested;

  /// The commonly used name of the sport. Use this key only for a sports event ticket.
  // localizable string
  String? get sportName;

  /// The total price for the pass. Use this key for any pass type.
  SemanticTagTypeCurrencyAmount? get totalPrice;

  /// The name of the transit company. Use this key for any type of boarding pass.
  // localizable string
  String? get transitProvider;

  /// A brief description of the current boarding status for the vessel, such as “On Time” or “Delayed”. For delayed status, provide currentBoardingDate, currentDepartureDate, and currentArrivalDate where available. Use this key for any type of boarding pass.
  // localizable string
  String? get transitStatus;

  /// A brief description that explains the reason for the current transitStatus, such as “Thunderstorms”. Use this key for any type of boarding pass.
  // localizable string
  String? get transitStatusReason;

  /// The name of the vehicle to board, such as the name of a boat. Use this key for any type of boarding pass.
  // localizable string
  String? get vehicleName;

  /// The identifier of the vehicle to board, such as the aircraft registration number or train number. Use this key for any type of boarding pass.
  // localizable string
  String? get vehicleNumber;

  /// A brief description of the type of vehicle to board, such as the model and manufacturer of a plane or the class of a boat. Use this key for any type of boarding pass.
  // localizable string
  String? get vehicleType;

  /// The full name of the entrance, such as “Gate A”, to use to gain access to the ticketed event. Use this key for any type of event ticket.
  // localizable string
  String? get venueEntrance;

  /// An object that represents the geographic coordinates of the venue. Use this key for any type of event ticket.
  SemanticTagTypeLocation? get venueLocation;

  /// The full name of the venue. Use this key for any type of event ticket.
  // localizable string
  String? get venueName;

  /// The phone number for enquiries about the venue’s ticketed event. Use this key for any type of event ticket.
  // localizable string
  String? get venuePhoneNumber;

  /// The full name of the room where the ticketed event is to take place. Use this key for any type of event ticket.
  // localizable string
  String? get venueRoom;

  /// An array of objects that represent the WiFi networks associated with the event; for example, the network name and password associated with a developer conference. Use this key for any type of pass.
  List<SemanticTagTypeWifiNetwork>? get wifiAccess;
}

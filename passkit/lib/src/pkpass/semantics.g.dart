// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'semantics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Semantics _$SemanticsFromJson(Map<String, dynamic> json) => Semantics(
      airlineCode: json['airlineCode'] as String?,
      artistIDs: (json['artistIDs'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      awayTeamAbbreviation: json['awayTeamAbbreviation'] as String?,
      awayTeamLocation: json['awayTeamLocation'] as String?,
      awayTeamName: json['awayTeamName'] as String?,
      boardingGroup: json['boardingGroup'] as String?,
      boardingSequenceNumber: json['boardingSequenceNumber'] as String?,
      carNumber: json['carNumber'] as String?,
      confirmationNumber: json['confirmationNumber'] as String?,
      currentArrivalDate: json['currentArrivalDate'] == null
          ? null
          : DateTime.parse(json['currentArrivalDate'] as String),
      currentBoardingDate: json['currentBoardingDate'] == null
          ? null
          : DateTime.parse(json['currentBoardingDate'] as String),
      currentDepartureDate: json['currentDepartureDate'] == null
          ? null
          : DateTime.parse(json['currentDepartureDate'] as String),
      departureAirportCode: json['departureAirportCode'] as String?,
      departureAirportName: json['departureAirportName'] as String?,
      departureGate: json['departureGate'] as String?,
      departureLocationDescription:
          json['departureLocationDescription'] as String?,
      departurePlatform: json['departurePlatform'] as String?,
      departureStationName: json['departureStationName'] as String?,
      departureTerminal: json['departureTerminal'] as String?,
      destinationAirportCode: json['destinationAirportCode'] as String?,
      destinationAirportName: json['destinationAirportName'] as String?,
      destinationGate: json['destinationGate'] as String?,
      destinationLocationDescription:
          json['destinationLocationDescription'] as String?,
      destinationPlatform: json['destinationPlatform'] as String?,
      destinationStationName: json['destinationStationName'] as String?,
      destinationTerminal: json['destinationTerminal'] as String?,
      duration: json['duration'] as num?,
      eventEndDate: json['eventEndDate'] == null
          ? null
          : DateTime.parse(json['eventEndDate'] as String),
      eventName: json['eventName'] as String?,
      eventStartDate: json['eventStartDate'] == null
          ? null
          : DateTime.parse(json['eventStartDate'] as String),
      eventType: $enumDecodeNullable(_$EventTypeEnumMap, json['eventType']),
      flightCode: json['flightCode'] as String?,
      flightNumber: json['flightNumber'] as num?,
      genre: json['genre'] as String?,
      homeTeamAbbreviation: json['homeTeamAbbreviation'] as String?,
      homeTeamLocation: json['homeTeamLocation'] as String?,
      homeTeamName: json['homeTeamName'] as String?,
      leagueAbbreviation: json['leagueAbbreviation'] as String?,
      leagueName: json['leagueName'] as String?,
      membershipProgramName: json['membershipProgramName'] as String?,
      membershipProgramNumber: json['membershipProgramNumber'] as String?,
      originalArrivalDate: json['originalArrivalDate'] == null
          ? null
          : DateTime.parse(json['originalArrivalDate'] as String),
      originalBoardingDate: json['originalBoardingDate'] == null
          ? null
          : DateTime.parse(json['originalBoardingDate'] as String),
      originalDepartureDate: json['originalDepartureDate'] == null
          ? null
          : DateTime.parse(json['originalDepartureDate'] as String),
      performerNames: (json['performerNames'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      priorityStatus: json['priorityStatus'] as String?,
      securityScreening: json['securityScreening'] as String?,
      silenceRequested: json['silenceRequested'] as bool?,
      sportName: json['sportName'] as String?,
      transitProvider: json['transitProvider'] as String?,
      transitStatus: json['transitStatus'] as String?,
      transitStatusReason: json['transitStatusReason'] as String?,
      vehicleName: json['vehicleName'] as String?,
      vehicleNumber: json['vehicleNumber'] as String?,
      vehicleType: json['vehicleType'] as String?,
      venueEntrance: json['venueEntrance'] as String?,
      venueName: json['venueName'] as String?,
      venuePhoneNumber: json['venuePhoneNumber'] as String?,
      venueRoom: json['venueRoom'] as String?,
      balance: json['balance'] == null
          ? null
          : SemanticTagTypeCurrencyAmount.fromJson(
              json['balance'] as Map<String, dynamic>),
      departureLocation: json['departureLocation'] == null
          ? null
          : SemanticTagTypeLocation.fromJson(
              json['departureLocation'] as Map<String, dynamic>),
      destinationLocation: json['destinationLocation'] == null
          ? null
          : SemanticTagTypeLocation.fromJson(
              json['destinationLocation'] as Map<String, dynamic>),
      seats: (json['seats'] as List<dynamic>?)
          ?.map((e) => SemanticTagTypeSeat.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: json['totalPrice'] == null
          ? null
          : SemanticTagTypeCurrencyAmount.fromJson(
              json['totalPrice'] as Map<String, dynamic>),
      venueLocation: json['venueLocation'] == null
          ? null
          : SemanticTagTypeLocation.fromJson(
              json['venueLocation'] as Map<String, dynamic>),
      wifiAccess: (json['wifiAccess'] as List<dynamic>?)
          ?.map((e) =>
              SemanticTagTypeWifiNetwork.fromJson(e as Map<String, dynamic>))
          .toList(),
      passengerName: json['passengerName'] == null
          ? null
          : SemanticTagTypePersonNameComponents.fromJson(
              json['passengerName'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SemanticsToJson(Semantics instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('airlineCode', instance.airlineCode);
  writeNotNull('artistIDs', instance.artistIDs);
  writeNotNull('awayTeamAbbreviation', instance.awayTeamAbbreviation);
  writeNotNull('awayTeamLocation', instance.awayTeamLocation);
  writeNotNull('awayTeamName', instance.awayTeamName);
  writeNotNull('balance', instance.balance);
  writeNotNull('boardingGroup', instance.boardingGroup);
  writeNotNull('boardingSequenceNumber', instance.boardingSequenceNumber);
  writeNotNull('carNumber', instance.carNumber);
  writeNotNull('confirmationNumber', instance.confirmationNumber);
  writeNotNull(
      'currentArrivalDate', instance.currentArrivalDate?.toIso8601String());
  writeNotNull(
      'currentBoardingDate', instance.currentBoardingDate?.toIso8601String());
  writeNotNull(
      'currentDepartureDate', instance.currentDepartureDate?.toIso8601String());
  writeNotNull('departureAirportCode', instance.departureAirportCode);
  writeNotNull('departureAirportName', instance.departureAirportName);
  writeNotNull('departureGate', instance.departureGate);
  writeNotNull('departureLocation', instance.departureLocation);
  writeNotNull(
      'departureLocationDescription', instance.departureLocationDescription);
  writeNotNull('departurePlatform', instance.departurePlatform);
  writeNotNull('departureStationName', instance.departureStationName);
  writeNotNull('departureTerminal', instance.departureTerminal);
  writeNotNull('destinationAirportCode', instance.destinationAirportCode);
  writeNotNull('destinationAirportName', instance.destinationAirportName);
  writeNotNull('destinationGate', instance.destinationGate);
  writeNotNull('destinationLocation', instance.destinationLocation);
  writeNotNull('destinationLocationDescription',
      instance.destinationLocationDescription);
  writeNotNull('destinationPlatform', instance.destinationPlatform);
  writeNotNull('destinationStationName', instance.destinationStationName);
  writeNotNull('destinationTerminal', instance.destinationTerminal);
  writeNotNull('duration', instance.duration);
  writeNotNull('eventEndDate', instance.eventEndDate?.toIso8601String());
  writeNotNull('eventName', instance.eventName);
  writeNotNull('eventStartDate', instance.eventStartDate?.toIso8601String());
  writeNotNull('eventType', _$EventTypeEnumMap[instance.eventType]);
  writeNotNull('flightCode', instance.flightCode);
  writeNotNull('flightNumber', instance.flightNumber);
  writeNotNull('genre', instance.genre);
  writeNotNull('homeTeamAbbreviation', instance.homeTeamAbbreviation);
  writeNotNull('homeTeamLocation', instance.homeTeamLocation);
  writeNotNull('homeTeamName', instance.homeTeamName);
  writeNotNull('leagueAbbreviation', instance.leagueAbbreviation);
  writeNotNull('leagueName', instance.leagueName);
  writeNotNull('membershipProgramName', instance.membershipProgramName);
  writeNotNull('membershipProgramNumber', instance.membershipProgramNumber);
  writeNotNull(
      'originalArrivalDate', instance.originalArrivalDate?.toIso8601String());
  writeNotNull(
      'originalBoardingDate', instance.originalBoardingDate?.toIso8601String());
  writeNotNull('originalDepartureDate',
      instance.originalDepartureDate?.toIso8601String());
  writeNotNull('passengerName', instance.passengerName);
  writeNotNull('performerNames', instance.performerNames);
  writeNotNull('priorityStatus', instance.priorityStatus);
  writeNotNull('seats', instance.seats);
  writeNotNull('securityScreening', instance.securityScreening);
  writeNotNull('silenceRequested', instance.silenceRequested);
  writeNotNull('sportName', instance.sportName);
  writeNotNull('totalPrice', instance.totalPrice);
  writeNotNull('transitProvider', instance.transitProvider);
  writeNotNull('transitStatus', instance.transitStatus);
  writeNotNull('transitStatusReason', instance.transitStatusReason);
  writeNotNull('vehicleName', instance.vehicleName);
  writeNotNull('vehicleNumber', instance.vehicleNumber);
  writeNotNull('vehicleType', instance.vehicleType);
  writeNotNull('venueEntrance', instance.venueEntrance);
  writeNotNull('venueLocation', instance.venueLocation);
  writeNotNull('venueName', instance.venueName);
  writeNotNull('venuePhoneNumber', instance.venuePhoneNumber);
  writeNotNull('venueRoom', instance.venueRoom);
  writeNotNull('wifiAccess', instance.wifiAccess);
  return val;
}

const _$EventTypeEnumMap = {
  EventType.generic: 'PKEventTypeGeneric',
  EventType.livePerformance: 'PKEventTypeLivePerformance',
  EventType.movie: 'PKEventTypeMovie',
  EventType.sports: 'PKEventTypeSports',
  EventType.conference: 'PKEventTypeConference',
  EventType.convention: 'PKEventTypeConvention',
  EventType.workshop: 'PKEventTypeWorkshop',
  EventType.socialGathering: 'PKEventTypeSocialGathering',
};

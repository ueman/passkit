import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/passkit_ui.dart';

final dummyPasses = {
  PassType.generic: PkPass(
    pass: PassData(
      description: 'Sample Generic Pass',
      organizationName: 'PassKit',
      serialNumber: '1234567890',
      teamIdentifier: 'TEAMID1234',
      foregroundColor: Colors.white.toCssColor(),
      backgroundColor: Colors.blue.toCssColor(),
      labelColor: Colors.yellow.toCssColor(),
      passTypeIdentifier: 'pass.com.example.generic',
      generic: PassStructure(
        primaryFields: [
          FieldDict(key: 'balance', label: 'Balance', value: '100.00'),
        ],
        secondaryFields: [
          FieldDict(key: 'name', label: 'Name', value: 'John Doe'),
        ],
      ),
    ),
  ),
  PassType.coupon: PkPass(
    pass: PassData(
      description: 'Sample Coupon',
      organizationName: 'PassKit',
      serialNumber: '1234567891',
      teamIdentifier: 'TEAMID1234',
      foregroundColor: Colors.white.toCssColor(),
      backgroundColor: Colors.green.toCssColor(),
      labelColor: Colors.lightGreenAccent.toCssColor(),
      passTypeIdentifier: 'pass.com.example.coupon',
      coupon: PassStructure(
        primaryFields: [
          FieldDict(key: 'offer', label: 'Offer', value: '20% Off'),
        ],
        secondaryFields: [
          FieldDict(key: 'expires', label: 'Expires', value: '2025-12-31'),
        ],
      ),
    ),
  ),
  PassType.storeCard: PkPass(
    pass: PassData(
      description: 'Sample Store Card',
      organizationName: 'PassKit',
      serialNumber: '1234567892',
      teamIdentifier: 'TEAMID1234',
      foregroundColor: Colors.black.toCssColor(),
      backgroundColor: Colors.white.toCssColor(),
      labelColor: Colors.grey.toCssColor(),
      passTypeIdentifier: 'pass.com.example.storecard',
      storeCard: PassStructure(
        primaryFields: [
          FieldDict(key: 'points', label: 'Points', value: '500'),
        ],
        secondaryFields: [
          FieldDict(key: 'member', label: 'Member', value: 'Gold'),
        ],
      ),
    ),
  ),
  PassType.eventTicket: PkPass(
    pass: PassData(
      description: 'Sample Event Ticket',
      organizationName: 'PassKit',
      serialNumber: '1234567893',
      teamIdentifier: 'TEAMID1234',
      foregroundColor: Colors.white.toCssColor(),
      backgroundColor: Colors.purple.toCssColor(),
      labelColor: Colors.pinkAccent.toCssColor(),
      passTypeIdentifier: 'pass.com.example.eventticket',
      eventTicket: PassStructure(
        primaryFields: [
          FieldDict(key: 'event', label: 'Event', value: 'Flutter Conf'),
        ],
        secondaryFields: [
          FieldDict(key: 'location', label: 'Location', value: 'Online'),
        ],
      ),
    ),
  ),
  PassType.boardingPass: PkPass(
    pass: PassData(
      description: 'Sample Boarding Pass',
      organizationName: 'PassKit Air',
      serialNumber: '1234567894',
      teamIdentifier: 'TEAMID1234',
      foregroundColor: Colors.white.toCssColor(),
      backgroundColor: Colors.red.toCssColor(),
      labelColor: Colors.orange.toCssColor(),
      passTypeIdentifier: 'pass.com.example.boardingpass',
      boardingPass: PassStructure(
        transitType: TransitType.air,
        primaryFields: [
          FieldDict(key: 'flight', label: 'Flight', value: 'PK123'),
        ],
        secondaryFields: [
          FieldDict(key: 'gate', label: 'Gate', value: 'A12'),
        ],
      ),
    ),
  ),
};

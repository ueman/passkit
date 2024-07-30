import 'package:json_annotation/json_annotation.dart';
import 'package:passkit/src/pkpass/field_dict.dart';

part 'pass_structure.g.dart';

/// Keys that define the structure of the pass.
/// These keys are used for all pass styles and partition the fields into the
/// various parts of the pass.
@JsonSerializable(includeIfNull: false)
class PassStructure {
  PassStructure({
    this.auxiliaryFields,
    this.backFields,
    this.headerFields,
    this.primaryFields,
    this.secondaryFields,
    this.transitType = TransitType.generic,
  });

  factory PassStructure.fromJson(Map<String, dynamic> json) =>
      _$PassStructureFromJson(json);

  Map<String, dynamic> toJson() => _$PassStructureToJson(this);

  /// Optional. Additional fields to be displayed on the front of the pass.
  // array of field dictionaries
  final List<FieldDict>? auxiliaryFields;

  /// Optional. Fields to be on the back of the pass.
  // array of field dictionaries
  final List<FieldDict>? backFields;

  /// Optional. Fields to be displayed in the header on the front of the pass.
  /// Use header fields sparingly; unlike all other fields, they remain visible
  /// when a stack of passes are displayed.
  // array of field dictionaries
  final List<FieldDict>? headerFields;

  /// Optional. Fields to be displayed prominently on the front of the pass.
  // array of field dictionaries
  final List<FieldDict>? primaryFields;

  /// Optional. Fields to be displayed on the front of the pass.
  // array of field dictionaries
  final List<FieldDict>? secondaryFields;

  /// Required for boarding passes; otherwise not allowed. Type of transit.
  /// Must be one of the following values: PKTransitTypeAir, PKTransitTypeBoat,
  /// PKTransitTypeBus, PKTransitTypeGeneric,PKTransitTypeTrain.
  @JsonKey(defaultValue: TransitType.generic)
  final TransitType transitType;
}

enum TransitType {
  @JsonValue('PKTransitTypeAir')
  air,
  @JsonValue('PKTransitTypeBoat')
  boat,
  @JsonValue('PKTransitTypeBus')
  bus,
  @JsonValue('PKTransitTypeGeneric')
  generic,
  @JsonValue('PKTransitTypeTrain')
  train
}

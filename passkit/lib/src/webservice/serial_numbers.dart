import 'package:json_annotation/json_annotation.dart';

part 'serial_numbers.g.dart';

@JsonSerializable()
class SerialNumbers {
  SerialNumbers({
    required this.serialNumbers,
    required this.lastUpdated,
  });

  factory SerialNumbers.fromJson(Map<String, dynamic> json) =>
      _$SerialNumbersFromJson(json);

  Map<String, dynamic> toJson() => _$SerialNumbersToJson(this);

  /// An array of serial numbers for the updated passes.
  final List<String> serialNumbers;

  /// A developer-defined string that contains a tag that indicates the
  /// modification time for the returned passes.
  ///
  /// You use the value of this key for the `previousLastUpdated` parameter of
  /// Get the List of Updatable Passes to return passes modified after the
  /// represented date and time.
  final String lastUpdated;
}

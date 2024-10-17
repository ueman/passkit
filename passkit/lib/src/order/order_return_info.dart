import 'package:json_annotation/json_annotation.dart';

part 'order_return_info.g.dart';

@JsonSerializable(includeIfNull: false)
class OrderReturnInfo {
  OrderReturnInfo({
    required this.returnPolicyURL,
    this.displayCountdown = false,
    this.returnDeadline,
    this.returnManagementURL,
    this.returnPolicyDescription,
  });

  /// Creates an instance of this class from a JSON object
  factory OrderReturnInfo.fromJson(Map<String, dynamic> json) =>
      _$OrderReturnInfoFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$OrderReturnInfoToJson(this);

  /// (Required) The URL where the customer can see the order return policy.
  @JsonKey(name: 'returnPolicyURL')
  final Uri returnPolicyURL;

  /// A Boolean value that indicates whether to display the return countdown
  /// until returnDeadline in the user interface. Use true if all of the items
  /// in the order are returnable until the returnDeadline.
  ///
  /// Default: false
  @JsonKey(name: 'displayCountdown')
  final bool displayCountdown;

  /// The date where the products can be partially or fully returned.
  /// The merchant can provide updates to an order that has a completed status
  /// until this date.
  ///
  /// Use ISO 8601 format.
  @JsonKey(name: 'returnDeadline')
  final DateTime? returnDeadline;

  /// The URL where the customer can initiate a return.
  @JsonKey(name: 'returnManagementURL')
  final Uri? returnManagementURL;

  /// A short description of the return policy. The merchant can include the
  /// common return window duration here.
  @JsonKey(name: 'returnPolicyDescription')
  final String? returnPolicyDescription;

  OrderReturnInfo copyWith({
    Uri? returnPolicyURL,
    bool? displayCountdown,
    DateTime? returnDeadline,
    Uri? returnManagementURL,
    String? returnPolicyDescription,
  }) {
    return OrderReturnInfo(
      returnPolicyURL: returnPolicyURL ?? this.returnPolicyURL,
      displayCountdown: displayCountdown ?? this.displayCountdown,
      returnDeadline: returnDeadline ?? this.returnDeadline,
      returnManagementURL: returnManagementURL ?? this.returnManagementURL,
      returnPolicyDescription:
          returnPolicyDescription ?? this.returnPolicyDescription,
    );
  }
}

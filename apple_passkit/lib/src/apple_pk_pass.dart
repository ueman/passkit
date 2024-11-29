/// Represents a PkPass
class ApplePkPass {
  ApplePkPass({
    required this.passType,
    required this.serialNumber,
    required this.passTypeIdentifier,
    required this.deviceName,
    required this.localizedName,
    required this.localizedDescription,
    required this.isRemotePass,
    required this.passUrl,
    required this.organizationName,
    required this.icon,
  });

  factory ApplePkPass.fromMap(Map<Object?, Object?> map) {
    return ApplePkPass(
      passType: PKPassType.fromJson(map['passType'] as String),
      serialNumber: map['serialNumber'] as String,
      passTypeIdentifier: map['passTypeIdentifier'] as String,
      deviceName: map['deviceName'] as String,
      localizedName: map['localizedName'] as String,
      localizedDescription: map['localizedDescription'] as String,
      isRemotePass: map['isRemotePass'] as bool,
      passUrl: map['passUrl'] as String?,
      organizationName: map['organizationName'] as String,
      icon: map['icon'] as List<int>,
    );
  }

  /// The pass’s type.
  final PKPassType passType;

  /// A value that uniquely identifies the pass.
  final String serialNumber;

  /// The pass’s pass type identifier.
  final String passTypeIdentifier;

  /// The name of the device that hosts the pass.
  final String deviceName;

  /// The localized name for the pass’s template.
  final String localizedName;

  /// The pass’s localized description.
  final String localizedDescription;

  /// A Boolean value that indicates whether the pass is on a paired device, such as an Apple Watch.
  final bool isRemotePass;

  /// The URL that opens the pass in the Wallet app.
  /// Use the [`openURL(_:)`](https://developer.apple.com/documentation/uikit/uiapplication/1622961-openurl) method to open the pass in the Wallet app.
  final String? passUrl;

  /// The name of the organization that creates the pass.
  final String organizationName;

  /// The pass icon. PNG encoded
  final List<int> icon;
}

/// Status after trying to add multiple passes.
enum PKPassType {
  /// A nonspecific pass type.
  any('18446744073709551615'),

  /// A pass that represents a barcode.
  barcode('0'),

  /// A pass that represents a credential that the device stores in the Secure Element.
  secureElement('1'),

  /// Deprecated, but maps to secureElement value
  payment('1');

  /// Constructor to initialize each enum case with a string representation of the integer value
  const PKPassType(this.value);

  /// A field to store the string value associated with each enum case (representing integers as strings)
  final String value;

  // Factory method to create an enum from a JSON value (string)
  static PKPassType fromJson(String jsonValue) {
    for (PKPassType type in PKPassType.values) {
      if (type.value == jsonValue) {
        return type;
      }
    }
    throw ArgumentError('Invalid PKPassType value: $jsonValue');
  }

  // Method to convert the enum case back to a string for JSON serialization
  String toJson() {
    return value;
  }

  @override
  String toString() {
    return value; // Return the string representation of the integer value
  }
}
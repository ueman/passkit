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

  factory ApplePkPass.fromMap(Map<Object, Object?> map) {
    return ApplePkPass(
      passType: map['passType'] as String,
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
  final String passType;

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

// TODO
enum PkPassType {
  /// A nonspecific pass type.
  any,

  /// A pass that represents a barcode.
  barcode,

  /// A pass that represents a credential that the device stores in the Secure Element.
  secureElement
}

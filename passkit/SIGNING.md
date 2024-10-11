# Signing a PkPass file

> [!WARNING]
> THIS SHOULD NOT BE USED WITHIN AN APP. 
> IT SHOULD ONLY BE USED SERVER SIDE, OTHERWISE YOU RISK EXPOSING YOUR CERTIFICATE AND PRIVATE KEY.

This guide assumes you're working on a macOS system.

# Passes

## Step 1: Get a Pass ID and Pass Certificate from the Apple Developer Portal

### Create a Pass Type Identifier
You build one or more groups of related passes, such as the tickets for different events. Each group has a unique pass type identifier, a reverse DNS string that identifies your organization, the kind of pass, and the group, such as `com.example-company.passes.ticket.event-4631A`.

Identify the individual passes in a group by assigning each a serial number. Each combination of pass identifier and serial number is one unique pass. Adding a pass with the same pass identifier and serial number as one that already exists on a users’ device overwrites the old one.

Create your pass type identifier in the Certificates, Identifiers & Profiles area of your Apple Developer account:

- Select Identifiers and then click Add (+).
- On the next screen, choose Pass Type IDs and click Continue.
- Enter a description and the reverse DNS string to create the identifier.

For more information on signing in to your account and creating identifiers, see [Developer Account Help](https://developer.apple.com/help/account/).

Set the `passTypeIdentifier` of Pass in the `pass.json` file to the identifier. Set the `serialNumber` key to the unique serial number for that identifier.

### Generate a Signing Certificate
Signing a pass requires a signing certificate for the pass type identifier. Before you can generate a signing certificate you need a certificate signing request (CSR). To learn how to generate a CSR, see [Create a certificate signing request](https://developer.apple.com/help/account/create-certificates/create-a-certificate-signing-request).

Generate the signing certificate in the Certificates, Identifiers & Profiles area of the Apple Developer portal.

- Select Certificates, and then click Add <kbd>+</kbd>.
- On the next screen, choose Pass Type ID Certificate and click Continue.
- Enter a name for the certificate and select the pass type ID from the dropdown menu.

Click continue and upload the certificate signing request (CSR).

After uploading the CSR, generate the certificate and download it to the machine used for signing the pass.

For more information on signing into your account and creating signing certificates, see [Developer Account Help](https://developer.apple.com/help/account/).

In case of error in this guide, please read the [official Apple Guide](https://developer.apple.com/documentation/walletpasses/building-a-pass).

At the end you should have a certificate and private key in <kbd>Keychain Access</kbd>.

## Step 2: Create `.pem` files

This is the important step!

Export your certificate and private key from <kbd>Keychain Access</kbd> as `Certificate.p12`. It will ask you to set a password.

You should replace `<your-password-here>` with your password in the following commands.
(The `--legacy` part at the end of the following command may or may not be needed depending on your openssl version)

Create the certificate `.pem` file.
```shell
openssl pkcs12 -in Certificates.p12 -clcerts -nokeys -out pass_certificate.pem -passin pass:<your-password-here> --legacy
```

Create the private key `.pem` file. Unfortunately, it's not yet possible to use a password protected private key file.
```shell
openssl pkcs12 -in Certificates.p12 -out private_key.pem -nocerts -nodes -passin pass:<your-password-here> --legacy
```

If the generated `.pem` files do not start with `-----BEGIN RSA PRIVATE KEY-----` (or similar) delete all lines that come before that.
Otherwise, the code can't decode the `.pem` files, and signing may fail.

Then you can the generated file to sign PkPass files:

```dart
final pass = PkPass(...);
final binaryData pass.write(
  certificatePem: File('pass_certificate.pem').readAsStringSync(),
  privateKeyPem: File('private_key.pem').readAsStringSync(),
);
File('pass.pkpass').writeAsBytesSync(binaryData); // The file ending is important
```

Make sure that the pass type identifier and the team identifier matche your certificate.

# Orders

## Step 1: Get an ID and certificate from the Apple Developer Portal

### Create an order type identifier
An order type identifier is a unique identifier for your company or brand. Create your order type identifier in the Certificates, Identifiers & Profiles area of the Apple Developer portal:

- Select Identifiers and then click Add <kbd>+</kbd>.
- On the next screen, choose Order Type ID and click Continue.
- Enter a description and the reverse DNS string to create the order type identifier.

For more information about signing in to your account and creating identifiers, see [Developer Account Help](https://help.apple.com/developer-account/).

Set the `orderTypeIdentifier` in your `order.json` file to the identifier. Set the `orderIdentifier` key to a unique order identifier. The order identifier, in combination with the order type identifier, uniquely identifies an order within the system. For more information, see the top-level [Order](https://developer.apple.com/documentation/walletorders/order) object.

### Generate a signing certificate
Signing an order package requires a signing certificate for the order type identifier. Before you can generate a signing certificate, you need a certificate signing request (CSR). To learn how to generate a CSR, see [Create a certificate signing request](https://help.apple.com/developer-account/#/devbfa00fef7).

Generate the signing certificate in the Certificates, Identifiers & Profiles area of the Apple Developer portal.

- Select Certificates and then click Add <kbd>+</kbd>.
- On the next screen, choose Order Type ID Certificate and click Continue.
- Select the Order Type ID from the dropdown menu.

Click Continue and upload the certificate signing request (CSR).

Install the generated certificate on the server you use for signing the order package. For more information about signing in to your account and creating signing certificates, see [Developer Account Help](https://help.apple.com/developer-account/).

## Step 2: Create `.pem` files

This is the important step!

Export your certificate and private key from <kbd>Keychain Access</kbd> as `Certificate.p12`. It will ask you to set a password.

You should replace `<your-password-here>` with your password in the following commands.
(The `--legacy` part at the end of the following command may or may not be needed depending on your openssl version)

Create the certificate `.pem` file.
```shell
openssl pkcs12 -in Certificates.p12 -clcerts -nokeys -out pass_certificate.pem -passin pass:<your-password-here> --legacy
```

Create the private key `.pem` file. Unfortunately, it's not yet possible to use a password protected private key file.
```shell
openssl pkcs12 -in Certificates.p12 -out private_key.pem -nocerts -nodes -passin pass:<your-password-here> --legacy
```

If the generated `.pem` files do not start with `-----BEGIN RSA PRIVATE KEY-----` (or similar) delete all lines that come before that.
Otherwise, the code can't decode the `.pem` files, and signing may fail.

# Signing a PkPass file

> [!WARNING]
> THIS SHOULD NOT BE USED WITHIN AN APP. 
> IT SHOULD ONLY BE USED SERVER SIDE, OTHERWISE YOU RISK EXPOSING YOUR CERTIFICATE AND PRIVATE KEY.

This guide assumes you're working on a macOS system.

## Step 1: Get a Pass ID and Pass Certificate from the Apple Developer Portal

Follow for example this guide: https://www.kodeco.com/2855-beginning-passbook-in-ios-6-part-1-2?page=3#toc-anchor-007
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

Then you can the generated file to sign PkPass files:

```dart
final pass = PkPass(...);
final binaryData pass.write(
  certificatePem: File('pass_certificate.pem').readAsStringSync(),
  privateKeyPem: File('private_key.pem').readAsStringSync(),
);
File('pass.pkpass').writeAsBytesSync(binaryData); // The file ending is important
```

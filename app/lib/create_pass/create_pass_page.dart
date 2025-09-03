import 'package:app/create_pass/pick_pass_image_dialog.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/widgets/color_picker.dart';
import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/passkit_ui.dart';

class CreatePassPage extends StatefulWidget {
  const CreatePassPage({super.key});

  @override
  State<CreatePassPage> createState() => _CreatePassPageState();
}

class _CreatePassPageState extends State<CreatePassPage> {
  PassType _passType = PassType.generic;
  final _formKey = GlobalKey<FormState>();
  late PkPass _pass = PkPass(
    pass: PassData(
      description: 'Sample Pass',
      organizationName: 'Sample Organization',
      serialNumber: '1234567890',
      teamIdentifier: 'TEAMID1234',
      foregroundColor: Colors.white.toCssColor(),
      backgroundColor: Colors.black.toCssColor(),
      labelColor: Colors.orangeAccent.toCssColor(),
      passTypeIdentifier: 'pass.com.example',
      generic: PassStructure(
        headerFields: [
          FieldDict(key: 'header', label: 'Header', value: 'Value'),
        ],
        primaryFields: [
          FieldDict(key: 'primary', label: 'Primary', value: 'Value'),
        ],
        secondaryFields: [
          FieldDict(key: 'secondary', label: 'Secondary', value: 'Value'),
        ],
        auxiliaryFields: [
          FieldDict(key: 'auxiliary', label: 'Auxiliary', value: 'Value'),
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.createPass),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.passSaved)),
                );
              }
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DropdownButtonFormField<PassType>(
              value: _passType,
              decoration: InputDecoration(
                labelText: l10n.passType,
              ),
              onChanged: (value) {
                setState(() {
                  _passType = value!;
                });
              },
              items: PassType.values
                  .map(
                    (type) => DropdownMenuItem(
                      value: type,
                      child: Text(type.toString().split('.').last),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: l10n.description,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.enterDescription;
                }
                return null;
              },
              onSaved: (value) {
                setState(() {
                  _pass.pass.description = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            _buildAssetButtons(l10n),
            const SizedBox(height: 16),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final color = await showColorPickerDialog(
                      context,
                      _pass.pass.foregroundColor?.toDartUiColor() ??
                          Colors.white,
                    );
                    if (color != null) {
                      setState(() {
                        _pass.pass.foregroundColor = color.toCssColor();
                      });
                    }
                  },
                  child: Text(l10n.foregroundColor),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final color = await showColorPickerDialog(
                      context,
                      _pass.pass.backgroundColor?.toDartUiColor() ??
                          Colors.black,
                    );
                    if (color != null) {
                      setState(() {
                        _pass.pass.backgroundColor = color.toCssColor();
                      });
                    }
                  },
                  child: Text(l10n.backgroundColor),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final color = await showColorPickerDialog(
                      context,
                      _pass.pass.labelColor?.toDartUiColor() ??
                          Colors.orangeAccent,
                    );
                    if (color != null) {
                      setState(() {
                        _pass.pass.labelColor = color.toCssColor();
                      });
                    }
                  },
                  child: Text(l10n.labelColor),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildPassFields(),
            const SizedBox(height: 16),
            PkPassWidget(pass: _pass),
          ],
        ),
      ),
    );
  }

  Set<PassAssetType> _supportedAssetsFor(PassType type) {
    // Apple Wallet: strip image typically not used on boarding passes.
    final base = <PassAssetType>{
      PassAssetType.icon,
      PassAssetType.logo,
      PassAssetType.thumbnail,
      PassAssetType.background,
    };
    if (type != PassType.boardingPass) {
      base.add(PassAssetType.strip);
    }
    return base;
  }

  Widget _buildAssetButtons(AppLocalizations l10n) {
    final supported = _supportedAssetsFor(_pass.type);
    Future<void> pick(PassAssetType t) async {
      final res = await PickPassImageDialog.show(
        context,
        initialType: t,
        allowedTypes: supported,
      );
      if (res == null) return;
      setState(() {
        switch (t) {
          case PassAssetType.icon:
            _pass = _pass.copyWith(icon: res.image);
            break;
          case PassAssetType.logo:
            _pass = _pass.copyWith(logo: res.image);
            break;
          case PassAssetType.thumbnail:
            _pass = _pass.copyWith(thumbnail: res.image);
            break;
          case PassAssetType.strip:
            _pass = _pass.copyWith(strip: res.image);
            break;
          case PassAssetType.background:
            _pass = _pass.copyWith(background: res.image);
            break;
        }
      });
    }

    final buttons = <Widget>[
      if (supported.contains(PassAssetType.icon))
        ElevatedButton.icon(
          onPressed: () => pick(PassAssetType.icon),
          icon: const Icon(Icons.apps),
          label: Text(l10n.pickIcon),
        ),
      if (supported.contains(PassAssetType.logo))
        ElevatedButton.icon(
          onPressed: () => pick(PassAssetType.logo),
          icon: const Icon(Icons.flag),
          label: Text(l10n.pickLogo),
        ),
      if (supported.contains(PassAssetType.thumbnail))
        ElevatedButton.icon(
          onPressed: () => pick(PassAssetType.thumbnail),
          icon: const Icon(Icons.image),
          label: Text(l10n.pickThumbnail),
        ),
      if (supported.contains(PassAssetType.strip))
        ElevatedButton.icon(
          onPressed: () => pick(PassAssetType.strip),
          icon: const Icon(Icons.view_day),
          label: Text(l10n.pickStrip),
        ),
      if (supported.contains(PassAssetType.background))
        ElevatedButton.icon(
          onPressed: () => pick(PassAssetType.background),
          icon: const Icon(Icons.wallpaper),
          label: Text(l10n.pickBackground),
        ),
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: buttons,
    );
  }

  Widget _buildPassFields() {
    final l10n = AppLocalizations.of(context);
    switch (_passType) {
      case PassType.generic:
        return _buildGenericFields(l10n);
      case PassType.coupon:
        return _buildCouponFields(l10n);
      case PassType.storeCard:
        return _buildStoreCardFields(l10n);
      case PassType.eventTicket:
        return _buildEventTicketFields(l10n);
      case PassType.boardingPass:
        return _buildBoardingPassFields(l10n);
    }
  }

  Widget _buildGenericFields(AppLocalizations l10n) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: l10n.headerFieldLabel,
          ),
          onSaved: (value) {
            setState(() {
              _pass.pass.generic = PassStructure(
                headerFields: [
                  FieldDict(key: 'header', label: value, value: 'value'),
                ],
              );
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: l10n.primaryFieldLabel,
          ),
          onSaved: (value) {
            setState(() {
              _pass.pass.generic = PassStructure(
                primaryFields: [
                  FieldDict(key: 'primary', label: value, value: 'value'),
                ],
              );
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: l10n.secondaryFieldLabel,
          ),
          onSaved: (value) {
            setState(() {
              _pass.pass.generic = PassStructure(
                secondaryFields: [
                  FieldDict(key: 'secondary', label: value, value: 'value'),
                ],
              );
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: l10n.auxiliaryFieldLabel,
          ),
          onSaved: (value) {
            setState(() {
              _pass.pass.generic = PassStructure(
                auxiliaryFields: [
                  FieldDict(key: 'auxiliary', label: value, value: 'value'),
                ],
              );
            });
          },
        ),
      ],
    );
  }

  Widget _buildCouponFields(AppLocalizations l10n) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: l10n.headerFieldLabel,
          ),
          onSaved: (value) {
            _pass.pass.coupon!.headerFields = [
              FieldDict(key: 'header', label: value, value: 'value'),
            ];
            setState(() {});
          },
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: l10n.primaryFieldLabel,
          ),
          onSaved: (value) {
            _pass.pass.coupon!.primaryFields = [
              FieldDict(key: 'primary', label: value, value: 'value'),
            ];
            setState(() {
              _pass.pass.coupon = _pass.pass.coupon?.copyWith(
                primaryFields: [
                  FieldDict(key: 'primary', label: value, value: 'value'),
                ],
              );
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: l10n.secondaryFieldLabel,
          ),
          onSaved: (value) {
            _pass.pass.coupon!.secondaryFields = [
              FieldDict(key: 'secondary', label: value, value: 'value'),
            ];
            setState(() {});
          },
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: l10n.auxiliaryFieldLabel,
          ),
          onSaved: (value) {
            _pass.pass.coupon!.auxiliaryFields = [
              FieldDict(key: 'auxiliary', label: value, value: 'value'),
            ];
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildStoreCardFields(AppLocalizations l10n) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: l10n.headerFieldLabel,
          ),
          onSaved: (value) {
            _pass.pass.storeCard!.headerFields = [
              FieldDict(key: 'header', label: value, value: 'value'),
            ];
            setState(() {});
          },
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: l10n.primaryFieldLabel,
          ),
          onSaved: (value) {
            _pass.pass.storeCard!.primaryFields = [
              FieldDict(key: 'primary', label: value, value: 'value'),
            ];
            setState(() {});
          },
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: l10n.secondaryFieldLabel,
          ),
          onSaved: (value) {
            _pass.pass.storeCard!.secondaryFields = [
              FieldDict(key: 'secondary', label: value, value: 'value'),
            ];
            setState(() {});
          },
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: l10n.auxiliaryFieldLabel,
          ),
          onSaved: (value) {
            _pass.pass.storeCard!.auxiliaryFields = [
              FieldDict(key: 'auxiliary', label: value, value: 'value'),
            ];
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildEventTicketFields(AppLocalizations l10n) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: l10n.headerFieldLabel,
          ),
          onSaved: (value) {
            _pass.pass.eventTicket!.headerFields = [
              FieldDict(key: 'header', label: value, value: 'value'),
            ];
            setState(() {});
          },
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: l10n.primaryFieldLabel,
          ),
          onSaved: (value) {
            _pass.pass.eventTicket!.primaryFields = [
              FieldDict(key: 'primary', label: value, value: 'value'),
            ];
            setState(() {});
          },
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: l10n.secondaryFieldLabel,
          ),
          onSaved: (value) {
            _pass.pass.eventTicket!.secondaryFields = [
              FieldDict(key: 'secondary', label: value, value: 'value'),
            ];
            setState(() {});
          },
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: l10n.auxiliaryFieldLabel,
          ),
          onSaved: (value) {
            _pass.pass.eventTicket!.auxiliaryFields = [
              FieldDict(key: 'auxiliary', label: value, value: 'value'),
            ];
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildBoardingPassFields(AppLocalizations l10n) {
    return Column(
      children: [
        DropdownButtonFormField<TransitType>(
          value: TransitType.air,
          decoration: InputDecoration(
            labelText: l10n.transitType,
          ),
          onChanged: (value) {
            setState(() {
              _pass.pass.boardingPass!.transitType = value!;
            });
          },
          items: TransitType.values
              .map(
                (type) => DropdownMenuItem(
                  value: type,
                  child: Text(type.toString().split('.').last),
                ),
              )
              .toList(),
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: l10n.headerFieldLabel,
          ),
          onSaved: (value) {
            _pass.pass.boardingPass!.headerFields = [
              FieldDict(key: 'header', label: value, value: 'value'),
            ];
            setState(() {});
          },
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: l10n.primaryFieldLabel,
          ),
          onSaved: (value) {
            _pass.pass.boardingPass!.primaryFields = [
              FieldDict(key: 'primary', label: value, value: 'value'),
            ];
            setState(() {});
          },
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: l10n.secondaryFieldLabel,
          ),
          onSaved: (value) {
            _pass.pass.boardingPass!.secondaryFields = [
              FieldDict(key: 'secondary', label: value, value: 'value'),
            ];
            setState(() {});
          },
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: l10n.auxiliaryFieldLabel,
          ),
          onSaved: (value) {
            _pass.pass.boardingPass!.auxiliaryFields = [
              FieldDict(key: 'auxiliary', label: value, value: 'value'),
            ];
            setState(() {});
          },
        ),
      ],
    );
  }
}

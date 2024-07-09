import 'package:flutter/widgets.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/src/theme/base_pass_theme.dart';
import 'package:passkit_ui/src/widgets/logo.dart';

class HeaderRow extends StatelessWidget {
  const HeaderRow({
    super.key,
    this.logo,
    this.logoText,
    this.headerFields,
    required this.passTheme,
  });

  final PkPassImage? logo;
  final String? logoText;
  final List<FieldDict>? headerFields;
  final BasePassTheme passTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Logo(logo: logo),
        if (logoText != null)
          Text(
            logoText!,
            style: passTheme.logoTextStyle,
          ),
        if (headerFields != null && headerFields!.isNotEmpty)
          Column(
            children: [
              Text(
                headerFields?.first.label ?? '',
                style: passTheme.headerLabelStyle,
              ),
              Text(
                headerFields?.first.value?.toString() ?? '',
                style: passTheme.headerTextStyle,
              ),
            ],
          ),
      ],
    );
  }
}

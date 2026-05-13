import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/core/extensions/context_extension.dart';
import 'package:sample_project/core/utils/enums.dart';
import 'package:sample_project/features/presentation/providers/theme_provider.dart';

import '../../widgets/common_widgets.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  @override
  void initState() {
    context.read<ThemeProvider>().setThemeTypeBasedOnSelectedThemeMode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.44,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child:
                Text(context.l10n.profileAppearance, style: context.titleLarge),
          ),
          const CommonDivider(),
          const _BuildRadioButtons(),
          const Gap(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: FilledButton.icon(
                style: FilledButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50)),
                onPressed: () {
                  context.read<ThemeProvider>().onSelectionOfAppearance();
                  context.pop();
                },
                icon: const Icon(Icons.check_rounded),
                label: Text(context.l10n.saveAppearance)),
          )
        ],
      ),
    );
  }
}

class _BuildRadioButtons extends StatefulWidget {
  const _BuildRadioButtons();

  @override
  State<_BuildRadioButtons> createState() => _BuildRadioButtonsState();
}

class _BuildRadioButtonsState extends State<_BuildRadioButtons> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, provider, child) {
      return const _ThemeOptions();
    });
  }
}

class _ThemeOptions extends StatelessWidget {
  const _ThemeOptions();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _GetRadioView(label: context.l10n.lightTheme, type: ThemeType.light),
        const CommonDivider(),
        _GetRadioView(label: context.l10n.darkTheme, type: ThemeType.dark),
        const CommonDivider(),
        _GetRadioView(
            label: context.l10n.useDeviceTheme, type: ThemeType.system),
      ],
    );
  }
}

class _GetRadioView extends StatefulWidget {
  final String label;
  final ThemeType type;
  const _GetRadioView({required this.label, required this.type});

  @override
  State<_GetRadioView> createState() => _GetRadioViewState();
}

class _GetRadioViewState extends State<_GetRadioView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, provider, child) {
      return InkWell(
        onTap: () => provider.onChangeOfRadioButton(widget.type),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          child: RadioGroup<ThemeType>(
              groupValue: provider.themeType,
              onChanged: provider.onChangeOfRadioButton,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.label),
                  Radio<ThemeType>(value: widget.type),
                ],
              )),
        ),
      );
    });
  }
}

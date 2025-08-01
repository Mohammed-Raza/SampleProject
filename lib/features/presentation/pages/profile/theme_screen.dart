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
      height: context.height * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text('Appearance', style: TextStyle(fontSize: 20)),
          ),
          const CommonDivider(),
          const _BuildRadioButtons(),
          const Gap(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: ElevatedButton(
                style: ButtonStyle(
                    fixedSize: WidgetStatePropertyAll(Size(context.width, 50)),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)))),
                onPressed: () {
                  context.read<ThemeProvider>().onSelectionOfAppearance();
                  context.pop();
                },
                child: const Text('Save Appearance')),
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
      return const Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _GetRadioView(label: 'Light theme', type: ThemeType.light),
          CommonDivider(),
          _GetRadioView(label: 'Dark theme', type: ThemeType.dark),
          CommonDivider(),
          _GetRadioView(label: 'Use device theme', type: ThemeType.system),
        ],
      );
    });
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
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.label),
              Radio<ThemeType>(
                  value: widget.type,
                  groupValue: provider.themeType,
                  onChanged: provider.onChangeOfRadioButton),
            ],
          ),
        ),
      );
    });
  }
}

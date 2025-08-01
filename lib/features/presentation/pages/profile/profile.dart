import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/core/extensions/context_extension.dart';
import 'package:sample_project/core/mixins/language_mixin.dart';
import 'package:sample_project/features/presentation/pages/profile/language.dart';
import 'package:sample_project/features/presentation/pages/profile/theme_screen.dart';
import 'package:sample_project/features/presentation/providers/language_provider.dart';
import 'package:sample_project/features/presentation/providers/theme_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with LanguageMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            12, context.topPadding, 12, context.bottomPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back)),
            Card(
              child: Container(
                padding: const EdgeInsets.fromLTRB(12, 15, 0, 15),
                child: Column(
                  children: [
                    Consumer<ThemeProvider>(
                        builder: (context, provider, child) => BuildListTile(
                            icon: FontAwesomeIcons.palette,
                            label: 'Appearance',
                            text: provider.getSelectedTheme(),
                            onTap: showThemeBottomSheet)),
                    Consumer<LanguageProvider>(
                        builder: (context, provider, child) => BuildListTile(
                            icon: FontAwesomeIcons.language,
                            label: 'Languages',
                            text: getSelectedLanguage(
                                provider.selectedLanguageCode),
                            showDivider: false,
                            onTap: () => showDialog(
                                context: context,
                                builder: (context) => const LanguageScreen())))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10), topLeft: Radius.circular(10))),
        context: context,
        builder: (context) => const ThemeScreen());
  }
}

class BuildListTile extends StatelessWidget {
  final IconData icon;
  final String label, text;
  final Function()? onTap;
  final bool showDivider;
  const BuildListTile(
      {super.key,
      required this.icon,
      required this.label,
      this.text = '',
      this.onTap,
      this.showDivider = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 6,
      children: [
        InkWell(
          onTap: onTap,
          child: Row(
            spacing: 15,
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200, shape: BoxShape.circle),
                  padding: const EdgeInsets.all(10),
                  child: FaIcon(icon, color: Colors.blueGrey, size: 15)),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(label,
                        style: GoogleFonts.alatsi(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                    Row(
                      spacing: 10,
                      children: [
                        Text(text,
                            style: GoogleFonts.poppins(
                                fontSize: 12, color: Colors.grey)),
                        const Icon(Icons.arrow_forward_ios_outlined,
                            color: Colors.black54, size: 15),
                        const Gap(2)
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Visibility(
            visible: showDivider,
            child: const Divider(thickness: 0.8, indent: 40)),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/core/extensions/build_extensions.dart';
import 'package:sample_project/core/extensions/context_extension.dart';
import 'package:sample_project/core/mixins/language_mixin.dart';
import 'package:sample_project/core/utils/constants.dart';
import 'package:sample_project/features/presentation/providers/language_provider.dart';
import '../../../../core/utils/global_variables.dart';
import '../../../../core/utils/local_storage_keys.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> with LanguageMixin {
  @override
  void initState() {
    setSelectedLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SizedBox(
        width: context.width < 600 ? double.infinity : 520,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child:
              Consumer<LanguageProvider>(builder: (context, provider, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(context.l10n.selectLanguage, style: context.titleLarge),
                const Divider(height: 50),
                GridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: context.width < 420 ? 1 : 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: context.width < 420 ? 3.2 : 1.25,
                  ),
                  children: [
                    _LanguageCard(
                      languageName: 'English',
                      languageLetter: 'A',
                      color: Colors.pink,
                      languageCode: Constants.english,
                      selectedCode: provider.selectedLanguageCode,
                      onTap: provider.selectLanguage,
                    ),
                    _LanguageCard(
                      languageName: 'Hindi',
                      languageLetter: 'अ',
                      color: Colors.cyan,
                      languageCode: Constants.hindi,
                      selectedCode: provider.selectedLanguageCode,
                      onTap: provider.selectLanguage,
                    ),
                    _LanguageCard(
                      languageName: 'Telugu',
                      languageLetter: 'ఆ',
                      color: Colors.deepOrange,
                      languageCode: Constants.telugu,
                      selectedCode: provider.selectedLanguageCode,
                      onTap: provider.selectLanguage,
                    ),
                    _LanguageCard(
                      languageName: 'Urdu',
                      languageLetter: 'یور',
                      color: Colors.teal,
                      languageCode: Constants.urdu,
                      selectedCode: provider.selectedLanguageCode,
                      onTap: provider.selectLanguage,
                    )
                  ],
                ),
                const Gap(15),
                FilledButton.icon(
                    style: FilledButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50)),
                    onPressed: () => provider.onApplyOfLanguage(context),
                    icon: const Icon(Icons.check_rounded),
                    label: Text(context.l10n.apply))
              ],
            );
          }),
        ),
      ),
    );
  }

  void setSelectedLanguage() async {
    var provider = context.read<LanguageProvider>();
    provider.selectedLanguageCode =
        await storage.read(key: LocalStorageKeys.languageCode) ??
            Constants.english;
  }
}

class _LanguageCard extends StatelessWidget {
  final String languageLetter, languageName, languageCode, selectedCode;
  final Color color;
  final Function(String) onTap;
  const _LanguageCard(
      {required this.languageName,
      required this.languageLetter,
      required this.selectedCode,
      required this.languageCode,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    bool isSelected = languageCode == selectedCode;
    return InkWell(
      onTap: () => onTap(languageCode),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: isSelected ? color : context.languageBorderColor,
                width: 2)),
        padding: const EdgeInsets.all(12),
        child: Row(
          spacing: 12,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child: Text(languageLetter,
                  style: GoogleFonts.alatsi(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: Text(
                languageName,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.aBeeZee(fontSize: 18),
              ),
            ),
            Icon(isSelected ? Icons.check_circle : Icons.circle_outlined,
                color: isSelected ? color : Colors.grey, size: 24)
          ],
        ),
      ),
    );
  }
}

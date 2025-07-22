import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
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
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child:
              Consumer<LanguageProvider>(builder: (context, provider, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Select Language'),
                const Divider(height: 50),
                Row(
                  spacing: 20,
                  children: [
                    _LanguageCard(
                        languageName: 'English',
                        languageLetter: 'A',
                        color: Colors.pink,
                        languageCode: Constants.english,
                        selectedCode: provider.selectedLanguageCode,
                        onTap: provider.selectLanguage),
                    _LanguageCard(
                        languageName: 'Hindi',
                        languageLetter: 'अ',
                        color: Colors.cyan,
                        languageCode: Constants.hindi,
                        selectedCode: provider.selectedLanguageCode,
                        onTap: provider.selectLanguage),
                  ],
                ),
                const Gap(20),
                Row(
                  spacing: 20,
                  children: [
                    _LanguageCard(
                        languageName: 'Telugu',
                        languageLetter: 'ఆ',
                        color: Colors.deepOrange,
                        languageCode: Constants.telugu,
                        selectedCode: provider.selectedLanguageCode,
                        onTap: provider.selectLanguage),
                    _LanguageCard(
                        languageName: 'Urdu',
                        languageLetter: 'یور',
                        color: Colors.teal,
                        languageCode: Constants.urdu,
                        selectedCode: provider.selectedLanguageCode,
                        onTap: provider.selectLanguage)
                  ],
                ),
                const Gap(15),
                ElevatedButton(
                    style: ButtonStyle(
                        fixedSize:
                            WidgetStatePropertyAll(Size(context.width, 50)),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    onPressed: () => provider.onApplyOfLanguage(context),
                    child: const Text('Apply'))
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
    return Expanded(
      child: InkWell(
        onTap: () => onTap(languageCode),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: isSelected ? color : Colors.black26, width: 2)),
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                      isSelected ? Icons.check_circle : Icons.circle_outlined,
                      color: isSelected ? color : Colors.grey,
                      size: 30)),
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Text(languageLetter,
                    style: GoogleFonts.alatsi(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
              Text(
                languageName,
                style: GoogleFonts.aBeeZee(fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}

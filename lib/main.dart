import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/config/routes/routing.dart';
import 'package:sample_project/config/theme/theme.dart';
import 'package:sample_project/features/data/repository/groceries_repo_impl.dart';
import 'package:sample_project/features/domain/usecases/grocery_usecases.dart';
import 'package:sample_project/features/presentation/bloc/groceries/groceries_bloc.dart';
import 'package:sample_project/features/presentation/providers/language_provider.dart';
import 'package:sample_project/features/presentation/providers/theme_provider.dart';
import 'core/mixins/language_mixin.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
    with LanguageMixin, WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  // @override
  // void didChangeLocales(List<Locale>? locales) {
  //   context.read<LanguageProvider>().getLocale();
  //   super.didChangeLocales(locales);
  // }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) =>
                GroceriesBloc(GroceryUserCases(GroceriesRepoImpl()))),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer2<LanguageProvider, ThemeProvider>(
          builder: (context, languageProv, themeProv, child) {
        return MaterialApp.router(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            routerConfig: Routing.router,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: languageProv.locale,
            theme: CustomTheme.lightThemeData(context),
            darkTheme: CustomTheme.darkThemeData(),
            themeMode: themeProv.selectedThemeMode);
      }),
    );
  }
}

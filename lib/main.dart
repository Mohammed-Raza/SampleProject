import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/config/routes/routing.dart';
import 'package:sample_project/config/theme/theme.dart';
import 'package:sample_project/core/firebase/firebase_messaging.dart';
import 'package:sample_project/features/data/repository/firebase_repo_impl.dart';
import 'package:sample_project/features/data/repository/groceries_repo_impl.dart';
import 'package:sample_project/features/domain/use_cases/grocery_use_cases.dart';
import 'package:sample_project/features/presentation/bloc/drop_downs/drop_down_cubit.dart';
import 'package:sample_project/features/presentation/bloc/dynamic_pdf/share_pdf_cubit.dart';
import 'package:sample_project/features/presentation/bloc/groceries/groceries_bloc.dart';
import 'package:sample_project/features/presentation/bloc/local_db/local_db_cubit.dart';
import 'package:sample_project/features/presentation/bloc/notifications/push_notifications_bloc.dart';
import 'package:sample_project/features/presentation/providers/language_provider.dart';
import 'package:sample_project/features/presentation/providers/media_provider.dart';
import 'package:sample_project/features/presentation/providers/theme_provider.dart';
import 'core/environments/environment.dart';
import 'core/mixins/language_mixin.dart';
import 'features/data/data_sources/remote/base_service.dart';
import 'l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebasePushNotifications().requestPermissions();
  Environment().configure();
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var baseService = BaseService.instance;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => GroceriesBloc(
                GroceryUseCases(GroceriesRepoImpl(baseService)))),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => MediaProvider()),
        BlocProvider(
            create: (_) =>
                PushNotificationsBloc(FirebaseRepoImpl(baseService))),
        BlocProvider(
            create: (_) => DropDownCubit(
                GroceryUseCases(GroceriesRepoImpl(baseService)))),
        BlocProvider(create: (_) => SharePdfCubit()),
        BlocProvider(create: (_) => LocalDbCubit()),
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

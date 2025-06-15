import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_project/config/routes/routing.dart';
import 'package:sample_project/features/data/repository/groceries_repo_impl.dart';
import 'package:sample_project/features/domain/usecases/grocery_usecases.dart';
import 'package:sample_project/features/presentation/bloc/groceries/groceries_bloc.dart';

import 'features/presentation/pages/dashboard/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) =>
                GroceriesBloc(GroceryUserCases(GroceriesRepoImpl()))),
      ],
      child: MaterialApp.router(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          routerConfig: Routing.router,
          theme: ThemeData(
              // This is the theme of your application.
              //
              // TRY THIS: Try running your application with "flutter run". You'll see
              // the application has a purple toolbar. Then, without quitting the app,
              // try changing the seedColor in the colorScheme below to Colors.green
              // and then invoke "hot reload" (save your changes or press the "hot
              // reload" button in a Flutter-supported IDE, or press "r" if you used
              // the command line to start the app).
              //
              // Notice that the counter didn't reset back to zero; the application
              // state is not lost during the reload. To reset the state, use hot
              // restart instead.
              //
              // This works for code too, not just values: Most code changes can be
              // tested with just a hot reload.
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
              useMaterial3: true)),
    );
  }
}

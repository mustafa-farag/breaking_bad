import 'package:breaking_bad/utilities/colors.dart';
import 'package:breaking_bad/utilities/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color:MyColors.appBarColor,
        ),
        scaffoldBackgroundColor: MyColors.backgroundColor,
        primaryColor: MyColors.appBarColor,
      ),
      onGenerateRoute: appRouter.onGenerate,
    );
  }
}

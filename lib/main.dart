import 'package:flutter/material.dart';
import 'package:intern_challenges/services/requests.dart';
import 'package:intern_challenges/state/current_user.dart';
import 'package:intern_challenges/state/themes.dart';
import 'screen/splash.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeModels()),
        ChangeNotifierProvider(create: (_) => CurrentUser()),
        ChangeNotifierProvider(create: (_) => Requests())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: context.watch<ThemeModels>().isDark
          ? ThemeData.dark()
          : ThemeData.light(),
      home: const Splash(),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learniverse_client/firebase_options.dart';
import 'package:provider/provider.dart';

import 'core/core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DI.init();
  runApp(MultiProvider(
    providers: initProviders,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Codexia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      routerConfig: getRouter(),
    );
  }
}

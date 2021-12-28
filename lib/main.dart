import 'package:flutter/material.dart';
import './views/dashboard.dart';
import './services/service_locator.dart';
import './services/firebase_service.dart';
import 'package:firebase_core/firebase_core.dart';
import './firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupLocator();
  signIn();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Dashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}

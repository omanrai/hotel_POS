import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'features/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Restrict to portrait mode
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Splash Screen Navigation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue[600], // Set the primary color to blue[600]
      ),
      home: SplashScreen(),
    );
  }
}

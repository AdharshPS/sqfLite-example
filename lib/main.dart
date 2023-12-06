import 'package:flutter/material.dart';
import 'package:project_003/controller/list_view_controller.dart';
import 'package:project_003/view/splash_screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ListViewController.initializeDb();
  // await db.close();
  runApp(MainScreen());
}

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

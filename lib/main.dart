import 'package:flutter/material.dart';
import 'package:inventorymanagement/addProducts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:inventorymanagement/homescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MtAppState();
}

class _MtAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      debugShowCheckedModeBanner: false,
      home: LandingScreen(),
    );
  }
}

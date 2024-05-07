import 'package:cmsc23project/screens/adminview.dart';
import 'package:cmsc23project/screens/donorview.dart';
import 'package:cmsc23project/screens/orgview.dart';
import 'package:cmsc23project/screens/userview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CMSC 23 PROJECT",
      initialRoute: '/',
      routes: {
        '/': (context) => const UserView(),
        '/donor': (context) => const DonorView(),
        '/organization': (context) => DonationApp(),
        '/admin': (context) => const AdminView()
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './pages/intro_page.dart';
import 'pages/donation_provider.dart';
import 'pages/intro_page.dart';

void main() {
  runApp(DonationApp());
}

class DonationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DonationProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.green[800],
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Roboto', colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.green[400]),
        ),
        home: IntroPage(),
      ),
    );
  }
}

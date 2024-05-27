import 'package:cmsc23project/pages/intropage/intro_page.dart';
import 'package:cmsc23project/pages/profilepage/organization_provider.dart';
import 'package:cmsc23project/providers/donation_provider.dart'; // Import the OrganizationProvider
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // Use MultiProvider to combine multiple providers
      providers: [
        ChangeNotifierProvider(create: (context) => DonationProvider()),
        ChangeNotifierProvider(
            create: (context) =>
                OrganizationProvider()), // Provide the OrganizationProvider
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.green[800],
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Roboto',
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.green[400]),
        ),
        home: IntroPage(),
      ),
    );
  }
}

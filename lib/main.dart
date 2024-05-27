import 'package:cmsc23project/firebase_options.dart';
import 'package:cmsc23project/pages/donateformpage/donate_form.dart';
import 'package:cmsc23project/pages/donateformpage/donationdrives.dart';
import 'package:cmsc23project/pages/donorprofilepage/donor_profile_page.dart';
import 'package:cmsc23project/pages/signpage/sign_page.dart';
import 'package:cmsc23project/providers/admin_provider.dart';
import 'package:cmsc23project/providers/auth_provider.dart';
import 'package:cmsc23project/providers/donor_form_provider.dart';
import 'package:cmsc23project/providers/donation_provider.dart';
import 'package:cmsc23project/providers/donor_provider.dart';
import 'package:cmsc23project/providers/organization_provider.dart';
import 'package:cmsc23project/providers/pending_provider.dart';
import 'package:cmsc23project/providers/username_provider.dart';
import 'package:cmsc23project/providers/donation_drive_provider.dart';
import 'package:cmsc23project/screens/adminview.dart';
import 'package:cmsc23project/screens/donorview.dart';
import 'package:cmsc23project/screens/orgview.dart';
import 'package:cmsc23project/screens/userview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: ((context) => UserAuthProvider())),
    ChangeNotifierProvider(create: ((context) => DonorProvider())),
    ChangeNotifierProvider(create: ((context) => OrganizationProvider())),
    ChangeNotifierProvider(create: ((context) => AdminProvider())),
    ChangeNotifierProvider(create: ((context) => PendingProvider())),
    ChangeNotifierProvider(create: ((context) => UsernameProvider())),
    ChangeNotifierProvider(create: ((context) => DonorFormProvider())),
    ChangeNotifierProvider(create: ((context) => DonationProvider())),
    ChangeNotifierProvider(create: ((context) => DonationDriveProvider())),


  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "CMSC 23 PROJECT",
      initialRoute: '/',
      routes: {
        '/userview': (context) => const UserView(),
        '/donor': (context) => const DonorView(),
        '/donor/donate': (context) => const DonateForm(),
        '/donor/donatedrives': (context) => DonationDrivesPageCopy(),
        '/donor/profile': (context) => const DonorProfilePage(),
        '/organization': (context) => DonationApp(),
        '/admin': (context) => const AdminView(),
        '/': (context) => const SignPage()
      },
    );
  }
}

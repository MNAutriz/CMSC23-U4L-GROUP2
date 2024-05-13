import 'package:cmsc23project/firebase_options.dart';
import 'package:cmsc23project/pages/donateformpage/donate_form.dart';
import 'package:cmsc23project/pages/signpage/sign_page.dart';
import 'package:cmsc23project/providers/auth_provider.dart';
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
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CMSC 23 PROJECT",
      initialRoute: '/',
      routes: {
        '/userview': (context) => const UserView(),
        '/donor': (context) => const DonorView(),
        '/organization': (context) => DonationApp(),
        '/admin': (context) => const AdminView(),
        '/donor/donate': (context) => const DonateForm(),
        '/': (context) => const SignPage()
      },
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//pages
import 'package:myapp/pages/add_name_page.dart';
import 'package:myapp/pages/add_proved_page%20.dart';
import 'package:myapp/pages/edit_name_page%20copy.dart';
import 'package:myapp/pages/edit_proved_page.dart';
import 'package:myapp/pages/home_page2.dart';
import 'package:myapp/pages/home_page.dart';
// firebase
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "MI CRUD",
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/add': (context) => const AddNamePage(),
        '/edit': (context) => const EditNamePage(),
        '/home2': (context) => const Home2(),
        '/add2': (context) => const AddProvedPage(),
        '/edit2': (context) => const EditProvedPage(),
      },
    );
  }
}

import 'package:crudpo1/Feature/Screen/Update.dart';
import 'package:crudpo1/Feature/Screen/edit_Page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Feature/Screen/Home_Page.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

  );
  runApp(ProviderScope(child: MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
   initialRoute: '/',
      routes: {
      '/': (_) => Home(),
        '/add':(_)=>EditPage(),
        // '/add':(_)=>Update(),

    },

    debugShowCheckedModeBanner: false,
    );
  }
}

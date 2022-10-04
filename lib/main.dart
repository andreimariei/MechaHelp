import 'package:MechaHelp/Service/FirebaseService.dart';
import 'package:MechaHelp/UI/login.dart';
import 'package:MechaHelp/Utils/googleAuth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async => runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => GoogleSignInProvider(),
          ),
          Provider(
            create: (_) => FirebaseService(),
          )
        ],
        child: MaterialApp(
          home: MyApp(),
          debugShowCheckedModeBanner: false,
        )));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FirebaseService serv = Provider.of<FirebaseService>(context, listen: false);
    Future.delayed(Duration(seconds: 0), () async {
      await Firebase.initializeApp();
      serv.getServicesFromFirebase().then((value) => Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage())));
    });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF3EBACE),
        accentColor: Color(0xFFD8ECF1),
        scaffoldBackgroundColor: Color(0xFFF3F5F7),
      ),
      home: LoginPage(),
    );
  }
}

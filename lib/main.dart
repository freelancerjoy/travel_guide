import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_guide/pages/addtravel.dart';
import 'package:travel_guide/pages/crud.dart';
import 'package:travel_guide/pages/myhomepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_guide/pages/provider.dart';
import 'package:travel_guide/pages/read_provider.dart';
import 'package:travel_guide/pages/sircrud.dart';
import 'package:travel_guide/pages/travel_provider.dart';
import 'package:travel_guide/pages/upload_img.dart';

Future <void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider(
    //   create: (context)=>CounterProvider(),
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context)=>CounterProvider(),),
          ChangeNotifierProvider(create: (context)=>TravelProvider(),),
        ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.teal,
          primarySwatch: Colors.teal,
          hintColor: Colors.white,

        ),
        home: const MyHomePageClass(),
      ),
    );
  }
}
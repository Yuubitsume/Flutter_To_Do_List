import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'firebase/firebase_options.dart';
import 'functions/create_task.dart';
import 'page/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
    apiKey: "AIzaSyDEm-wj6W_Qd86lIDtH77VekYZZ_79JDr0",
    appId: "1:825681413946:web:4566d8696582d43dc67203",
    messagingSenderId: "825681413946",
    projectId: "to-do-list-app-6869c",
  ));
  runApp(const MyApp());
}

void logout() async {
  await FirebaseAuth.instance.signOut();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'To-Do List',
      theme: ThemeData(
        //textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Ma TodoList'),
                actions: const [
                  IconButton(
                    onPressed: logout,
                    icon: Icon(Icons.logout),
                  ),
                ],
              ),
              body: const ToDoList(
                title: '',
              ),
            );
          } else {
            return const AuthScreen();
          }
        },
      ),
    );
  }
}

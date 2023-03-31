import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_to_do_list/functions/create_task.dart';
import '../auth/auth.dart' as auth;
import 'package:flutter_to_do_list/page/login.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            return const ToDoList(title: 'Ma TodoList');
          } else {
            return const RegisterAuthScreen();
          }
        },
      ),
    );
  }
}

/*Partie Authentification Screen */
class RegisterAuthScreen extends StatefulWidget {
  const RegisterAuthScreen({super.key});

  @override
  State<RegisterAuthScreen> createState() => AuthScreenState();
}

class AuthScreenState extends State<RegisterAuthScreen> {
  bool isLogin = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    final email = _emailController.value.text;
    final password = _passwordController.value.text;

    //Check if is login or register
    if (isLogin) {
      await auth.Auth().signInWithEmailAndPassword(email, password);
      // connected = true;
    } else {
      await auth.Auth().registerWithEmailAndPassword(email, password);
      // connected = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            //Add form to key to the Form Widget
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Créer un compte sur To-Do-List Master",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Créer un compte",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextFormField(
                    //Assign controller
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrez votre email';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'mail',
                      focusColor: Colors.black,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextFormField(
                    //Assign controller
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrez votre mot de passe';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Mot de passe',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                //enveloppage des deux boutons et button "Se connecter"
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AuthScreen()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 12.0,
                                  ),
                                ),
                                child: const Text(
                                  'Accueil',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 16.0,
                                height: 20,
                              ), // End button Se connecter
                              //button "créer un compte"
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 12.0,
                                  ),
                                ),
                                onPressed: () => handleSubmit(),
                                child: const Text(
                                  'Créer un compte',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ])),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

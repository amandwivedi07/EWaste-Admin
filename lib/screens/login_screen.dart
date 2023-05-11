import 'package:admin/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login-screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final _formKey = GlobalKey<FormState>();
  // final FirebaseServices _services = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    String adminEmail = "";
    String adminPassword = "";

    allowAdminToLogin() async {
      SnackBar snackBar = const SnackBar(
        content: Text(
          "Checking Credentials, Please wait...",
          style: TextStyle(
            fontSize: 36,
            color: Colors.black,
          ),
        ),
        backgroundColor: kPrimaryColor,
        duration: Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      User? currentAdmin;
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: adminEmail,
        password: adminPassword,
      )
          .then((fAuth) {
        //success
        currentAdmin = fAuth.user;
      }).catchError((onError, e) {
        //in case of error
        //display error message
        final snackBar = SnackBar(
          content: Text(
            "Error Occured: " + onError.toString(),
            style: const TextStyle(
              fontSize: 36,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.cyan,
          duration: const Duration(seconds: 5),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });

      if (currentAdmin != null) {
        //check if that admin record also exists in the admins collection in firestore database
        await FirebaseFirestore.instance
            .collection("admin")
            .doc(currentAdmin!.uid)
            .get()
            .then((snap) {
          if (snap.exists) {
            Navigator.push(
                context, MaterialPageRoute(builder: (c) => SideMenu()));
          } else {
            SnackBar snackBar = const SnackBar(
              content: Text(
                "No record found, you are not an admin.",
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.black,
                ),
              ),
              backgroundColor: Colors.cyan,
              duration: Duration(seconds: 6),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        });
      }
    }

    return Scaffold(
      // // key:_formKey,
      // appBar: AppBar(
      //   elevation: 0.0,
      //   title: Text('Grocery Store Admin Dashboard',style: TextStyle(color: Colors.white ),),
      //   centerTitle: true,

      body: FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return const Center(
              child: Text('Connection failed'),
            );
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [kPrimaryColor, Colors.white],
                    stops: [1.0, 1.0],
                    begin: Alignment.topCenter,
                    end: Alignment(0.0, 0.0)),
              ),
              child: Center(
                child: Container(
                  width: 350,
                  height: 400,
                  child: Card(
                    elevation: 6,
                    shape: Border.all(color: Colors.green, width: 2),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Image.asset(
                                  'images/logo.png',
                                  height: 150,
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                TextField(
                                  onChanged: (value) {
                                    adminEmail = value;
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Email',
                                      prefixIcon: const Icon(Icons.person),
                                      contentPadding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      border: const OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              width: 2))),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextField(
                                  onChanged: (value) {
                                    adminPassword = value;
                                  },
                                  obscureText: false,
                                  decoration: InputDecoration(
                                      labelText: 'Minimum 6 Characters',
                                      prefixIcon:
                                          const Icon(Icons.vpn_key_sharp),
                                      hintText: 'Password',
                                      contentPadding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      border: const OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              width: 2))),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                      style: TextButton.styleFrom(
                                        primary: Colors.white,
                                        backgroundColor: Colors.green,
                                        onSurface: Colors.grey,
                                      ),
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          allowAdminToLogin();
                                        }
                                      },
                                      child: const Text(
                                        'Login',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return const Center(
            child: const CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

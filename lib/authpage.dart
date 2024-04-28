import 'package:flutter/material.dart';
//firebase_auth
import 'package:firebase_auth/firebase_auth.dart';
import 'package:xamify/getstarted.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasData) {
            return Container();
          } else {
            return const GetStarted();
          }
        },
      ),
    );
  }
}

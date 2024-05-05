// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:xamify/forgot.dart';
import 'package:xamify/navbar.dart';
import 'package:xamify/signup.dart';
import 'package:xamify/transitions.dart';
//auth
import 'package:firebase_auth/firebase_auth.dart';
//firebase messaging
import 'package:firebase_messaging/firebase_messaging.dart';
//firestore
import 'package:cloud_firestore/cloud_firestore.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool visible = false;
  var eyeicon = const Icon(Icons.visibility);
  void toggleicon() {
    setState(() {
      visible = !visible;
      if (!visible) {
        eyeicon = const Icon(Icons.visibility);
      } else {
        eyeicon = const Icon(Icons.visibility_off);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Image.asset(
                    'assets/name.png',
                    width: 300,
                    height: 37,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: Image.asset(
                    'assets/Sign in.png',
                    width: 236.97,
                    height: 203.38,
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                const Text(
                  'Coffee in hand, books open?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Text(
                  'Sign in',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const Text(
                  'to stay updated.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 50,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Image.asset(
                            'assets/mail.png',
                            height: 10,
                          ),
                        ),
                        hintText: 'Email Address',
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.699999988079071),
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w100,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Color(0xFFBFDAEF), width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: const BorderSide(
                                color: Color(0xFFFFFFFF), width: 1))),
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                    cursorColor: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                SizedBox(
                  height: 50,
                  child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                              left: 15, top: 20, bottom: 20, right: 20),
                          child: Image.asset(
                            'assets/password.png',
                            height: 10,
                          ),
                        ),
                        suffixIcon: IconButton(
                          onPressed: toggleicon,
                          icon: eyeicon,
                          color: Colors.white,
                        ),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.699999988079071),
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w100,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Color(0xFFBFDAEF), width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: const BorderSide(
                                color: Color(0xFFFFFFFF), width: 1))),
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                    obscureText: !visible,
                    cursorColor: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context, EnterRoute(page: const ForgotPage()));
                      },
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        //if email is valid then sign in user and goto homepage else show error message
                        if (emailController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          Navigator.push(
                              context,
                              FadeRoute(
                                  page: SpalshScreen(
                                      email: emailController.text,
                                      password: passwordController.text)));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  backgroundColor: Color(0xffff8800),
                                  content:
                                      Text('Email or or password is empty!'),
                                  duration: Duration(seconds: 3)));
                        }

                        // Navigator.push(
                        //     context, FadeRoute(page: const HomePage()));
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Sign In',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF1E7BC5),
                              fontSize: 19,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: Text(
                    'Doesn’t have an account?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context, SlideRightRoute(page: const SignUp()));
                    },
                    child: const Text(
                      'Create your free account ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFFBFDAEF),
                        //give more thickness to underline
                        decorationThickness: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class SpalshScreen extends StatefulWidget {
  String email;
  String password;
  SpalshScreen({super.key, required this.email, required this.password});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  void Signin() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: widget.email, password: widget.password)
        .then((value) {
      //save device token for notification to collection userdata document email at field token
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      messaging.getToken().then((value) {
        FirebaseFirestore.instance
            .collection('userdata')
            .doc(widget.email)
            .update({'token': value});
      });
      Navigator.pushReplacement(context, FadeRoute(page: const NavBar()));
    }).catchError((e) {
      //pop
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color(0xffff8800),
          content: Text('Invalid email or password!'),
          duration: Duration(seconds: 3)));
    });
  }

  @override
  void initState() {
    super.initState();
    Signin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/loading.gif',
          fit: BoxFit.fill,
          //
        ),
      ),
    );
  }
}

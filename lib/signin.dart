import 'package:flutter/material.dart';
import 'package:xamify/forgot.dart';
import 'package:xamify/signup.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool visible = false;
  var eyeicon = const Icon(Icons.visibility_off);
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 60,
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
              Image.asset(
                'assets/Sign in.png',
                width: 236.97,
                height: 203.38,
              ),
              const SizedBox(
                height: 35,
              ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Text(
                      'Coffee in hand, books open?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 45,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Text(
                      'to stay updated.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                        // prefixIcon: Container(
                        //   width: 5.0,
                        //   height: 16.0,
                        //   child: Image.asset(
                        //     'assets/mail.png',
                        //   ),
                        // ),
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
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFBFDAEF), width: 1))),
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                    cursorColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
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
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFBFDAEF), width: 1))),
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                    obscureText: !visible,
                    cursorColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgotPage()));
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
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignIn()));
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
                              fontSize: 22,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
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
              const Text(
                'Doesn’t have an account?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignUp()));
                },
                child: const Text(
                  'Create your free account ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                width: 195,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

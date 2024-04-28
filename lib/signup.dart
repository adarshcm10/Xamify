import 'package:flutter/material.dart';
import 'package:xamify/signin.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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

  bool visible1 = false;
  var eyeicon1 = const Icon(Icons.visibility_off);
  void toggleicon1() {
    setState(() {
      visible1 = !visible1;
      if (!visible1) {
        eyeicon1 = const Icon(Icons.visibility);
      } else {
        eyeicon1 = const Icon(Icons.visibility_off);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                height: 20,
              ),
              Center(
                child: Image.asset(
                  'assets/signup.png',
                  height: 184.62,
                  width: 209.4,
                ),
              ),
              const SizedBox(
                height: 27,
              ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Text(
                      'Join the squad',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
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
                      'Create Your Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Full Name',
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
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
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
                height: 10,
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
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: toggleicon1,
                          icon: eyeicon1,
                          color: Colors.white,
                        ),
                        hintText: 'Re-type-Password',
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
                    obscureText: !visible1,
                    cursorColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
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
                                builder: (context) => const SignUp()));
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
                            'Create account',
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
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Already have an account?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignIn()));
                },
                child: const Text(
                  'Sign in to your account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                width: 175,
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

import 'package:flutter/material.dart';
import 'package:xamify/signin.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({super.key});

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
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
                height: 130,
              ),
              Image.asset(
                'assets/forgot.png',
                width: 252,
                height: 250,
              ),
              const SizedBox(
                height: 48,
              ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Text(
                      'Lost your password?',
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
                      'We got it covered!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 29,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Text(
                      'Enter email to get reset link',
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
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(
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
                            'Submit',
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
            ],
          ),
        ),
      ),
    );
  }
}

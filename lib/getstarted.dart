import 'package:flutter/material.dart';
import 'package:xamify/signin.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/name.png',
                width: 300,
                height: 37,
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Center(
              child: Image.asset(
                'assets/StartPage.png',
                width: 356,
                height: 266,
              ),
            ),
            const SizedBox(
              height: 74,
              width: 212,
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    'Stress less, \nstudy smart!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w900,
                      height: 0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    'Exam dates at your fingertips \nwith our app.',
                    style: TextStyle(
                      color: Color(0xFFBFDAEF),
                      fontSize: 18,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignIn()));
                    },
                    child: Container(
                      width: 119,
                      height: 40,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 23),
                            child: Text(
                              'Eplore',
                              style: TextStyle(
                                color: Color(0xFF1E7BC5),
                                fontSize: 16,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Image.asset(
                            'assets/arrow.png',
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

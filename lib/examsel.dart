// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//firestore
import 'package:cloud_firestore/cloud_firestore.dart';
//messaging
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:xamify/home.dart';
import 'package:xamify/transitions.dart';

class ExamSelect extends StatefulWidget {
  const ExamSelect({super.key});

  @override
  State<ExamSelect> createState() => _ExamSelectState();
}

class _ExamSelectState extends State<ExamSelect> {
  final String email = FirebaseAuth.instance.currentUser!.email.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    'assets/name.png',
                    height: 37,
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  const Text(
                    'Select your exams',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //display doc id of all docs in collection exams
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('exams')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return Expanded(
                          child: GridView.count(
                            physics: const ClampingScrollPhysics(),
                            crossAxisCount: 2,
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              return MyContainer(document: document);
                            }).toList(),
                          ),
                        );
                      } else {
                        return Image.asset(
                          'assets/loading.gif',
                          fit: BoxFit.fill,
                        );
                      }
                    },
                  ),
                ],
              ),
              Positioned(
                bottom: 30,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    if (selectedExams.isNotEmpty) {
                      //get device token
                      FirebaseMessaging messaging = FirebaseMessaging.instance;

                      //save selectedExams to firestore separately as each element is docid with a field name as the element to collection userdata and doc email and subcollection exams
                      for (var i = 0; i < selectedExams.length; i++) {
                        FirebaseFirestore.instance
                            .collection('userdata')
                            .doc(email)
                            .collection('exams')
                            .doc(selectedExams[i])
                            .set({
                          'exam': selectedExams[i],
                        });
                        //save device token to each exam doc subcollection token
                        messaging.getToken().then((value) {
                          FirebaseFirestore.instance
                              .collection('exams')
                              .doc(selectedExams[i])
                              .collection('token')
                              .doc(email)
                              .set({
                            'token': value,
                          });
                        });
                      }

                      Navigator.pushReplacement(
                          context, EnterRoute(page: const HomePage()));
                    } else {
                      //snackbar if no exam is selected
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please select at least one exam',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          backgroundColor: Color(0xFFff8800),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
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
                        'Continue',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF1E7BC5),
                          fontSize: 15,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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

class MyContainer extends StatefulWidget {
  final DocumentSnapshot document;

  const MyContainer({super.key, required this.document});

  @override
  _MyContainerState createState() => _MyContainerState();
}

class _MyContainerState extends State<MyContainer> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isTapped = !_isTapped;
        });
        if (_isTapped) {
          selectedExams.add(widget.document.id);
        } else {
          selectedExams.remove(widget.document.id);
        }
        // print(selectedExams);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
        child: Container(
          width: 135,
          height: 100,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  width: 2,
                  color: _isTapped ? const Color(0xFFFF8800) : Colors.white),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //_isTapped true then show image selected.png
              if (_isTapped)
                Image.asset(
                  'assets/selected.png',
                  width: 18,
                  height: 18,
                ),
              Text(
                widget.document.id.length > 8
                    ? widget.document.id.substring(0, 8)
                    : widget.document.id,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _isTapped ? const Color(0xFFFF8800) : Colors.white,
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//list to save taped doc ids
List<String> selectedExams = [];

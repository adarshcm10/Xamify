// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
//auth
import 'package:firebase_auth/firebase_auth.dart';
import 'package:xamify/allexams.dart';
import 'package:xamify/exammaterials.dart';
import 'package:xamify/examdetails.dart';
import 'package:xamify/notificationdetails.dart';
import 'package:xamify/transitions.dart';
//firestore
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xamify/usernotification.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1E7BC5),
        title: Image.asset('assets/name.png', height: 24),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                //navigate to notification page
                Navigator.push(
                  context,
                  EnterRoute(
                    page: const UserNotification(),
                  ),
                );
              },
              child: Image.asset('assets/notification.png', height: 24),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hey buddy!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              //display head field from collection userdata, doc email, collection notification and doc with latest timestamp value
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('userdata')
                    .doc(FirebaseAuth.instance.currentUser!.email)
                    .collection('notification')
                    .orderBy('timestamp', descending: true)
                    .limit(1)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    //if there is nothing to display
                    if (snapshot.data!.docs.isEmpty) {
                      return Container(
                        width: double.infinity,
                        height: 60,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 1, color: Color(0xFFBFDAEF)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'No new notifications',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          final Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                          return GestureDetector(
                            onTap: () {
                              //navigate to notification details page with doc id
                              Navigator.push(
                                context,
                                EnterRoute(
                                  page: NotificationDetails(docid: document.id),
                                ),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              height: 60,
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 1, color: Color(0xFFBFDAEF)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          data['title'],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          data['head'].length > 22
                                              ? data['head'].substring(0, 22) +
                                                  '...'
                                              : data['head'],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w200,
                                          ),
                                        )
                                      ],
                                    ),
                                    Image.asset('assets/view.png', height: 10),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }
                  } else {
                    return const Text(
                      'Loading...',
                      style: TextStyle(color: Colors.white),
                    );
                  }
                },
              ),

              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'My exams',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      //goto all exams page slide transition
                      Navigator.push(
                        context,
                        EnterRoute(
                          page: const AllExams(),
                        ),
                      );
                    },
                    child: const Text(
                      'View all',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              //display doc id of all docs in collection userdata, doc email and collection exams
              SizedBox(
                height: 60,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('userdata')
                      .doc(FirebaseAuth.instance.currentUser!.email)
                      .collection('exams')
                      .limit(3)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return GridView.count(
                        physics: const ClampingScrollPhysics(),
                        crossAxisCount: 3,
                        childAspectRatio: 2 /
                            1, // Adjust this value to control the height of the children
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(right: 2.5, left: 2.5),
                            child: GestureDetector(
                              onTap: () {
                                //navigate to exam details page with doc id
                                Navigator.push(
                                  context,
                                  EnterRoute(
                                    page: ExamDetails(docid: document.id),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        width: 1, color: Color(0xFFBFDAEF)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    document.id,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    } else {
                      return const Text(
                        'Loading...',
                        style: TextStyle(color: Colors.white),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Exams materials',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 10),
              //get all doc id from collection, doc email and collection exams
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('userdata')
                    .doc(FirebaseAuth.instance.currentUser!.email)
                    .collection('exams')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        return StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('exams')
                              .doc(document.id)
                              .collection('materials')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(right: 5, bottom: 5),
                                child: GestureDetector(
                                  onTap: () {
                                    //navigate to exam materials page with doc id
                                    Navigator.push(
                                      context,
                                      EnterRoute(
                                        page: ExamMaterials(docid: document.id),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 55,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            width: 1, color: Color(0xFFBFDAEF)),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            document.id,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            '${snapshot.data!.docs.length} materials',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w200,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return const Text(
                                'Loading...',
                                style: TextStyle(color: Colors.white),
                              );
                            }
                          },
                        );
                      }).toList(),
                    );
                  } else {
                    return const Text(
                      'Loading...',
                      style: TextStyle(color: Colors.white),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

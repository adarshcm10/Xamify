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
  Future<List<QueryDocumentSnapshot>> getLatestDocuments() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('exams').get();
    List<QueryDocumentSnapshot> documents = [];

    for (var doc in snapshot.docs) {
      QuerySnapshot subSnapshot = await FirebaseFirestore.instance
          .collection('exams')
          .doc(doc.id)
          .collection('notification')
          .orderBy('time', descending: true)
          .limit(1)
          .get();
      documents.addAll(subSnapshot.docs);
    }

    return documents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
              FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection('userdata')
                    .doc(FirebaseAuth.instance.currentUser!.email)
                    .collection('exams')
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading");
                  }

                  // return Column(
                  //   children:
                  //       snapshot.data!.docs.map((DocumentSnapshot document) {
                  //     return FutureBuilder<QuerySnapshot>(
                  //       future: FirebaseFirestore.instance
                  //           .collection('exams')
                  //           .doc(document.id) // replace with your document id
                  //           .collection('notification')
                  //           .orderBy('timestamp', descending: true)
                  //           .get(),
                  //       builder: (BuildContext context,
                  //           AsyncSnapshot<QuerySnapshot> snapshot) {
                  //         String examId = document.id;
                  //         if (snapshot.hasError) {
                  //           return const Text('Something went wrong');
                  //         }

                  //         if (snapshot.connectionState ==
                  //             ConnectionState.waiting) {
                  //           return const Text("Loading...",
                  //               style: TextStyle(color: Colors.white));
                  //         }

                  //       },
                  //     );
                  //   }).toList(),
                  // );
                  //dispalay only one document from all docs read above which have the latest timestamp value
                  return FutureBuilder<List<QueryDocumentSnapshot>>(
                    future: getLatestDocuments(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<QueryDocumentSnapshot>> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong',
                            style: TextStyle(color: Colors.white));
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text("Loading...",
                            style: TextStyle(color: Colors.white));
                      }

                      // Get the latest document
                      QueryDocumentSnapshot latestDocument = snapshot.data!
                          .reduce((curr, next) =>
                              curr.get('time').compareTo(next.get('time')) > 0
                                  ? curr
                                  : next);

                      // Display the latest document
                      // Replace this with your actual code to display the document
                      return //display the latest notification
                          GestureDetector(
                        onTap: () {
                          //navigate to notification details page with doc id and notification id
                          Navigator.push(
                            context,
                            EnterRoute(
                              page: NotificationDetails(
                                docid:
                                    latestDocument.reference.parent.parent!.id,
                                id: latestDocument.id,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          width: double.infinity,
                          height: 60,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Color(0xFFBFDAEF)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    latestDocument.get('title'),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    latestDocument.get('desc'),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                              Image.asset('assets/view.png', height: 10),
                            ],
                          ),
                        ),
                      );
                    },
                  );
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
                              'No exams selected',
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
                      }
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
                            'No ematerials available',
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
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
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
                                  padding: const EdgeInsets.only(
                                      right: 5, bottom: 5),
                                  child: GestureDetector(
                                    onTap: () {
                                      //navigate to exam materials page with doc id
                                      Navigator.push(
                                        context,
                                        EnterRoute(
                                          page:
                                              ExamMaterials(docid: document.id),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 55,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              width: 1,
                                              color: Color(0xFFBFDAEF)),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
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
                    }
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

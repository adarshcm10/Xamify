// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xamify/notificationdetails.dart';
import 'package:xamify/transitions.dart';

class SearchDetails extends StatefulWidget {
  String docid;
  SearchDetails({
    super.key,
    required this.docid,
  });

  @override
  State<SearchDetails> createState() => _SearchDetailsState();
}

class _SearchDetailsState extends State<SearchDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1E7BC5),
        title: Image.asset('assets/name.png', height: 24),
        centerTitle: true,
        //back button colour white
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.docid,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                ),
              ),
              //get abbr from collection exams doc widget.docid
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('exams')
                    .doc(widget.docid)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const Text('Loading...');
                  }
                  var doc = snapshot.data;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doc['abbr'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Date: ${DateFormat('dd-MM-yyyy').format(doc['date'].toDate())}',
                        style: const TextStyle(
                          color: Color(0xFFFF9900),
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        doc['desc'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Duration:',
                        style: TextStyle(
                          color: Color(0xFFFF9900),
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                      Text(
                        doc['duration'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'No.of questions:',
                        style: TextStyle(
                          color: Color(0xFFFF9900),
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                      Text(
                        doc['q'].toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Marking scheme:',
                        style: TextStyle(
                          color: Color(0xFFFF9900),
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                      Text(
                        doc['correct'] + ' marks for correct answer',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        doc['false'] + ' marks for wrong answer',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                          onTap: () async {
                            //launch url
                            await launchUrl(Uri.parse(doc['link']),
                                mode: LaunchMode.externalNonBrowserApplication);
                          },
                          child: const Text(
                            'Visit official website >>',
                            style: TextStyle(
                              color: Color(0xFFFF8800),
                              fontSize: 15,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                              decorationColor: Color(0xFFFF8800),
                            ),
                          )),
                    ],
                  );
                },
              ),
              const SizedBox(height: 15),
              const Text(
                'All Notifications',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 10),
              //get head from collcetion widget.docid and all doc
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('exams')
                    .doc(widget.docid)
                    .collection('notification')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const Text('Loading...');
                  }
                  return Column(
                    children: List<Widget>.generate(
                      snapshot.data.docs.length,
                      (index) {
                        var data = snapshot.data.docs[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                FadeRoute(
                                  page: NotificationDetails(
                                    docid: widget.docid,
                                    id: data.id,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              width: double.infinity,
                              height: 50,
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 1, color: Color(0xFFBFDAEF)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data['title'].length > 20
                                            ? data['title'].substring(0, 20) +
                                                '...'
                                            : data['title'],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Image.asset('assets/view.png', height: 10),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  final String docId = widget.docid;
                  // Replace with the actual user email

                  final DocumentReference docRef = FirebaseFirestore.instance
                      .collection('userdata')
                      .doc(FirebaseAuth.instance.currentUser!.email)
                      .collection('exams')
                      .doc(docId);

                  final DocumentSnapshot docSnap = await docRef.get();

                  if (!docSnap.exists) {
                    await docRef.set({
                      'exam': docId,
                    });

                    //select token from collection userdata doc useremail and save to collection exams, document id docid and subcollection token and doc useremail
                    final DocumentSnapshot userSnap = await FirebaseFirestore
                        .instance
                        .collection('userdata')
                        .doc(FirebaseAuth.instance.currentUser!.email)
                        .get();
                    final String token = userSnap['token'];

                    await FirebaseFirestore.instance
                        .collection('exams')
                        .doc(docId)
                        .collection('token')
                        .doc(FirebaseAuth.instance.currentUser!.email)
                        .set({
                      'token': token,
                    });
                    //pop
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Color(0xffff8800),
                      content: Text('Exam added!'),
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Color(0xffff8800),
                      content: Text('Exam already exists!'),
                    ));
                  }
                },
                child: Container(
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Color(0xff1E7BC5),
                      ),
                      Text(
                        'Add Exam',
                        style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff1E7BC5),
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

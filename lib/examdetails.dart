// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:xamify/notificationdetails.dart';
//transitions.dart
import 'package:xamify/transitions.dart';
//firestore
import 'package:cloud_firestore/cloud_firestore.dart';
//intl
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ExamDetails extends StatefulWidget {
  String docid;
  ExamDetails({super.key, required this.docid});

  @override
  State<ExamDetails> createState() => _ExamDetailsState();
}

class _ExamDetailsState extends State<ExamDetails> {
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
            ],
          ),
        ),
      ),
    );
  }
}

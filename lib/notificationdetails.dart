// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
//firestore
import 'package:cloud_firestore/cloud_firestore.dart';
//intl
import 'package:intl/intl.dart';
//url_launcher
import 'package:url_launcher/url_launcher.dart';

class NotificationDetails extends StatefulWidget {
  String docid;
  String id;
  NotificationDetails({super.key, required this.docid, required this.id});

  @override
  State<NotificationDetails> createState() => _NotificationDetailsState();
}

class _NotificationDetailsState extends State<NotificationDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/name.png', height: 24),
        backgroundColor: const Color(0xff1E7BC5),
        centerTitle: true,
        //back button colour white
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
              //delete notification
              FirebaseFirestore.instance
                  .collection('exams')
                  .doc(widget.docid)
                  .collection('notification')
                  .doc(widget.id)
                  .delete();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            children: [
              //get title,head, desc and link from collection userdata doc email subcollection notification and docid doc
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('exams')
                    .doc(widget.docid)
                    .collection('notification')
                    .doc(widget.id)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  var data = snapshot.data!.data() as Map<String, dynamic>;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        data['title'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      //convert timestamp to date dd-mm-yyyy
                      Text(
                        'Important date: ${DateFormat('dd-MM-yyyy').format(
                          DateTime.fromMillisecondsSinceEpoch(
                            data['timestamp'].seconds * 1000,
                          ),
                        )}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        data['desc'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      const SizedBox(height: 20),

                      GestureDetector(
                          onTap: () async {
                            //launch url
                            await launchUrl(Uri.parse(data['link']),
                                mode: LaunchMode.externalNonBrowserApplication);
                          },
                          child: const Text(
                            'Click here to know more',
                            style: TextStyle(
                              color: Color(0xFFFF8800),
                              fontSize: 15,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                              decorationColor: Color(0xFFFF8800),
                            ),
                          ))
                    ],
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

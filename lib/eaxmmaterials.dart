// ignore_for_file: must_be_immutable
//firestore
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:flutter/material.dart';

class ExamMaterials extends StatefulWidget {
  String docid;
  ExamMaterials({super.key, required this.docid});

  @override
  State<ExamMaterials> createState() => _ExamMaterialsState();
}

class _ExamMaterialsState extends State<ExamMaterials> {
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
              const SizedBox(height: 10),
              const Text(
                'Materials',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w300,
                  height: 0.08,
                ),
              ),
              const SizedBox(height: 20),
              //get name from collection exams, doc widget.docid, collection materials and all docs. use column instead of listview
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('exams')
                    .doc(widget.docid)
                    .collection('materials')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Column(
                    children: snapshot.data!.docs.map((document) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: GestureDetector(
                          onTap: () async {
                            await FlutterDownloader.enqueue(
                              url: document['link'],
                              savedDir: '/storage/emulated/0/Download/',
                              showNotification:
                                  true, // Optional: show a notification with progress
                              openFileFromNotification:
                                  true, // Optional: open the file when tapped
                              saveInPublicStorage: true,
                            );
                            //show snackbar for download
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Color(0xffff8800),
                                content: Text(
                                  'Downloading...\nCheck Downloads folder in device',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                duration: Duration(seconds: 2),
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
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  document['name'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.download,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    //download file
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
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

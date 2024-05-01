import 'package:flutter/material.dart';
//auth
import 'package:firebase_auth/firebase_auth.dart';
//firestore
import 'package:cloud_firestore/cloud_firestore.dart';

class AllExams extends StatefulWidget {
  const AllExams({super.key});

  @override
  State<AllExams> createState() => _AllExamsState();
}

class _AllExamsState extends State<AllExams> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1E7BC5),
        title: Image.asset('assets/name.png', height: 24),
        centerTitle: false,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'My Exams',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 10),
              //get docid of all document in collection userdata doc email and subcollection exams use column instead of listview
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('userdata')
                    .doc(FirebaseAuth.instance.currentUser!.email)
                    .collection('exams')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Column(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 5),
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
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      document.id,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w700,
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
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

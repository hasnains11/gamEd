import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Announcement {
  final String title;
  final String teacherName;
  final DateTime date;
  final String description;

  Announcement({
    required this.title,
    required this.teacherName,
    required this.date,
    required this.description,
  });
}


class StudentAnnouncements extends StatelessWidget {
  StudentAnnouncements({Key? key}) : super(key: key);
  var announcements = [Announcement(
    title: 'New Course Available!',
    teacherName: 'John Doe',
    date: DateTime.parse('2022-05-01'),
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  ), Announcement(
    title: 'New Feature Added!',
    teacherName: 'Jane Smith',
    date: DateTime.parse('2022-05-02'),
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  ), Announcement(
    title: 'New Teacher Joined!',
    teacherName: 'Bob Johnson',
    date: DateTime.parse('2022-05-03'),
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  )
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 8),
          const Text("Global Announcements",
          style:  TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          ),
          SizedBox(height: 4),
          Container(
            height: Get.height * 0.74,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('announcements')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                  itemBuilder: (BuildContext context, int index) {
                    final DocumentSnapshot doc = snapshot.data!.docs[index];
                    final announcement = Announcement(
                      title: doc['heading'],
                      teacherName: doc['creator'],
                      date: doc['timestamp'].toDate(),
                      description: doc['text'],
                    );

                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.red.withOpacity(0.1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            announcement.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Divider(),
                          SizedBox(height: 4),
                          Text(
                            announcement.description,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 4),
                          Divider(),
                          Text(
                            "Announcement by ",
                            style: TextStyle(fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            announcement.teacherName,
                            style: TextStyle(fontSize: 10
                                ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            announcement.date.toString(),
                            style: TextStyle(fontSize: 14),
                          ),


                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

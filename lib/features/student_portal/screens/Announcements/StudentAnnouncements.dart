import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Announcement {
  final String title;
  final String teacherName;
  final DateTime date;
  final String description;
  bool isRead; // Added property to track read status

  Announcement({
    required this.title,
    required this.teacherName,
    required this.date,
    required this.description,
    this.isRead = false, // Default value for isRead is false
  });
}

class StudentAnnouncements extends StatelessWidget {
  StudentAnnouncements({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffF8B195),
                Color(0xffC06C84),
                Color(0xff6C5B7B),
                Color(0xffF67280),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Global Announcements",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('announcements')
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final DocumentSnapshot doc = snapshot.data!.docs[index];
                final announcement = Announcement(
                  title: doc['heading'],
                  teacherName: doc['creator'],
                  date: doc['timestamp'].toDate(),
                  description: doc['text'],
                  isRead: doc['isRead'] ?? false, // Read status from Firestore
                );

                final textColor = announcement.isRead ? Colors.grey[700] : Colors.black;

                return GestureDetector(
                  onTap: () {
                    // Mark the announcement as read
                    FirebaseFirestore.instance
                        .collection('announcements')
                        .doc(doc.id)
                        .update({'isRead': true});
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(16),
                      color: announcement.isRead ? Colors.grey[200] : Colors.red.withOpacity(0.1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              announcement.title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                      announcement.isRead ?Icon(Icons.check_circle_outline):Text("mark as read"),
                ],
                        ),
                        Divider(),
                        SizedBox(height: 4),
                        Text(
                          announcement.description,
                          style: TextStyle(
                            fontSize: 16,
                            color: textColor,
                          ),
                        ),
                        SizedBox(height: 4),
                        Divider(),
                        Text(
                          "Announcement by",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                        Text(
                          announcement.teacherName,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          announcement.date.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

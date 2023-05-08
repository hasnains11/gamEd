import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ClassroomDetailsScreen extends StatefulWidget {
  final String classroomId;
  final String className;
  final String classCode;
  final String teacherName;

  ClassroomDetailsScreen({
    required this.classroomId,
    required this.className,
    required this.classCode,
    required this.teacherName,
  });

  @override
  _ClassroomDetailsScreenState createState() => _ClassroomDetailsScreenState();
}

class _ClassroomDetailsScreenState extends State<ClassroomDetailsScreen> {
  List<Map<String,dynamic>> students = [];
  TextEditingController announcementController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchStudents();
  }

  Future<void> fetchStudents() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('classrooms')
        .doc(widget.classroomId)
        .get();

    Map<String, dynamic>? classroomData = snapshot.data();
    if (classroomData != null) {
      List<dynamic> studentsData = classroomData['students'] ?? [];
      setState(() {
        students = studentsData.map((student) => student as Map<String, dynamic>).toList();
      });

      print(classroomData);

      print(students);
    }

  }

  Future<void> addAnnouncement() async {
    String announcement = announcementController.text.trim();

    if (announcement.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('classrooms')
          .doc(widget.classroomId)
          .collection('announcements')
          .add({
        'announcement': announcement,
        'timestamp': Timestamp.now(),
      });

      announcementController.clear();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.className),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Class Code: ${widget.classCode}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Teacher: ${widget.teacherName}',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Students (${students.length}):',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  String studentName = students[index]['userData']['fullName'];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        studentName[0].toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: Colors.blue,
                    ),
                    title: Text(studentName),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Announcements',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('classrooms')
                    .doc(widget.classroomId)
                    .collection('announcements')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<DocumentSnapshot> announcementDocs =
                        snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: announcementDocs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot announcementDoc =
                        announcementDocs[index];
                        Map<String, dynamic> announcementData =
                        announcementDoc.data() as Map<String, dynamic>;

                        String announcement =
                        announcementData['announcement'];
                        Timestamp timestamp = announcementData['timestamp'];

                        // Convert timestamp to a readable format
                        DateTime dateTime = timestamp.toDate();

                        String formattedDateTime =DateFormat.yMMMMd().add_jm().format(dateTime);

                        return ListTile(
                        title: Text(announcement),
                        subtitle: Text(formattedDateTime),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: announcementController,
              decoration: InputDecoration(
                labelText: 'Add Announcement',
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              child: Text('Add Announcement'),
              onPressed: addAnnouncement,
            ),
          ],
        ),
      ),
    );
  }
}



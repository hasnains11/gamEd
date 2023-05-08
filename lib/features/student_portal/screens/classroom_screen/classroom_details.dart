import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/Classroom.dart';

class ClassroomDetails extends StatefulWidget {
  final Classroom classroom;

  ClassroomDetails({required this.classroom});

  @override
  _ClassroomDetailsState createState() => _ClassroomDetailsState();
}

class _ClassroomDetailsState extends State<ClassroomDetails> {
  late List<Announcement> announcements=[];

  @override
  void initState() {
    super.initState();
    // Fetch announcements for the classroom from Firestore
    fetchAnnouncements();
  }

  void fetchAnnouncements() {
    FirebaseFirestore.instance
        .collection('classrooms')
        .doc(widget.classroom.id)
        .collection('announcements')
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      List<Announcement> fetchedAnnouncements = [];
      snapshot.docs.forEach((DocumentSnapshot doc) {
        fetchedAnnouncements.add(
          Announcement(
            teacherName: widget.classroom.teacherName,
            date: doc['timestamp'].toDate(),
            description: doc['announcement'],
          ),
        );
      });

      setState(() {
        announcements = fetchedAnnouncements;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    print(widget.classroom.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.classroom.name),
      ),
      body: ListView(
        children: [
          SizedBox(height: 12),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            padding: EdgeInsets.symmetric(horizontal: 4,
            vertical: 5),
            decoration: BoxDecoration(

              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.withOpacity(0.1),
            ),
            child: Column(
              children: [
                _buildSectionTitle('Classroom Details'),
                  Divider(height: 3,),
                  buildRowWidget("Teacher Name", widget.classroom.teacherName),
                  buildRowWidget("No. of Students", widget.classroom.students.length.toString()),
                  buildRowWidget("Class Name", widget.classroom.name),
                  buildRowWidget("Joining Code", widget.classroom.joiningCode),
              ],
            ),
          ),

          SizedBox(height: 12),
          _buildSectionTitle('Students in this class (${widget.classroom.students.length})'),
          Container(
            alignment: Alignment.topCenter,
              height: Get.height * 0.2,
              child: ListView(
                  children: [
                    _buildStudentsList(),
                  ])),
          SizedBox(height: 8),
          _buildSectionTitle('Announcements for this class (${announcements.length})'),
          SizedBox(height: 8),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.withOpacity(0.1),
            )
            ,
            height: Get.height * 0.32,
            child: ListView(children: [_buildAnnouncementsList()]),
          ),

          _buildStartLearningButton(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildAnnouncementsList() {
    return announcements.length!=0?ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: announcements.length,
      itemBuilder: (context, index) {
        Announcement announcement = announcements[index];
        return Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
            color: Colors.black.withOpacity(0.1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 4),
              Text(
                announcement.description,
                style: TextStyle(fontSize: 13
                ),

              ),
              SizedBox(height: 2),
              Divider(),
              Text(
                'Announcement by ${announcement.teacherName}',
                style: TextStyle(fontSize: 10,
                fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                announcement.date.toString(),
                style: TextStyle(fontSize: 9),
              ),
            ],
          ),
        );
      },
    ):Center(child: Text('No Announcements yet'));
  }

  Widget _buildStudentsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.classroom.students.length,
      itemBuilder: (context, index) {
        String studentEmail = widget.classroom.students[index]['email'];
        //
        // Retrieve the student's name from the email
        String studentName =
            studentEmail.substring(0, studentEmail.indexOf('@'));
        return ListTile(
          leading: CircleAvatar(
            // Add the student's profile picture here
            backgroundImage: NetworkImage(
              widget.classroom.students[index]['profilePictureUrl'],
            ),
          ),
          title: Text(studentName),
          subtitle: Text(studentEmail),
        );
      },
    );
  }

  Widget _buildStartLearningButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: () {
          // Implement the logic for starting the learning process
        },
        child: Text(
          'Start Learning',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
Widget buildRowWidget(String label, String value) {
  return Row(
    children: [
      Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      Spacer(),
      Text(value),
    ],
  );
}




class Announcement {
  final String teacherName;
  final DateTime date;
  final String description;

  Announcement({
    required this.teacherName,
    required this.date,
    required this.description,
  });
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gamed/repositories/authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../student_portal/screens/bottom_navbar.dart';
import '../../../student_portal/screens/leaderboard_screen/leaderboard_screen.dart';
import '../teacher_dashboard.dart';

class CreateAnnouncementScreen extends StatefulWidget {
  @override
  _CreateAnnouncementScreenState createState() =>
      _CreateAnnouncementScreenState();
}

class _CreateAnnouncementScreenState extends State<CreateAnnouncementScreen> {
  TextEditingController _announcementController = TextEditingController();
  TextEditingController _headingtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Global Announcements'),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 1,
        onItemTapped: (index) {
          if (index == 0) {
            Get.off(() => TeacherDashboardScreen());
          } else if (index == 1) {
            Get.off(() => CreateAnnouncementScreen());
          } else if (index == 2) {
            Get.off(() => LeaderboardScreen(
                  selectedindex: 2,
                ));
          } else if (index == 3) {
            // Get.to(()=>ProfilePictureWidget());
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Classroom',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.announcement),
            label: 'Announcement',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: "Leaderboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Recent Announcements",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('announcements')
                    .where('creator',
                        isEqualTo: AuthenticationRepository
                            .instance.firebaseUser.value?.email)
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    // Handle any error that occurred while fetching the announcements
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Display a loading indicator while waiting for the data to load
                    return CircularProgressIndicator();
                  }

                  // Extract the list of announcements from the snapshot data
                  List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
                      snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      // Extract the announcement data from the document snapshot
                      Map<String, dynamic> data = documents[index].data();

                      // Handle the case where the timestamp is null
                      DateTime timestamp =
                          data['timestamp']?.toDate() ?? DateTime.now();

                      // Create an Announcement object from the data
                      Announcement announcement = Announcement(
                        heading: data['heading'] ?? '',
                        creator: data['creator'] ?? '',
                        text: data['text'] ?? '',
                        timestamp: timestamp.toLocal(),
                      );

                      // Display the announcement in a ListTile or custom widget
                      return Container(
                        margin: EdgeInsets.only(bottom: 8.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(announcement.heading),
                              subtitle: Text(announcement.text),
                            ),
                            Divider(),
                            Text(announcement.timestamp.toString())
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 4.0,
            ),
            child: TextField(
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              controller: _headingtController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(8.0),
                labelText: 'Heading',
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 4.0,
            ),

            child: TextField(

              controller: _announcementController,
              style: TextStyle(fontSize: 14),

              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(3.0),
                  labelText: 'Announcement',
              ),
            ),
          ),
          SizedBox(height: 5.0),
          ElevatedButton(
            child: Text('Create Announcement'),
            onPressed: _createAnnouncement,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              foregroundColor: MaterialStateProperty.all(Colors.white),
            ),
          ),
        ],
      ),
    );

  }

  Future<void> _createAnnouncement() async {
    String announcementText = _announcementController.text;
    String headingText = _headingtController.text;

    if (announcementText.isNotEmpty) {
      try {
        CollectionReference announcementsCollection =
            FirebaseFirestore.instance.collection('announcements');

        // Create a new document and upload the announcement data
        await announcementsCollection.add({
          'heading': headingText,
          'text': announcementText,
          'creator': AuthenticationRepository.instance.currentUser['email'],
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Show a success message or perform any other actions
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Announcement created successfully.'),
          ),
        );
        _headingtController.clear();
        _announcementController.clear();
      } catch (e) {
        // Handle any errors that occur during the data upload
        print('Error creating announcement: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating announcement.'),
          ),
        );
      }
    } else {
      // Show an error message if the announcement text is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter the announcement text and heading.'),
        ),
      );
    }
  }
}

class Announcement {
  final String text;
  final String heading;
  final String creator;
  final DateTime timestamp;

  Announcement({
    required this.heading,
    required this.creator,
    required this.text,
    required this.timestamp,
  });

  String get formattedDate {
    return DateFormat.yMMMd().format(timestamp);
  }

  factory Announcement.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    String text = data['text'];
    String heading = data['heading'];
    String creator = data['creator'];
    Timestamp timestamp = data['timestamp'];
    DateTime dateTime = timestamp.toDate();
    return Announcement(
      creator: creator,
      heading: heading,
      text: text,
      timestamp: dateTime,
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamed/features/student_portal/screens/user_profile/student_profile.dart';
import 'package:get/get.dart';

import '../../../teacher_portal/screens/create_announcements/create_announcement_screen.dart';
import '../../../teacher_portal/screens/teacher_dashboard.dart';
import '../bottom_navbar.dart';

class LeaderboardScreen extends StatefulWidget {
  int? selectedindex;
  final bool? isTeacherPortal;
  final List<BottomNavigationBarItem>? bottomNavbarItems;
  final AppBar? appBar;
  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();

  LeaderboardScreen({Key? key,this.selectedindex,this.bottomNavbarItems,this.isTeacherPortal,this.appBar}) : super(key: key);
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {

  getParticipants() async {
    List<Map<String, dynamic>> participants = [];

    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('scores')
          .get();

      if (snapshot != null) {
        print("snaps lenghth ${snapshot.docs.length}");
        snapshot.docs.forEach((doc) {
          print("entering snapshots");
          print(doc.data());

          Map<String, dynamic> data = doc.data();
          String name = doc.id.split('@')[0]; // Use the document ID as the name
          int score = data['score'];
          participants.add({
            'name': name,
            'score': score,
          });
        });

        participants.sort((a, b) => b['score'].compareTo(a['score']));
        setState(() {
          this.participants = participants;
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }



  @override
  void initState() {
    super.initState();
  getParticipants();
  }

  List<Map<String, dynamic>> participants = [

  ];

  @override
  Widget build(BuildContext context) {
    participants.sort((a, b) => b['score'].compareTo(a['score']));
    print("selected Index ${widget.selectedindex}");
    return Scaffold(
      appBar:widget.appBar,
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: widget.isTeacherPortal??false ? BottomNavBar(

        selectedIndex: widget.selectedindex??0,
        onItemTapped: (index){
          if(index==0){
            Get.off(()=>TeacherDashboardScreen());
          }
          else if(index==1){
            Get.off(()=>CreateAnnouncementScreen());
          }
          else if(index==2){

          }
          else if(index==3){
            widget.isTeacherPortal==null ? Get.to(()=>ProfileScreen()):
                Get.off(
                    ()=> ProfileScreen(
                      appBar: AppBar(
                          title: Text('Profile'),
                          centerTitle: true,
                          flexibleSpace: Container(
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xff334D50),
                                  Color(0xff45B69C),
                                  Color(0xffEFC94C),
                                  Color(0xffAB3E5B),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                          )
                      ),
                      selectedindex: 3,
                      isTeacherPortal: true,
                      bottomNavbarItems: [
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

                    )
                                  );

          }
        },
        items: widget.bottomNavbarItems??[],
      ):null,
      body: Container(
        child: RefreshIndicator(
          onRefresh: () async {
            getParticipants();
          },
          child: Column(

            children: [
              SizedBox(height: 20.0),
              Text("Leaderboard", style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(height: 10.0),
              _getTopParticipantsWidget(),
              SizedBox(height: 20.0),
              Expanded(
                child: participants.length>3?ListView.builder(
                  itemCount: participants.length - 3,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            // color: Colors.grey[400],
                            blurRadius: 5.0,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${index + 4}. ${participants[index + 3]['name ']==null?
                            participants[index+3]['name']
                                :participants[index + 3]['name ']}",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            "${participants[index + 3]['score']}",
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ):Text(""),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getTopParticipantsWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            // color: Colors.grey,
            blurRadius: 5.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      padding: EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          participants.length>=1?Expanded(child: _getTopParticipantWidget(0)):Text(""),
          participants.length>=2?Expanded(child: _getTopParticipantWidget(1)):Text(""),
          participants.length>=3? Expanded(child: _getTopParticipantWidget(2)):Text(""),
        ],
      ),
    );
  }

  Widget _getTopParticipantWidget(int index) {
    print("index $index ${participants[index]['score']}");

    getImage(int index){
    switch(index){
      case 0:
        return "assets/logo/first.png";
      case 1:
        return "assets/logo/second.png";
      case 2:
        return "assets/logo/third.png";
        default:
        return "";
    }
    }
    return Column(
        children: [
          CircleAvatar(
            radius: 30.0,
            // backgroundImage: AssetImage(getImage(index)),
            backgroundColor: Colors.transparent,
              child: Image.asset(getImage(index)),
          ),


          SizedBox(height: 10.0),
    Text(
      // "",
    participants[index]['name']!=null?participants[index]['name']:"Dummy Name",
    overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.bold,


    ),
    ),
    SizedBox(height: 5.0),
    // Text(
    // participants[index]['class'],
    // style: TextStyle(
    // fontSize: 14.0,
    // color: Colors.grey[600],
    // ),
    // ),
    SizedBox(height: 5.0),

    Text(
    "${participants[index]['score']}",
    style: TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    ),
    ),
    ],
    )
    ;
  }
}


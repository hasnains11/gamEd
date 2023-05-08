import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../teacher_portal/screens/create_announcements/create_announcement_screen.dart';
import '../../../teacher_portal/screens/teacher_dashboard.dart';
import '../bottom_navbar.dart';

class LeaderboardScreen extends StatefulWidget {
  int? selectedindex;
  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();

  LeaderboardScreen({Key? key,this.selectedindex}) : super(key: key);
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {

  getParticipants() async {
    List<Map<String, dynamic>> participants = [];

    try {
      QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('leaderboard').get();
      print("snaps lenghth ${snapshot.docs.length}");
      snapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        participants.add(data);
      });
      participants.sort((a, b) => int.parse(b['score']).compareTo(int.parse(a['score'])));
      print("asfdf $participants");
    } catch (e) {
      print(e.toString());
    }

   setState(() {
      this.participants = participants;
   });
  }




  // getParticipants() async {
  //   List<Map<String, dynamic>> participants = [];
  //
  //   try {
  //     QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
  //         .instance
  //         .collection('leaderboard')
  //         .orderBy('score', descending: true)
  //         .get();
  //
  //     if (snapshot != null) {
  //       print("snaps lenghth ${snapshot.docs.length}");
  //       snapshot.docs.forEach((doc) {
  //       print("entering snapshots");
  //         print(doc.data());
  //
  //           Map<String, dynamic> data = doc.data();
  //         participants.add(data);
  //       });
  //       setState(() {
  //         this.participants = participants;
  //       });
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  @override
  void initState() {
    super.initState();
  getParticipants();
  }

  List<Map<String, dynamic>> participants = [

  ];

  @override
  Widget build(BuildContext context) {
    participants.sort((a, b) => int.parse(b['score']).compareTo(int.parse(a['score'])));
    // participants.sort((a, b) => a['score'].compareTo(b['score']));
    // print(participants);
    // print(participants[0]['score']);
    // print(participants[1]['score']);
    // print(participants[2]['score']);
    // print(participants[1]['score']);
    print("selected Index ${widget.selectedindex}");
    return Scaffold(
      backgroundColor: Colors.grey[200],
      // bottomNavigationBar:  BottomNavBar(
      //
      //   selectedIndex: widget.selectedindex??0,
      //   onItemTapped: (index){
      //     if(index==0){
      //       Get.off(()=>TeacherDashboardScreen());
      //     }
      //     else if(index==1){
      //       Get.off(()=>CreateAnnouncementScreen());
      //     }
      //     else if(index==2){
      //       Get.off(()=>LeaderboardScreen());
      //     }
      //     else if(index==3){
      //       // Get.to(()=>ProfilePictureWidget());
      //     }
      //   },
      //   items: [ BottomNavigationBarItem(
      //     icon: Icon(Icons.dashboard),
      //     label: 'Classroom',
      //   ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.announcement),
      //       label: 'Announcement',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.leaderboard),
      //       label: "Leaderboard",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Profile',
      //     ),],
      // ),
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
                          // Text(
                          //   participants[index + 3]['class'],
                          //   style: TextStyle(
                          //     fontSize: 16.0,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
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




// import 'package:flutter/material.dart';
//
// class LeaderboardScreen extends StatelessWidget {
//   final List<Map<String, dynamic>> participants = [
//     {"name": "John", "class": "A", "score": 98},
//     {"name": "Sarah", "class": "B", "score": 95},
//     {"name": "Michael", "class": "A", "score": 92},
//     {"name": "Emma", "class": "C", "score": 89},
//     {"name": "David", "class": "B", "score": 86},
//     {"name": "Olivia", "class": "C", "score": 83},
//     {"name": "William", "class": "A", "score": 80},
//     {"name": "Sophia", "class": "B", "score": 77},
//     {"name": "James", "class": "C", "score": 74},{"name": "John", "class": "A", "score": 98},
//     {"name": "Sarah", "class": "B", "score": 95},
//     {"name": "Michael", "class": "A", "score": 92},
//     {"name": "Emma", "class": "C", "score": 89},
//     {"name": "David", "class": "B", "score": 86},
//     {"name": "Olivia", "class": "C", "score": 83},
//     {"name": "William", "class": "A", "score": 80},
//     {"name": "Sophia", "class": "B", "score": 77},
//     {"name": "James", "class": "C", "score": 74},{"name": "John", "class": "A", "score": 98},
//     {"name": "Sarah", "class": "B", "score": 95},
//     {"name": "Michael", "class": "A", "score": 92},
//     {"name": "Emma", "class": "C", "score": 89},
//     {"name": "David", "class": "B", "score": 86},
//     {"name": "Olivia", "class": "C", "score": 83},
//     {"name": "William", "class": "A", "score": 80},
//     {"name": "Sophia", "class": "B", "score": 77},
//     {"name": "James", "class": "C", "score": 74},
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Leaderboard"),
//       ),
//       body: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.symmetric(vertical: 10.0),
//             decoration: BoxDecoration(
//               color: Colors.yellow[100],
//               border: Border(
//                 bottom: BorderSide(width: 1.0),
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 _getTopParticipantWidget(0),
//                 _getTopParticipantWidget(1),
//                 _getTopParticipantWidget(2),
//               ],
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: participants.length - 3,
//               itemBuilder: (context, index) {
//                 return Container(
//                   padding: EdgeInsets.symmetric(vertical: 10.0),
//                   decoration: BoxDecoration(
//                     border: Border(
//                       bottom:
//                       BorderSide(width: 1.0),
//                     ),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Text("${index + 4}. ${participants[index + 3]['name']}"),
//                       Text(participants[index + 3]['class']),
//                       Text("${participants[index + 3]['score']}"),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _getTopParticipantWidget(int index) {
//     return Column(
//       children: [
//         CircleAvatar(
//           radius: 30.0,
//           backgroundImage: NetworkImage(
//               'https://randomuser.me/api/portraits/${index % 2 == 0 ? 'men' : 'women'}/${index + 1}.jpg'),
//         ),
//         SizedBox(height: 8.0),
//         Text(participants[index]['name']),
//         SizedBox(height: 4.0),
//         Text(participants[index]['class']),
//         SizedBox(height: 4.0),
//         Text(
//           "${participants[index]['score']}",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 18.0,
//           ),
//         ),
//       ],
//     );
//   }
// }

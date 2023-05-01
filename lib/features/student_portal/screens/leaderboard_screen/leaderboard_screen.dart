import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  final List<Map<String, dynamic>> participants = [
    {"name": "John", "class": "A", "score": 98},
    {"name": "Sarah", "class": "B", "score": 95},
    {"name": "Michael", "class": "A", "score": 92},
    {"name": "Emma", "class": "C", "score": 89},
    {"name": "David", "class": "B", "score": 86},
    {"name": "Olivia", "class": "C", "score": 83},
    {"name": "William", "class": "A", "score": 80},
    {"name": "Sophia", "class": "B", "score": 77},
    {"name": "James", "class": "C", "score": 74},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
    
      body: Column(
        children: [
          SizedBox(height: 10.0),
          _getTopParticipantsWidget(),
          SizedBox(height: 20.0),
          Expanded(
            child: ListView.builder(
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
                        "${index + 4}. ${participants[index + 3]['name']}",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        participants[index + 3]['class'],
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${participants[index + 3]['score']}",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
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
          _getTopParticipantWidget(0),
          _getTopParticipantWidget(1),
          _getTopParticipantWidget(2),
        ],
      ),
    );
  }

  Widget _getTopParticipantWidget(int index) {
    return Column(
        children: [
        CircleAvatar(
        radius: 30.0,
        backgroundImage: NetworkImage('https://randomuser.me/api/portraits/${index % 2 == 0 ? 'men' : 'women'}/${index + 1}.jpg'),
    ),
    SizedBox(height: 10.0),
    Text(
    participants[index]['name'],
    style: TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    ),
    ),
    SizedBox(height: 5.0),
    Text(
    participants[index]['class'],
    style: TextStyle(
    fontSize: 14.0,
    color: Colors.grey[600],
    ),
    ),
    SizedBox(height: 5.0),
    Text(
    "${participants[index]['score']}",
    style: TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    ),
    ),
    ],
    );
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

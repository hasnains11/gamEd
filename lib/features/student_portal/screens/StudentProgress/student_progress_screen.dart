import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gamed/features/student_portal/screens/student_dashboard/badges_section.dart';
import 'package:gamed/repositories/authentication_repository/authentication_repository.dart';
import 'package:pie_chart/pie_chart.dart';

class StudentProgressScreen extends StatefulWidget {
  const StudentProgressScreen({Key? key}) : super(key: key);

  @override
  _StudentProgressScreenState createState() => _StudentProgressScreenState();
}

class _StudentProgressScreenState extends State<StudentProgressScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> _participants = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getParticipants();
  }

  Future<void> getParticipants() async {
    try {
      String userId = _auth.currentUser!.uid;
      String name =AuthenticationRepository.instance.currentUser!['userData']['fullName'];
      String email = _auth.currentUser!.email ?? '';

      setState(() {
        _participants = [
          {
            'name': name,
            'email': email,
            'score': '0', // Set an initial score value
          }
        ];
        _isLoading = false;
      });

      FirebaseFirestore.instance
          .collection('scores')
          .doc(email)
          .snapshots()
          .listen((DocumentSnapshot snapshot) {
        if (snapshot.exists) {
          Map<String, dynamic> data =
          snapshot.data() as Map<String, dynamic>;
          setState(() {
            _participants[0]['score'] = data['score'];
          });
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Progress'),
        centerTitle: true,
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
      ),
      body:  Container(
        color: Colors.grey[200],
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                _participants[0]['name']??"",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _participants[0]['email']??"",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 10),
              PieChart(
                dataMap: {
                  'Total':100.0 -
                      double.parse(_participants[0]['score'].toString()??"0"),
                  'Score': double.parse(_participants[0]['score'].toString()??"0"),

                },
                chartRadius: MediaQuery.of(context).size.width / 2,
                legendOptions: const LegendOptions(
                  showLegendsInRow: false,
                  legendPosition: LegendPosition.right,
                  legendTextStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                initialAngleInDegree: 0,
                chartType: ChartType.disc,
                chartValuesOptions: ChartValuesOptions(
                  showChartValues: false,
                  showChartValuesInPercentage: true,
                  showChartValuesOutside: false,
                  decimalPlaces: 0,
                  chartValueStyle: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 11),
              Text(
                'Your Score: ${_participants[0]['score']??"0"}/100',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(),
              BadgeSection(badgesEarned: [0],),

            ],
          ),
        ),
      ),
    );
  }
}

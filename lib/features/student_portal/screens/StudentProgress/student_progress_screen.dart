import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class StudentProgressScreen extends StatefulWidget {
  const StudentProgressScreen({Key? key}) : super(key: key);

  @override
  _StudentProgressScreenState createState() => _StudentProgressScreenState();
}

class _StudentProgressScreenState extends State<StudentProgressScreen> {
  final List<Course> _courses = [
    Course(
        name: 'Programming Fundamentals',
        progress: 75,
        assignmentsCompleted: 10,
        totalAssignments: 15),
    Course(
        name: 'Javascript',
        progress: 60,
        assignmentsCompleted: 8,
        totalAssignments: 12),
    Course(
        name: 'C#',
        progress: 90,
        assignmentsCompleted: 12,
        totalAssignments: 12),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Progress'),
      ),
      body: ListView.builder(
        itemCount: _courses.length,
        itemBuilder: (BuildContext context, int index) {
          final course = _courses[index];
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.name,
                      style: const
                      TextStyle(fontSize: 18,
                        fontWeight: FontWeight.bold,),
                    ),
                    const SizedBox(height: 5),

                    Row(
                      children: [
                        const Text('Progress: '),

                        Text(
                          '${course.progress}%',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearPercentIndicator(
                      percent: course.progress.toDouble()/100,
                      animation: true,
                      lineHeight: 20, // the height of the progress bar
                      // progressColor: Colors.green.withOpacity(0.5),
                      linearGradient: LinearGradient(colors: [Colors.green.withOpacity(0.9),Colors.red.withOpacity(0.4),Colors.purple.withOpacity(0.4)])    ,
                      barRadius: Radius.circular(12),// the color of the progress bar
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text('Assignments Completed: '),
                        Text(
                          '${course.assignmentsCompleted}/${course.totalAssignments}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Course {
  final String name;
  final int progress;
  final int assignmentsCompleted;
  final int totalAssignments;

  const Course(
      {required this.name,
        required this.progress,
        required this.assignmentsCompleted,
        required this.totalAssignments});
}

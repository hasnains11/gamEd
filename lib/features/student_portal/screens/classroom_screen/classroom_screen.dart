import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/ClassroomController.dart';
import '../../model/Classroom.dart';

class ClassroomScreen extends StatelessWidget {
  final classroomController = Get.put(ClassroomController());

  @override
  Widget build(BuildContext context) {
    print(classroomController.classrooms.value.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text('Classrooms'),
      ),
      body: Obx(() => ListView.builder(
            itemCount: classroomController.classrooms.length,
            itemBuilder: (context, index) {
              final classroom = classroomController.classrooms[index];
              return Padding(
                padding: EdgeInsets.all(16),
                child: Card(
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          'https://picsum.photos/200/300',
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 16),
                        Text(
                          classroom.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          classroom.teacher,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.calendar_today,
                                size: 16, color: Colors.grey[600]),
                            SizedBox(width: 4),
                            Text(
                              'Due Date',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print("button pressed");

          print("dione");
          // TODO: Implement join classroom functionality
          classroomController.loadClassrooms();
          print(classroomController.classrooms.value.toString());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

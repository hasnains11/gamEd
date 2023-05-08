import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../repositories/authentication_repository/authentication_repository.dart';
import '../../controllers/ClassroomController.dart';
import '../../model/Classroom.dart';
import 'classroom_details.dart';
import 'joinClasroomDialog.dart';

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
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          classroom.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Teacher: ${classroom.teacherName}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Joining Code: ${classroom.joiningCode}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Students: ${classroom.students.length}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Handle join classroom action
                                Get.to(() => ClassroomDetails(
                                      classroom: classroom,
                                    ));
                              },
                              child: Text('Start'),
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

          showJoinClassroomDialog(context);
          print("dione");
          // TODO: Implement join classroom functionality
          // classroomController.loadClassrooms();
          // print(classroomController.classrooms.value.toString());
        },
        child: Icon(Icons.add),
      ),
    );


  }
  void showJoinClassroomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return JoinClassroomDialog();
      },
    );
  }

}

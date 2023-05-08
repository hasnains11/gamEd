import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/ClassroomController.dart';

class JoinClassroomDialog extends StatefulWidget {
  @override
  _JoinClassroomDialogState createState() => _JoinClassroomDialogState();
}

class _JoinClassroomDialogState extends State<JoinClassroomDialog> {
  final TextEditingController _joiningCodeController = TextEditingController();
  final classroomController = Get.put(ClassroomController());

  @override
  void dispose() {
    _joiningCodeController.dispose();
    super.dispose();
  }

  void _joinClassroom() async {
    final String joiningCode = _joiningCodeController.text;
    // Call the joinClassroom function here and pass the joining code
    await classroomController.joinClassroom(joiningCode);
    Navigator.pop(context); // Close the dialog box
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Join Classroom'),
      content: TextField(
        controller: _joiningCodeController,
        decoration: InputDecoration(hintText: 'Enter joining code'),
      ),
      actions: [
        ElevatedButton(
          onPressed: _joinClassroom,
          child: Text('Join'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context), // Close the dialog box
          child: Text('Cancel'),
        ),
      ],
    );
  }
}



import 'package:cloud_firestore/cloud_firestore.dart';

class Classroom {
  String name;
  String teacher;
  List<String> students;

  Classroom(
      {required this.name, required this.teacher, required this.students});

  // factory Classroom.fromDocumentSnapshot(DocumentSnapshot doc) {
  //   return Classroom(
  //     id: doc.id,
  //     name: doc['name'],
  //     description: doc['description'],
  //   );
  // }
}

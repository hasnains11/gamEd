import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../model/Classroom.dart';

class ClassroomController extends GetxController {
  RxList<Classroom> classrooms = RxList<Classroom>([]);

  @override
  void onInit() {
    super.onInit();
    loadClassrooms();
  }

  void loadClassrooms() async {
    // final userId = FirebaseAuth.instance.currentUser!.uid;
    final useremail = FirebaseAuth.instance.currentUser!.email;
    // await FirebaseFirestore.instance
    //     .collection('classrooms')
    //     .where('students', arrayContains: useremail)
    //     .snapshots().listen((snapshot) {
    //   classrooms.value = snapshot.docs
    //       .map((doc) => Classroom.fromDocumentSnapshot(doc))
    //       .toList();
    // });
    // var result =
    //     await FirebaseFirestore.instance.collection('classrooms').get();
    var result = await FirebaseFirestore.instance
        .collection('classrooms')
        .where('students', arrayContains: useremail)
        .get();

    print(result.docs.length);
    print(FirebaseAuth.instance.currentUser?.email);
    print(result.toString());

    classrooms.value = result.docs.map((element) {
      var data = element.data();
      return (Classroom(
          name: data['name'],
          teacher: data['teacher'],
          students:[]));
      // print(element.data());
    }).toList();

    print(classrooms.value);

    print('classrooms loaded');

  }
}

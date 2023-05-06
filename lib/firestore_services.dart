import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

fetchUser() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: user.email)
        .get();
    if (snapshot.docs.isNotEmpty) {
      final doc = snapshot.docs.first;
      return doc.data();
    }
  }
  return null;
}
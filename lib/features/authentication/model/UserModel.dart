class UserModel {
  final String email;
  final String password;
  final String role;
  final Map<String, dynamic> userData;

  UserModel({
    required this.email,
    required this.password,
    required this.role,
    required this.userData,
  });

  // factory UserModel.fromFirestore(DocumentSnapshot doc) {
  //   Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //   List<Map<String, dynamic>> userData =
  //   List<Map<String, dynamic>>.from(data['userData'] ?? []);
  //   return UserModel(
  //     id: doc.id,
  //     email: data['email'],
  //     password: data['password'],
  //     role: data['role'],
  //     userData: userData,
  //   );
  // }
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'role': role,
      'userData': userData,
    };
  }
}

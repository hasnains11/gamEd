import 'package:firebase_auth/firebase_auth.dart';
import 'package:gamed/features/authentication/screens/login_screen/login_form.dart';
import 'package:get/get.dart';

import '../../features/authentication/screens/select_role_screen.dart';
import '../../features/authentication/screens/welcome_screen/welcome_screen.dart';
import 'exceptions/login_with_email_password.dart';
import 'exceptions/signup_email_password_failure.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //Variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  //Will be load when app launches this func will be called and set the firebaseUser state
  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  /// If we are setting initial screen from here
  /// then in the main.dart => App() add CircularProgressIndicator()
  _setInitialScreen(User? user) {
    Get.offAll(() => RoleSelectionScreen());

  }

  //FUNC
  Future<String?> createUserWithEmailAndPassword(
      String email, String password, String role) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // Get.offAll(() => const LoginForm());
      firebaseUser.value != null
          ? Get.off(() => RoleSelectionScreen())
          : Get.off(() => const WelcomeScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      return ex.message;
    } catch (_) {
      final ex = SignUpWithEmailAndPasswordFailure();
      return ex.message;
    }
    return null;
  }

  Future<String?> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => RoleSelectionScreen())
          : Get.offAll(() => WelcomeScreen());
    } on FirebaseAuthException catch (e) {
      final ex = LogInWithEmailAndPasswordFailure.fromCode(e.code);
      return ex.message;
    } catch (_) {
      final ex = LogInWithEmailAndPasswordFailure("");
      return ex.message;
    }
    return null;
  }

  Future<void> logout() async {
    await _auth.signOut();
    Get.offAll(WelcomeScreen());
    // Get.off(RoleSelectionScreen());
  }
}

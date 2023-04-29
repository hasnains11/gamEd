class SignUpWithEmailAndPasswordFailure {
  final String message;
  SignUpWithEmailAndPasswordFailure(
      [this.message = "An Unexpected Error Occured"]);
  factory SignUpWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case "email-already-in-use":
        return SignUpWithEmailAndPasswordFailure(
            "The email address is already in use by another account.");
      case "invalid-email":
        return SignUpWithEmailAndPasswordFailure(
            "The email address is badly formatted.");
      case "operation-not-allowed":
        return SignUpWithEmailAndPasswordFailure(
            "Password sign-in is disabled for this project.");
      case "weak-password":
        return SignUpWithEmailAndPasswordFailure(
            "The password must be 6 characters long or more.");
      default:
        return SignUpWithEmailAndPasswordFailure();
    }
  }
}

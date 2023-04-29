class LogInWithEmailAndPasswordFailure {
  final String message;
  LogInWithEmailAndPasswordFailure(
      [this.message = "An Unexpected Error Occured"]);

  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case "invalid-email":
        return LogInWithEmailAndPasswordFailure(
            "The email address is badly formatted.");
      case "user-disabled":
        return LogInWithEmailAndPasswordFailure(
            "The user corresponding to the given email has been disabled.");
      case "user-not-found":
        return LogInWithEmailAndPasswordFailure(
            "There is no user corresponding to the given email.");
      case "wrong-password":
        return LogInWithEmailAndPasswordFailure(
            "The password is invalid or the user does not have a password.");
      default:
        return LogInWithEmailAndPasswordFailure();
    }
  }
}

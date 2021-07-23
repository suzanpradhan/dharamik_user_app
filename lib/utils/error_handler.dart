String handleAuthError(dynamic error) {
  switch (error.code) {
    case "auth/invalid-email":
      return "Your email address appears to be malformed.";
      break;
    case "auth/wrong-password":
      return "Your password is wrong.";
      break;
    case "auth/user-not-found":
      return "User with this email doesn't exist.";
      break;
    case "auth/user-disabled":
      return "User with this email has been disabled.";
      break;
    case "auth/too-many-requests":
      return "Too many requests. Try again later.";
      break;
    case "auth/email-already-in-use":
      return "Email is already registered";
      break;
    default:
      return "Some Error Occurred";
  }
}

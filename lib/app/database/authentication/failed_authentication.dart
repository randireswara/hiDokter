class SignUpWithEmailandPasswordFailure {
  final String message;

  const SignUpWithEmailandPasswordFailure(
      [this.message = "An Unknown erro occured"]);

  factory SignUpWithEmailandPasswordFailure.code(String code) {
    switch (code) {
      case 'weak-password':
        return const SignUpWithEmailandPasswordFailure(
            'Please enter a stronger password');
      case 'invalid-email':
        return const SignUpWithEmailandPasswordFailure('Email is not valid');
      default:
        return const SignUpWithEmailandPasswordFailure();
    }
  }
}

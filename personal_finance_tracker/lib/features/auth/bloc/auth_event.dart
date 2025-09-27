abstract class AuthEvent {}

class AuthSignUp extends AuthEvent {
  final String email;
  final String password;

  AuthSignUp(this.email, this.password);
}

class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  AuthLogin(this.email, this.password);
}

class AuthForgotPassword extends AuthEvent {
  final String email;

  AuthForgotPassword(this.email);
}

class AuthSignOut extends AuthEvent {}

class AuthCheckStatus extends AuthEvent {}
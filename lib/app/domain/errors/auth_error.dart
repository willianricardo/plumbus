import 'package:plumbus/app/domain/errors/errors.dart';

class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

class LoginFailure extends AuthFailure {
  const LoginFailure(super.message);
}

class UnauthorizedUserFailure extends LoginFailure {
  const UnauthorizedUserFailure(super.message);
}

class InvalidUserFailure extends LoginFailure {
  const InvalidUserFailure(super.message);
}

class InvalidPasswordFailure extends LoginFailure {
  const InvalidPasswordFailure(super.message);
}

class InvalidCompanyFailure extends LoginFailure {
  const InvalidCompanyFailure(super.message);
}

class InactiveUserFailure extends LoginFailure {
  const InactiveUserFailure(super.message);
}

class LogoutFailure extends AuthFailure {
  const LogoutFailure(super.message);
}

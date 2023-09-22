class LoginCredentialEntity {
  final String user;
  final String password;
  final int company;

  const LoginCredentialEntity({
    required this.user,
    required this.password,
    required this.company,
  });

  bool get isValidUser => user.isNotEmpty;
  bool get isValidPassword => password.isNotEmpty;
  bool get isValidCompany => !company.isNegative && company > 0;
}

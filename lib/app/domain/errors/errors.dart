import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class MemoryFailure extends Failure {
  const MemoryFailure(super.message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

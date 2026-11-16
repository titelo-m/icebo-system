import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}

class LoginSubmitted extends AuthEvent {
  final String identifier;
  final String password;

  const LoginSubmitted({
    required this.identifier,
    required this.password,
  });

  @override
  List<Object> get props => [identifier, password];
}

class SignupSubmitted extends AuthEvent {
  final String name;
  final String email;
  final String password;
  const SignupSubmitted({required this.name, required this.email, required this.password});
  @override
  List<Object> get props => [name, email, password];
}
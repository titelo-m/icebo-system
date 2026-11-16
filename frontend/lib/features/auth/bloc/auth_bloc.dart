import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 2));

      final identifier = event.identifier.toLowerCase();
      final password = event.password;

      if (identifier.isEmpty || password.isEmpty) {
        emit(const AuthFailure('Please fill in all fields.'));
        return;
      }

      // Admin Check
      if (identifier == 'boss@iceboadmin.com' && password == 'admin123') {
        emit(const AuthSuccess(role: 'admin'));
      } 
      // Employee Check
      else if (identifier.endsWith('@iceboemp.com') && password.length >= 6) {
        emit(const AuthSuccess(role: 'employee'));
      } 
      // Customer Check
      else if (identifier.contains('@') && password.length >= 6) {
        emit(const AuthSuccess(role: 'customer'));
      } 
      else {
        emit(const AuthFailure('Invalid credentials.'));
      }
    });

    on<SignupSubmitted>((event, emit) async {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 2));

      if (event.email.contains('@') && event.password.length >= 6) {
        emit(const AuthSuccess(role: 'customer'));
      } else {
        emit(const AuthFailure('Please check your details.'));
      }
    });
  }
}
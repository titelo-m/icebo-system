import 'package:equatable/equatable.dart';

abstract class AdminState extends Equatable {
  const AdminState();
  @override
  List<Object> get props => [];
}

class AdminInitial extends AdminState {}
class AdminLoading extends AdminState {}
class AdminLoaded extends AdminState {
  final List<Map<String, dynamic>> bookings;
  final List<Map<String, dynamic>> users;

  const AdminLoaded({required this.bookings, required this.users});

  @override
  List<Object> get props => [bookings, users];
}
class AdminError extends AdminState {
  final String message;
  const AdminError(this.message);
  @override
  List<Object> get props => [message];
}
import 'package:equatable/equatable.dart';

abstract class EmployeeState extends Equatable {
  const EmployeeState();
  @override
  List<Object> get props => [];
}

class EmployeeInitial extends EmployeeState {}
class EmployeeLoading extends EmployeeState {}

class EmployeeJobsLoaded extends EmployeeState {
  final List<Map<String, dynamic>> jobs;

  const EmployeeJobsLoaded({required this.jobs});

  @override
  List<Object> get props => [jobs];
}

class EmployeeError extends EmployeeState {
  final String message;
  const EmployeeError(this.message);
  @override
  List<Object> get props => [message];
}
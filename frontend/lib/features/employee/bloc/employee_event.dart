import 'package:equatable/equatable.dart';

abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();
  @override
  List<Object> get props => [];
}

class LoadJobs extends EmployeeEvent {}

class UpdateJobStatus extends EmployeeEvent {
  final String jobId;
  final String newStatus;

  const UpdateJobStatus({required this.jobId, required this.newStatus});

  @override
  List<Object> get props => [jobId, newStatus];
}
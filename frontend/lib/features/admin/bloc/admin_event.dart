import 'package:equatable/equatable.dart';

abstract class AdminEvent extends Equatable {
  const AdminEvent();
  @override
  List<Object> get props => [];
}

class LoadAdminData extends AdminEvent {}

class UpdateBookingStatus extends AdminEvent {
  final String bookingId;
  final String newStatus;

  const UpdateBookingStatus({required this.bookingId, required this.newStatus});

  @override
  List<Object> get props => [bookingId, newStatus];
}
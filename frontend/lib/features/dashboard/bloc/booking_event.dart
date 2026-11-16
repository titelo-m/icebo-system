import 'package:equatable/equatable.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();
  @override
  List<Object> get props => [];
}

class SubmitBooking extends BookingEvent {
  final String serviceType;
  final String specificItem;
  final double amount;
  final String date;
  final String address;
  final String notes;
  final String paymentMethod;

  const SubmitBooking({
    required this.serviceType,
    required this.specificItem,
    required this.amount,
    required this.date,
    required this.address,
    required this.notes,
    required this.paymentMethod,
  });

  @override
  List<Object> get props => [serviceType, specificItem, amount, date, address, notes, paymentMethod];
}
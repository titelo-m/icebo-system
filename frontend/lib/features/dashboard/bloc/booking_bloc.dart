import 'package:flutter_bloc/flutter_bloc.dart';
import 'booking_event.dart';
import 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingInitial()) {
    on<SubmitBooking>((event, emit) async {
      emit(BookingLoading());
      
      await Future.delayed(const Duration(seconds: 2));

      if (event.serviceType.isNotEmpty && event.address.isNotEmpty && event.amount > 0) {
        emit(BookingSuccess('Service booked successfully for ${event.date}. Total: R${event.amount.toStringAsFixed(2)}'));
      } else {
        emit(BookingFailure('Please ensure all required fields are filled.'));
      }
    });
  }
}
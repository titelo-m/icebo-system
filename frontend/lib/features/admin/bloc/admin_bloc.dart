import 'package:flutter_bloc/flutter_bloc.dart';
import 'admin_event.dart';
import 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc() : super(AdminInitial()) {
    on<LoadAdminData>((event, emit) async {
      emit(AdminLoading());
      await Future.delayed(const Duration(seconds: 1));

      final bookings = [
        {
          'id': 'BK-001',
          'customer': 'Titelo Mokoena',
          'service': 'Laundry - Wash, Dry & Fold',
          'date': '24 Oct 2026',
          'amount': 120.00,
          'status': 'Pending',
          'address': '42 Langa Crescent, Emalahleni',
        },
        {
          'id': 'BK-002',
          'customer': 'Sipho Dlamini',
          'service': 'Couch Deep Clean',
          'date': '25 Oct 2026',
          'amount': 480.00,
          'status': 'In Progress',
          'address': '12 Main Street, Witbank',
        },
        {
          'id': 'BK-003',
          'customer': 'Nomsa Nkosi',
          'service': 'Mattress Deep Cleaning',
          'date': '26 Oct 2026',
          'amount': 350.00,
          'status': 'Completed',
          'address': '8 Church Street, Emalahleni',
        },
      ];

      final users = [
        {'name': 'Titelo Mokoena', 'role': 'Customer', 'email': 'titelo@example.com'},
        {'name': 'Sipho Dlamini', 'role': 'Customer', 'email': 'sipho@example.com'},
        {'name': 'John Doe', 'role': 'Employee', 'email': 'john@icebo.com'},
      ];

      emit(AdminLoaded(bookings: bookings, users: users));
    });

    on<UpdateBookingStatus>((event, emit) async {
      if (state is AdminLoaded) {
        final currentState = state as AdminLoaded;
        final updatedBookings = currentState.bookings.map((booking) {
          if (booking['id'] == event.bookingId) {
            return {...booking, 'status': event.newStatus};
          }
          return booking;
        }).toList();

        emit(AdminLoaded(bookings: updatedBookings, users: currentState.users));
      }
    });
  }
}
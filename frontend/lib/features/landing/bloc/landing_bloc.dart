import 'package:flutter_bloc/flutter_bloc.dart';
import 'landing_event.dart';
import 'landing_state.dart';

class LandingBloc extends Bloc<LandingEvent, LandingState> {
  LandingBloc() : super(LandingInitial()) {
    
    // Handle Navigation to Signup
    on<NavigateToSignup>((event, emit) {
      // The actual navigation is handled in the UI layer via GoRouter
      // We just emit a state if needed, but for now, we can leave it empty.
    });

    // Handle Navigation to Login
    on<NavigateToLogin>((event, emit) {
      // Handled in UI
    });

    // Handle Contact Actions
    on<ContactIcebo>((event, emit) async {
      emit(LandingLoading());
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate process
      
      if (event.type == 'whatsapp') {
        emit(const LandingActionSuccess('Opening WhatsApp...'));
      } else if (event.type == 'phone') {
        emit(const LandingActionSuccess('Opening Phone Dialer...'));
      } else if (event.type == 'email') {
        emit(const LandingActionSuccess('Opening Email App...'));
      }
    });
  }
}
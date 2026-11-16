import 'package:equatable/equatable.dart';

abstract class LandingEvent extends Equatable {
  const LandingEvent();
  @override
  List<Object> get props => [];
}

// Event to trigger navigation to the signup page
class NavigateToSignup extends LandingEvent {}

// Event to trigger navigation to the login page
class NavigateToLogin extends LandingEvent {}

// Event to trigger the contact action (e.g., open WhatsApp)
class ContactIcebo extends LandingEvent {
  final String type; // 'whatsapp', 'phone', 'email'
  const ContactIcebo({required this.type});
  @override
  List<Object> get props => [type];
}
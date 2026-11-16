import 'package:equatable/equatable.dart';

abstract class LandingState extends Equatable {
  const LandingState();
  @override
  List<Object> get props => [];
}

class LandingInitial extends LandingState {}
class LandingLoading extends LandingState {}
class LandingActionSuccess extends LandingState {
  final String message;
  const LandingActionSuccess(this.message);
  @override
  List<Object> get props => [message];
}
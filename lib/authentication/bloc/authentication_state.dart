part of 'authentication_bloc.dart';

abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class SuccessState extends AuthenticationState {}

class UserLogin extends AuthenticationState {}

class LogoutSuccess extends AuthenticationState {}

class sendPassResetSuccess extends AuthenticationState{}

class ErrorState extends AuthenticationState {
  final String message;

  ErrorState({required this.message});
}

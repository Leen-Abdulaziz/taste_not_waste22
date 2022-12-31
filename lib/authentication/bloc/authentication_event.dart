part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {}

class LoginWithEmailAndPasswordEvent extends AuthenticationEvent {
  final String email;
  final String password;

  LoginWithEmailAndPasswordEvent({
    required this.email,
    required this.password,
  });
}

class CreateAccountEvent extends AuthenticationEvent {
  final String email;
  final String password;

  CreateAccountEvent({
    required this.email,
    required this.password,
  });

}

 class CheckLogin extends AuthenticationEvent{ 
  final String email;
  final String password;
    CheckLogin({
        required this.email,
        required this.password,
      }); 
  }

 class LogoutEvent extends AuthenticationEvent{ 
  final String email;
  final String password;
    LogoutEvent({
        required this.email,
        required this.password,
      }); 
  }


 class ForgetPasswordEvent extends AuthenticationEvent{ 
  final String email;
  final String password;
    ForgetPasswordEvent({
        required this.email,
        required this.password,
      }); 
  }
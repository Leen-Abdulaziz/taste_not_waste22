import 'package:bloc/bloc.dart';
import 'package:auth_service/auth.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthService authService,
  })  : _authService = authService,
        super(AuthenticationInitial()) {
    on<LoginWithEmailAndPasswordEvent>(_mapLoginWithEmailAndPasswordEvent);
    on<CreateAccountEvent>(_mapCreateAccountEvent);
    on<CheckLogin>(_getUser);
    on<LogoutEvent>(_singOut);
    on<ForgetPasswordEvent>(_forgetPassword);
  }

  final AuthService _authService;

  Future<void> _mapLoginWithEmailAndPasswordEvent(
    LoginWithEmailAndPasswordEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      await _authService.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(SuccessState());
    } catch (e) {
      emit(
        ErrorState(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _mapCreateAccountEvent(
    CreateAccountEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      await _authService.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(SuccessState());
    } catch (e) {
      emit(
        ErrorState(
          message: e.toString(),
        ),
      );
    }
  }


  
  Future <void> _getUser( 
    CheckLogin event,
    Emitter<AuthenticationState> emit
    ) async {
    try {
      await _authService.getUser(  );
      emit(UserLogin());
    } catch (e) {
      emit(
        ErrorState(
          message: e.toString(),
        ),
      );
    }
  }
  
  Future <void> _forgetPassword(ForgetPasswordEvent event,
    Emitter<AuthenticationState> emit) async {
      try {
        await _authService.forgetPassword( 
          email: event.email,
          password: event.password,
        );
        emit(sendPassResetSuccess());
      } catch (e) {
        emit(
          ErrorState(
            message: e.toString(),
          ),
      );
    
      }
    }
  
  Future <void> _singOut( 
    LogoutEvent event,
    Emitter<AuthenticationState> emit
    ) async {
    try {
      await _authService.singOut( email: "", password: "" );
      emit(LogoutSuccess());
    } catch (e) {
      emit(
        ErrorState(
          message: e.toString(),
        ),
      );
    }
  }
}

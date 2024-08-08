import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chat_app_test/domain/auth/auth_repository.dart';
import 'package:injectable/injectable.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(const AuthState.initial());
  final AuthRepository authRepository;

  void signInWithGoogle() async {
    emit(const AuthState.loading());
    final result = await authRepository.signInWithGoogle();
    //error / success
    result.fold(
      (l) => emit(AuthState.error(l)),
      (r) => emit(AuthState.success(r)),
    );
  }

  void signInWithEmail(String email, String password) async {
    emit(const AuthState.loading());
    final result = await authRepository.signInWithEmailAndPassword(
        email: email, password: password);
    //error / success

    result.fold(
      (l) => emit(AuthState.error(l)),
      (r) => emit(AuthState.success(r)),
    );
  }

  void signUpWithEmail(String email, String password, String name) async {
    emit(const AuthState.loading());
    final result = await authRepository.signUpWithEmailAndPassword(
        email: email, password: password, name: name);
    //error / success

    result.fold(
      (l) => emit(AuthState.error(l)),
      (r) => emit(AuthState.success(r)),
    );
  }

  void checkAuthentication() async {
    emit(AuthState.loading());
    final result = await authRepository.authentication();
    result.fold(
      (l) => emit(AuthState.error(l)),
      (r) => (r == null)
          ? emit(AuthState.error("Not Authenticated"))
          : emit(AuthState.success(r)),
    );
  }
}

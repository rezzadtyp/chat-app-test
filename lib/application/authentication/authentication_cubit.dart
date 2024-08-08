import 'package:bloc/bloc.dart';
import 'package:chat_app_test/domain/auth/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'authentication_state.dart';
part 'authentication_cubit.freezed.dart';

@singleton
class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(this.authReposiotry)
      : super(AuthenticationState.initial());
  AuthRepository authReposiotry;

  void setCurrentUser(User user) {
    emit(state.copyWith(user: user));
  }
}

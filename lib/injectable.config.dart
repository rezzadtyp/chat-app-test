// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart'
    as _i451;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;

import 'application/auth/auth_cubit.dart' as _i457;
import 'application/authentication/authentication_cubit.dart' as _i792;
import 'application/friend/friend_cubit.dart' as _i160;
import 'application/message/message_cubit.dart' as _i182;
import 'application/room/room_cubit.dart' as _i298;
import 'domain/auth/auth_repository.dart' as _i788;
import 'domain/chat/chat_repository.dart' as _i564;
import 'domain/friend/friend_repository.dart' as _i354;
import 'domain/room/room_repository.dart' as _i446;
import 'infrastructure/auth/auth_datasource.dart' as _i798;
import 'infrastructure/chat/chat_datasource.dart' as _i406;
import 'infrastructure/core/fb_module.dart' as _i895;
import 'infrastructure/friend/friend_datasource.dart' as _i133;
import 'infrastructure/room/room_datasource.dart' as _i472;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final fBModule = _$FBModule();
    gh.singleton<_i59.FirebaseAuth>(() => fBModule.getFirebaseAuth);
    gh.singleton<_i116.GoogleSignIn>(() => fBModule.getGoogleSignIn);
    gh.singleton<_i451.FirebaseChatCore>(() => fBModule.getFirebaseChatCore);
    gh.singleton<_i446.RoomRepository>(
        () => _i472.RoomDatasource(gh<_i451.FirebaseChatCore>()));
    gh.singleton<_i788.AuthRepository>(() => _i798.AuthDatasource(
          gh<_i59.FirebaseAuth>(),
          gh<_i116.GoogleSignIn>(),
          gh<_i451.FirebaseChatCore>(),
        ));
    gh.factory<_i298.RoomCubit>(
        () => _i298.RoomCubit(gh<_i446.RoomRepository>()));
    gh.singleton<_i354.FriendRepository>(
        () => _i133.FriendDatasource(gh<_i451.FirebaseChatCore>()));
    gh.singleton<_i564.ChatRepository>(
        () => _i406.ChatDatasource(gh<_i451.FirebaseChatCore>()));
    gh.factory<_i457.AuthCubit>(
        () => _i457.AuthCubit(gh<_i788.AuthRepository>()));
    gh.factory<_i182.MessageCubit>(
        () => _i182.MessageCubit(gh<_i564.ChatRepository>()));
    gh.factory<_i160.FriendCubit>(
        () => _i160.FriendCubit(gh<_i354.FriendRepository>()));
    gh.singleton<_i792.AuthenticationCubit>(
        () => _i792.AuthenticationCubit(gh<_i788.AuthRepository>()));
    return this;
  }
}

class _$FBModule extends _i895.FBModule {}

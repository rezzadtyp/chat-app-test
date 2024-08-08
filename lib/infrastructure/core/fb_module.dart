import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

@module
abstract class FBModule {
  @singleton
  FirebaseAuth get getFirebaseAuth => FirebaseAuth.instance;

  @singleton
  GoogleSignIn get getGoogleSignIn => GoogleSignIn();
  @singleton
  FirebaseChatCore get getFirebaseChatCore => FirebaseChatCore.instance;
}

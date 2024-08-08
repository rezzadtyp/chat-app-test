import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<Either<String, User>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  });
  Future<Either<String, User>> signInWithGoogle();
  Future<Either<String, User?>> authentication();
  Future<Either<String, User>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Either<String, User?> getCurrentUser();
}
import 'package:dartz/dartz.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

abstract class FriendRepository {
  Stream<Either<String, List<types.User>>> watchFriends();
}

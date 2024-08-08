import 'package:dartz/dartz.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

abstract class RoomRepository {
  Stream<Either<String, List<types.Room>>> watchRooms();
  Future<Either<String, types.Room>> createSingleRoom(types.User otherUser);
}
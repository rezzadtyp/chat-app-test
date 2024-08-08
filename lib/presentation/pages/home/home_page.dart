import 'package:auto_route/auto_route.dart';
import 'package:chat_app_test/application/authentication/authentication_cubit.dart';
import 'package:chat_app_test/application/room/room_cubit.dart';
import 'package:chat_app_test/injectable.dart';
import 'package:chat_app_test/presentation/router/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getIt<AuthenticationCubit>().state.user?.displayName ?? ""),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().then(
                  (value) => context.router.replaceAll([const SplashRoute()]));
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => getIt<RoomCubit>()..watchAllRooms(),
        child: BlocBuilder<RoomCubit, RoomState>(
          builder: (context, state) {
            return state.maybeMap(
              orElse: () {
                return Container();
              },
              success: (value) {
                final rooms = value.rooms;
                if (rooms.isEmpty) {
                  return const Center(
                    child: Text("Tidak ada chat"),
                  );
                }
                return ListView.separated(
                  itemCount: rooms.length,
                  itemBuilder: (context, index) {
                    final singleRoom = rooms[index];
                    return ListTile(
                      onTap: () {
                        context.router.push(ChatRoute(room: singleRoom));
                      },
                      title: Text(singleRoom.name ?? ""),
                      leading: CircleAvatar(
                        backgroundColor: Colors.amber,
                        backgroundImage:
                            NetworkImage(singleRoom.imageUrl ?? ""),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushRoute(const FriendRoute());
        },
        child: const Icon(Icons.message),
      ),
    );
  }
}

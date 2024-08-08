import 'package:auto_route/auto_route.dart';
import 'package:chat_app_test/application/auth/auth_cubit.dart';
import 'package:chat_app_test/application/authentication/authentication_cubit.dart';
import 'package:chat_app_test/injectable.dart';
import 'package:chat_app_test/presentation/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>()..checkAuthentication(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          state.maybeMap(
            orElse: () {},
            loading: (e) {},
            error: (e) {
              Future.delayed(const Duration(seconds: 1)).then(
                  // ignore: use_build_context_synchronously
                  (value) => context.router.replaceAll([const WelcomeRoute()]));
            },
            success: (e) {
              getIt<AuthenticationCubit>().setCurrentUser(e.user);
              Future.delayed(const Duration(seconds: 1)).then(
                  // ignore: use_build_context_synchronously
                  (value) => context.router.replaceAll([const HomeRoute()]));
            },
          );
        },
        child: const Scaffold(
          body: Center(
            child: Text("Flutter Splash Page"),
          ),
        ),
      ),
    );
  }
}

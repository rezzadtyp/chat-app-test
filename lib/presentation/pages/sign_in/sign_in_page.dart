import 'package:auto_route/auto_route.dart';
import 'package:chat_app_test/application/auth/auth_cubit.dart';
import 'package:chat_app_test/application/authentication/authentication_cubit.dart';
import 'package:chat_app_test/injectable.dart';
import 'package:chat_app_test/presentation/router/app_router.dart';
import 'package:chat_app_test/presentation/theme/app_color.dart';
import 'package:chat_app_test/presentation/widgets/primary_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in_button/sign_in_button.dart';

@RoutePage()
class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  final authCubit = getIt<AuthCubit>();

  final emailCtr = TextEditingController(text: "rapk1107@gmail.com");
  final pwdCtr = TextEditingController(text: "pass123");
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          state.maybeMap(
            orElse: () {},
            loading: (e) {},
            error: (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(e.errMsg),
                  duration: const Duration(seconds: 5),
                ),
              );
            },
            success: (e) {
              getIt<AuthenticationCubit>().setCurrentUser(e.user);
              context.router.replaceAll([const HomeRoute()]);
            },
          );
        },
        child: Scaffold(
            appBar: AppBar(),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Please Login ! ",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text("Create an account so you can use this application")
                    ],
                  ),
                  const SizedBox(height: 30),
                  Column(
                    children: [
                      TextFormField(
                        controller: emailCtr,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Email",
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: pwdCtr,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Passpord",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Spacer(),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                        return PrimaryButton(
                          onTap: () {
                            context.read<AuthCubit>().signInWithEmail(
                                  emailCtr.text,
                                  pwdCtr.text,
                                );
                          },
                          isLoading: state.maybeMap(
                            orElse: () => false,
                            loading: (e) => true,
                          ),
                          label: "Sign In",
                        );
                      }),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                              child: Divider(
                            color: Colors.grey.shade400,
                            thickness: 1.5,
                          )),
                          const SizedBox(width: 20),
                          Text(
                            "Or Sign In with",
                            style: TextStyle(color: Colors.grey.shade500),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                              child: Divider(
                            color: Colors.grey.shade400,
                            thickness: 1.5,
                          )),
                        ],
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          return SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: SignInButton(
                              Buttons.google,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              text: "Sign in with Google",
                              onPressed: () async {
                                state.maybeMap(
                                  orElse: () {
                                    context
                                        .read<AuthCubit>()
                                        .signInWithGoogle();
                                  },
                                  loading: (e) {
                                    //do nothing
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: SignInButton(
                          Buttons.apple,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          text: "Sign in with Apple",
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(height: 20),
                      RichText(
                        text: TextSpan(
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              const TextSpan(text: "I don't have an account"),
                              const TextSpan(text: " "),
                              TextSpan(
                                text: "Sign Up",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.replaceRoute(const SignUpRoute());
                                  },
                                style: TextStyle(
                                  color: AppColor.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ]),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            )),
      ),
    );
  }
}

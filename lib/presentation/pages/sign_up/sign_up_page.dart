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
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailCtr = TextEditingController(text: "rapk1107@gmail.com");
  final nameCtr = TextEditingController(text: "Rezza");
  final pwdCtr = TextEditingController(text: "pass123");
  final pwdConCtr = TextEditingController(text: "pass123");
  final formKey = GlobalKey<FormState>();

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
                const SnackBar(
                  content: Text("Email already exist"),
                  duration: Duration(seconds: 5),
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
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: ListView(
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create an account!",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text("Create an account so you can use this application")
                  ],
                ),
                const SizedBox(height: 30),
                Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameCtr,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Name can not be empty";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Name",
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: emailCtr,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email can not be empty";
                          }
                          final email = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value);
                          if (email == false) {
                            return "Email is not valid";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Email",
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: pwdCtr,
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return "Password min 6 chars";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Password",
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return "Password min 6 chars";
                          }
                          if (value != pwdCtr.text) {
                            return "Password doesn't match";
                          }
                          return null;
                        },
                        controller: pwdConCtr,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Password Confirmation",
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return PrimaryButton(
                          onTap: () {
                            if (formKey.currentState?.validate() == true) {
                              context.read<AuthCubit>().signUpWithEmail(
                                    emailCtr.text,
                                    pwdConCtr.text,
                                    nameCtr.text,
                                  );
                            }
                          },
                          isLoading: state.maybeMap(
                            orElse: () => false,
                            loading: (e) => true,
                          ),
                          label: "Sign Up",
                        );
                      },
                    ),
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
                          "Or Sign Up with",
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
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: SignInButton(
                        Buttons.google,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        text: "Sign up with Google",
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
                            const TextSpan(text: "I already have an account"),
                            const TextSpan(text: " "),
                            TextSpan(
                              text: "Sign In",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // ignore: deprecated_member_use
                                  context.popRoute();
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
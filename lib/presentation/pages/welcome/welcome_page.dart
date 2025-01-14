import 'package:auto_route/auto_route.dart';
import 'package:chat_app_test/presentation/router/app_router.dart';
import 'package:chat_app_test/presentation/widgets/primary_button.dart';
import 'package:chat_app_test/presentation/widgets/secondary_button.dart';
import 'package:flutter/material.dart';

@RoutePage()
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome to\nchat-app-test!",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 30),
                    Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries")
                  ],
                ),
              ),
              Column(
                children: [
                  PrimaryButton(
                    label: "Sign In",
                    onTap: () {
                      context.pushRoute(SignInRoute());
                    },
                  ),
                  const SizedBox(height: 20),
                  SecondaryButton(
                    label: "Sign Up",
                    onTap: () {
                      context.pushRoute(const SignUpRoute());
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

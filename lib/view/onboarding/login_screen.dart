// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:millionaire_app/utils/colors.dart';

import '../../utils/routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: Image.asset('asset/logos/logo.png'),
                ),
                const SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      VerificationFields(),
                      SizedBox(
                        height: 20,
                      ),
                      LoginButton(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 160,
      child: TextButton(
        onPressed: () {
          Get.toNamed(AppRoutes.landingScreen);
        },
        child: Ink(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Center(
            child: Text(
              "Login",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class VerificationFields extends StatelessWidget {
  const VerificationFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey[100]!,
              ),
            ),
          ),
          child: TextFormField(
            cursorColor: Colors.black,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: "Email",
              hintStyle: TextStyle(color: Colors.grey[400]),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: const PasswordField(),
        )
      ],
    );
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField({super.key});

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _ishidden = true;

  void _toggleVisibility() {
    setState(
      () {
        _ishidden = !_ishidden;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _ishidden ? true : false,
      style: const TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(_ishidden ? Icons.visibility_off : Icons.visibility),
          onPressed: _toggleVisibility,
        ),
        border: const OutlineInputBorder(),
        hintText: "Password",
        hintStyle: TextStyle(
          color: Colors.grey[400],
        ),
      ),
    );
  }
}

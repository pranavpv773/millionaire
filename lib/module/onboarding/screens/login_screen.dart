import 'package:OWPM/app/app_images/app_images.dart';
import 'package:OWPM/app/extensions.dart';
import 'package:OWPM/module/onboarding/cubit/onboarding_cubit.dart';
import 'package:OWPM/utils/colors.dart';
import 'package:OWPM/utils/helpers.dart';
import 'package:OWPM/utils/routes/app_routes.dart';
import 'package:OWPM/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<OnboardingCubit>(context);
    return BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
      return Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: context.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _topBar,
                Column(
                  children: <Widget>[
                    TextFieldWidget(
                      controller: state.emailController,
                      labelText: 'EMAIL',
                      requiredText: 'Email is required',
                      textInputType: TextInputType.emailAddress,
                    ),
                    PasswordFieldWidget(
                      controller: state.passwordController,
                      labelText: 'PASSWORD',
                      requiredText: "Password is required",
                      textInputType: TextInputType.visiblePassword,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 70, 30, 0),
                      child: ButtonWidget(
                        color: AppColors.secondary,
                        shadow: AppColors.secondary.withOpacity(0.5),
                        text: 'SIGN IN',
                        onPressed: () {
                          cubit.onLoginFn(context: context);
                        },
                      ),
                    ),
                    _signUpButton
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: context.width,
                    height: 60,
                    color: AppColors.primary,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'asset/v2/bird.png',
                          width: 60,
                        ),
                        Text(
                          "ONE WORLD PEACE MAKER FOUNDATION",
                          style: context.textTheme.bodyMedium!
                              .copyWith(color: AppColors.white),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget get _topBar => Container(
      height: 300,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage(
                'asset/v2/ezgif.com-crop (6).gif',
              ),
              fit: BoxFit.cover),
          boxShadow: const [
            BoxShadow(
                color: AppColors.btnShadow,
                blurRadius: 10.0,
                spreadRadius: 1.0,
                offset: Offset(
                  3.0,
                  3.0,
                )),
          ],
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(100),
              bottomRight: Radius.circular(100)),
          color: AppColors.primary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
              AppImages.logoPath,
            ))),
            width: 50,
            height: 52,
          ),
          const SizeBoxH(h8),
          Text(
            "ONE WORLD PEACE",
            style:
                context.textTheme.bodyLarge!.copyWith(color: Colors.amber[600]),
          ),
          const SizeBoxH(h4),
          Text(
            "MILLIONAIRE",
            style:
                context.textTheme.bodyLarge!.copyWith(color: Colors.amber[800]),
          )
        ],
      ));

  Widget get _signUpButton => Center(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 2, 30, 10),
            child: RowTextWidget(
              onPressed: () {
                Get.toNamed(AppRoutes.signUpScreen);
              },
              dialog: "Don't have an account ?",
              btnText: "Sign up",
            )),
      );
}

class RowTextWidget extends StatelessWidget {
  final String dialog;
  final void Function()? onPressed;
  final String btnText;
  const RowTextWidget({
    super.key,
    required this.onPressed,
    required this.dialog,
    required this.btnText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(dialog),
          TextButton(
            style: ButtonStyle(
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0))),
            ),
            onPressed: onPressed,
            child: Text(
              btnText,
              style: context.textTheme.bodyMedium!
                  .copyWith(color: AppColors.logPrimary),
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final Color color;
  final String text;
  final Color shadow;
  final double? topPadding;
  final void Function()? onPressed;
  const ButtonWidget(
      {Key? key,
      required this.color,
      required this.text,
      required this.shadow,
      this.onPressed,
      this.topPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: shadow,
              blurRadius: 10.0, // has the effect of softening the shadow
              spreadRadius: 1.0, // has the effect of extending the shadow
              offset: const Offset(
                0.0, // horizontal, move right 10
                5.0, // vertical, move down 10
              ),
            ),
          ],
        ),
        child: ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(color)),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(fontSize: 20, color: AppColors.white),
          ),
        ),
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  final TextInputType textInputType;
  final String labelText;
  final String requiredText;
  final TextEditingController controller;

  const TextFieldWidget({
    Key? key,
    required this.textInputType,
    required this.labelText,
    required this.requiredText,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: TextFormField(
          controller: controller,
          keyboardType: textInputType,
          autocorrect: true,
          obscureText: false,
          style: context.textTheme.displayMedium,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              labelText: labelText,
              hintStyle: context.textTheme.displayMedium!
                  .copyWith(color: AppColors.MUZ_TEXT_COLOR),
              border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0))),
          validator: (value) {
            if (value.toString().trim().isEmpty) return requiredText;
            return null;
          }),
    );
  }
}

class PasswordFieldWidget extends StatefulWidget {
  final TextInputType textInputType;
  final String labelText;
  final String requiredText;
  final TextEditingController controller;
  const PasswordFieldWidget({
    Key? key,
    required this.textInputType,
    required this.labelText,
    required this.requiredText,
    required this.controller,
  }) : super(key: key);

  @override
  PasswordFieldWidgetState createState() => PasswordFieldWidgetState();
}

class PasswordFieldWidgetState extends State<PasswordFieldWidget> {
  bool hiddentText = true;

  void _toggleVisibility() {
    setState(() {
      hiddentText = !hiddentText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: TextFormField(
          controller: widget.controller,
          keyboardType: widget.textInputType,
          autocorrect: false,
          obscureText: hiddentText,
          style: context.textTheme.displayMedium,
          decoration: InputDecoration(
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: IconButton(
                  icon: hiddentText
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                  onPressed: _toggleVisibility,
                ),
              ),
              contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              labelText: widget.labelText,
              // labelStyle: context.textTheme.bodySmall!
              //     .copyWith(color: UIHelper.MUZ_TEXT_COLOR, fontSize: 12),
              hintStyle: context.textTheme.bodySmall!
                  .copyWith(color: AppColors.MUZ_TEXT_COLOR, fontSize: 12),
              border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0))),
          validator: (value) {
            if (value.toString().isEmpty) return widget.requiredText;
            return null;
          }),
    );
  }
}

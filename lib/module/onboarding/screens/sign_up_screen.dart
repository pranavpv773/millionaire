import 'dart:developer';

import 'package:OWPM/app/app_images/app_images.dart';
import 'package:OWPM/app/extensions.dart';
import 'package:OWPM/utils/colors.dart';
import 'package:OWPM/utils/helpers.dart';
import 'package:OWPM/utils/routes/app_routes.dart';
import 'package:OWPM/utils/size.dart';
import 'package:OWPM/utils/text_form_field.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';

import '../cubit/onboarding_cubit.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String countryName = 'Country Code';

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<OnboardingCubit>(context);
    return BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
            toolbarHeight: 90,
            backgroundColor: AppColors.primary,
            leadingWidth: 50,
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                  AppImages.logoPath,
                ))),
                width: 50,
                height: 52,
              ),
            ),
            title: RichText(
              overflow: TextOverflow.clip,
              textAlign: TextAlign.end,
              softWrap: true,
              maxLines: 1,
              textScaleFactor: 1,
              text: TextSpan(
                text: "ONE WORLD PEACE ",
                style: context.textTheme.bodyLarge!
                    .copyWith(color: Colors.amber[600], letterSpacing: 1),
                children: <TextSpan>[
                  TextSpan(
                    text: "MILLIONAIRE",
                    style: context.textTheme.bodyLarge!
                        .copyWith(color: Colors.amber[800], letterSpacing: 1),
                  ),
                ],
              ),
            )),

        //   header: 'SIGN UP',
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
            child: Form(
              key: state.formKey,
              child: Column(
                children: [
                  const SizeBoxH(20),
                  HeaderWithTextfield(
                    icon: Icons.person_outline_rounded,
                    headerText: "Username",
                    borderColor: AppColors.grey,
                    controller: state.userNameController,
                    hintText: "Username",
                    onChanged: (p0) {},
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Enter user name ';
                      }
                      return null;
                    },
                  ),
                  const SizeBoxH(h12),
                  HeaderWithTextfield(
                    icon: Icons.email_outlined,
                    headerText: "Email",
                    controller: state.signInEmailController,
                    borderColor: AppColors.grey,
                    onChanged: (value) {},
                    hintText: "Email",
                    validator: (value) {
                      if (value.toString().isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value.toString())) {
                        return 'Enter a valid email!';
                      }
                      return null;
                    },
                  ),
                  const SizeBoxH(h12),
                  HeaderWithTextfield(
                    readOnly: true,
                    icon: Icons.calendar_month_rounded,
                    headerText: "DOB",
                    controller: state.dobController,
                    borderColor: AppColors.grey,
                    onChanged: (value) {},
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));
                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        cubit.dobFormatToController(formattedDate);
                      } else {}
                    },
                    hintText: "DOB",
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Select date of birth!';
                      }
                      return null;
                    },
                  ),
                  const SizeBoxH(h12),
                  const GenderField(['Male', 'Female', 'Other']),
                  const SizeBoxH(h12),
                  HeaderWithTextfield(
                    readOnly: true,
                    icon: Icons.blur_circular,
                    headerText: "County",
                    controller: state.countryController,
                    borderColor: AppColors.grey,
                    onChanged: (value) {},
                    onTap: () async {
                      showCountryPicker(
                        useSafeArea: true,
                        context: context,
                        showPhoneCode:
                            true, // optional. Shows phone code before the country name.
                        onSelect: (Country country) {
                          log(country.countryCode.toString());
                          cubit.countryToController(country.name.toString());
                          cubit.countryToCountryCode(
                              country.countryCode.toString());
                        },
                      );
                    },
                    hintText: "Country",
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Select your country!';
                      }
                      return null;
                    },
                  ),
                  const SizeBoxH(h12),
                  HeaderWithTextfield(
                    icon: Icons.lock_outline_rounded,
                    headerText: "Password",
                    controller: state.signInpasswordController,
                    borderColor: AppColors.grey,
                    onChanged: (value) {},
                    hintText: "Password",
                    suffixIcon: const Icon(
                      Icons.remove_red_eye_rounded,
                      color: AppColors.logPrimary,
                    ),
                    validator: (value) {
                      RegExp regex = RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

                      if (value.toString().isEmpty) {
                        return 'Enter your password!';
                      } else if (!regex.hasMatch(value.toString())) {
                        return 'Enter a password greater than 5!';
                      }
                      return null;
                    },
                  ),
                  const SizeBoxH(h12),
                  HeaderWithTextfield(
                    icon: Icons.lock_outline_rounded,
                    headerText: "Confirm Password",
                    controller: state.signInConfirmpasswordController,
                    borderColor: AppColors.grey,
                    onChanged: (value) {},
                    hintText: "Confirm Password",
                    suffixIcon: const Icon(
                      Icons.remove_red_eye_rounded,
                      color: AppColors.logPrimary,
                    ),
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Enter your password!';
                      } else if (state.signInpasswordController.text !=
                          value.toString()) {
                        return 'password mismatch!';
                      }
                      return null;
                    },
                  ),
                  const SizeBoxH(h20),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(30, 2, 30, 10),
                      child: RowTextWidget(
                        onPressed: () {
                          Get.toNamed(AppRoutes.loginOrHome);
                        },
                        dialog: "Already have an account?",
                        btnText: "Login",
                      )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: ButtonWidget(
                      color: AppColors.secondary,
                      shadow: AppColors.secondary.withOpacity(0.5),
                      text: 'SIGN UP',
                      topPadding: 70,
                      onPressed: () {
                        context
                            .read<OnboardingCubit>()
                            .onboardSignUpUser(context);
                      },
                    ),
                  ),
                  const SizeBoxH(20)
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class HeaderWithTextfield extends StatelessWidget {
  const HeaderWithTextfield({
    super.key,
    required this.borderColor,
    required this.controller,
    required this.headerText,
    required this.hintText,
    required this.onChanged,
    required this.icon,
    this.onTap,
    this.readOnly,
    this.suffixIcon,
    this.validator,
  });
  final String hintText;
  final String headerText;
  final Color borderColor;
  final IconData icon;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final Function()? onTap;
  final bool? readOnly;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headerText,
          style: context.textTheme.displaySmall!
              .copyWith(color: AppColors.black, letterSpacing: 1),
        ),
        const SizeBoxH(4),
        CommonTextForm(
          obscureText: false,
          readOnly: readOnly ?? false,
          onTap: onTap,
          prefixIcon: Icon(
            icon,
            color: AppColors.primary,
          ),
          controller: controller,
          borderColor: borderColor,
          onChanged: onChanged,
          hintText: hintText,
          suffixIcon: suffixIcon ?? const SizedBox.shrink(),
          validator: validator,
        ),
      ],
    );
  }
}

class GenderField extends StatelessWidget {
  final List<String> genderList;

  const GenderField(this.genderList, {super.key});

  @override
  Widget build(BuildContext context) {
    Map<int, String> mappedGender = genderList.asMap();
    var cubit = BlocProvider.of<OnboardingCubit>(context);

    return BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
      return StatefulBuilder(
        builder: (_, StateSetter setState) => Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Gender : ',
              style: context.textTheme.bodyMedium!
                  .copyWith(fontWeight: FontWeight.w400),
            ),
            ...mappedGender.entries.map(
              (MapEntry<int, String> mapEntry) => Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio(
                      activeColor: Theme.of(context).primaryColor,
                      groupValue: state.gender,
                      value: genderList[mapEntry.key],
                      onChanged: (value) {
                        cubit.radioToGender(value.toString());
                      },
                    ),
                    Text(
                      mapEntry.value,
                      style: context.textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w400, letterSpacing: 0.9),
                    )
                  ]),
            ),
          ],
        ),
      );
    });
  }
}

part of 'onboarding_cubit.dart';

enum LoginStatus {
  initial,
  loading,
  loaded,
  error,
}

class OnboardingState extends Equatable {
  final Data onboardingData;
  final LoginStatus loginStatus;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController userNameController;
  final TextEditingController signInEmailController;
  final TextEditingController dobController;
  final TextEditingController countryController;
  final TextEditingController signInpasswordController;
  final TextEditingController signInConfirmpasswordController;
  final TextEditingController otp1Controller;
  final TextEditingController otp2Controller;
  final TextEditingController otp3Controller;
  final TextEditingController otp4Controller;
  final TextEditingController otp5Controller;
  final TextEditingController otp6Controller;
  final String gender;
  final String countryCode;
  final bool isValidEmail;
  final bool isValidPassword;
  final GlobalKey<FormState> formKey;

  const OnboardingState({
    required this.onboardingData,
    required this.loginStatus,
    required this.emailController,
    required this.passwordController,
    required this.isValidEmail,
    required this.isValidPassword,
    required this.userNameController,
    required this.signInEmailController,
    required this.dobController,
    required this.countryController,
    required this.signInpasswordController,
    required this.signInConfirmpasswordController,
    required this.otp1Controller,
    required this.otp2Controller,
    required this.otp3Controller,
    required this.otp4Controller,
    required this.otp5Controller,
    required this.otp6Controller,
    required this.countryCode,
    required this.gender,
    required this.formKey,
  });

  factory OnboardingState.initial() {
    return OnboardingState(
      onboardingData: Data(),
      loginStatus: LoginStatus.initial,
      emailController: TextEditingController(),
      passwordController: TextEditingController(),
      userNameController: TextEditingController(),
      signInEmailController: TextEditingController(),
      dobController: TextEditingController(),
      countryController: TextEditingController(),
      signInpasswordController: TextEditingController(),
      signInConfirmpasswordController: TextEditingController(),
      otp1Controller: TextEditingController(),
      otp2Controller: TextEditingController(),
      otp3Controller: TextEditingController(),
      otp4Controller: TextEditingController(),
      otp5Controller: TextEditingController(),
      otp6Controller: TextEditingController(),
      formKey: GlobalKey<FormState>(),
      countryCode: '',
      gender: '',
      isValidEmail: true,
      isValidPassword: true,
    );
  }

  OnboardingState copyWith(
      {Data? onboardingData,
      LoginStatus? loginStatus,
      TextEditingController? emailController,
      TextEditingController? passwordController,
      TextEditingController? userNameController,
      TextEditingController? signInEmailController,
      TextEditingController? dobController,
      TextEditingController? countryController,
      TextEditingController? signInpasswordController,
      TextEditingController? signInConfirmpasswordController,
      bool? isValidPassword,
      bool? isValidEmail,
      TextEditingController? otp1Controller,
      TextEditingController? otp2Controller,
      TextEditingController? otp3Controller,
      TextEditingController? otp4Controller,
      TextEditingController? otp5Controller,
      TextEditingController? otp6Controller,
      GlobalKey<FormState>? formKey,
      String? gender,
      String? countryCode}) {
    return OnboardingState(
      onboardingData: onboardingData ?? this.onboardingData,
      loginStatus: loginStatus ?? this.loginStatus,
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      userNameController: userNameController ?? this.userNameController,
      signInEmailController:
          signInEmailController ?? this.signInEmailController,
      dobController: dobController ?? this.dobController,
      countryController: countryController ?? this.countryController,
      signInpasswordController:
          signInpasswordController ?? this.signInpasswordController,
      signInConfirmpasswordController: signInConfirmpasswordController ??
          this.signInConfirmpasswordController,
      isValidEmail: isValidEmail ?? this.isValidEmail,
      isValidPassword: isValidPassword ?? this.isValidPassword,
      countryCode: countryCode ?? this.countryCode,
      gender: gender ?? this.gender,
      formKey: formKey ?? this.formKey,
      otp1Controller: otp1Controller ?? this.otp1Controller,
      otp2Controller: otp2Controller ?? this.otp2Controller,
      otp3Controller: otp3Controller ?? this.otp3Controller,
      otp4Controller: otp4Controller ?? this.otp4Controller,
      otp5Controller: otp5Controller ?? this.otp5Controller,
      otp6Controller: otp6Controller ?? this.otp6Controller,
    );
  }

  @override
  List<Object> get props {
    return [
      onboardingData,
      loginStatus,
      emailController,
      passwordController,
      userNameController,
      signInEmailController,
      dobController,
      countryController,
      signInpasswordController,
      signInConfirmpasswordController,
      isValidEmail,
      isValidPassword,
      otp1Controller,
      otp2Controller,
      otp3Controller,
      otp4Controller,
      otp5Controller,
      otp6Controller,
      gender,
      countryCode,
      formKey,
    ];
  }
}

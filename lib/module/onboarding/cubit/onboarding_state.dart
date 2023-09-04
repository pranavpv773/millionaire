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
  final bool isValidEmail;
  final bool isValidPassword;
  const OnboardingState({
    required this.onboardingData,
    required this.loginStatus,
    required this.emailController,
    required this.passwordController,
    required this.isValidEmail,
    required this.isValidPassword,
  });

  factory OnboardingState.initial() {
    return OnboardingState(
      onboardingData: Data(),
      loginStatus: LoginStatus.initial,
      emailController: TextEditingController(),
      passwordController: TextEditingController(),
      isValidEmail: true,
      isValidPassword: true,
    );
  }

  OnboardingState copyWith({
    Data? onboardingData,
    LoginStatus? loginStatus,
    TextEditingController? emailController,
    TextEditingController? passwordController,
    bool? isValidPassword,
    bool? isValidEmail,
  }) {
    return OnboardingState(
      onboardingData: onboardingData ?? this.onboardingData,
      loginStatus: loginStatus ?? this.loginStatus,
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      isValidEmail: isValidEmail ?? this.isValidEmail,
      isValidPassword: isValidPassword ?? this.isValidPassword,
    );
  }

  @override
  List<Object> get props {
    return [
      onboardingData,
      loginStatus,
      emailController,
      passwordController,
      isValidEmail,
      isValidPassword,
    ];
  }
}

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

  const OnboardingState({
    required this.onboardingData,
    required this.loginStatus,
    required this.emailController,
    required this.passwordController,
  });

  factory OnboardingState.initial() {
    return OnboardingState(
      onboardingData: Data(),
      loginStatus: LoginStatus.initial,
      emailController: TextEditingController(),
      passwordController: TextEditingController(),
    );
  }

  OnboardingState copyWith({
    Data? onboardingData,
    LoginStatus? loginStatus,
    TextEditingController? emailController,
    TextEditingController? passwordController,
  }) {
    return OnboardingState(
      onboardingData: onboardingData ?? this.onboardingData,
      loginStatus: loginStatus ?? this.loginStatus,
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
    );
  }

  @override
  List<Object> get props {
    return [
      onboardingData,
      loginStatus,
      emailController,
      passwordController,
    ];
  }
}

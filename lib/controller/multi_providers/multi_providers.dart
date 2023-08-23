import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millionaire_app/controller/cubit/draws/draws_cubit.dart';
import 'package:millionaire_app/controller/cubit/global_screen/global_screen_cubit.dart';
import 'package:millionaire_app/controller/cubit/home/home_cubit_cubit.dart';
import 'package:millionaire_app/controller/cubit/onboarding/cubit/onboarding_cubit.dart';

var providers = [
  BlocProvider<HomeCubit>(
    create: (context) => HomeCubit(),
  ),
  BlocProvider<OnboardingCubit>(
    create: (context) => OnboardingCubit(),
  ),
  BlocProvider<BottomNavCubit>(
    create: (context) => BottomNavCubit(),
  ),
  BlocProvider<DrawsCubit>(
    create: (context) => DrawsCubit(),
  ),
];

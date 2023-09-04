import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:OWPM/module/draws/cubit/draws_cubit.dart';
import 'package:OWPM/module/global_screen/cubit/global_screen_cubit.dart';
import 'package:OWPM/module/home/cubit/home_cubit_cubit.dart';
import 'package:OWPM/module/my_tickets/cubit/ticket_cubit.dart';
import 'package:OWPM/module/onboarding/cubit/onboarding_cubit.dart';

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
  BlocProvider<TicketCubit>(
    create: (context) => TicketCubit(),
  ),
];

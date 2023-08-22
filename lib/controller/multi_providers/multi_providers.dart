import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millionaire_app/controller/cubit/home_cubit_cubit.dart';

var providers = [
  BlocProvider<HomeCubit>(
    create: (context) => HomeCubit(),
  ),
];

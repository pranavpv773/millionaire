import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:millionaire_app/controller/cubit/home_cubit_cubit.dart';
import 'package:millionaire_app/utils/shimmers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<HomeCubit>().getallBanners();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
        return SingleChildScrollView(
          child: SizedBox(
            height: context.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                state.bannerStatus == BannerStatus.loading
                    ? const ShimmerListTile()
                    : state.bannerStatus == BannerStatus.error
                        ? Text(
                            "something went wrong",
                            style: context.textTheme.bodySmall,
                          )
                        : CarouselSlider(
                            options: CarouselOptions(height: 400.0),
                            items: [1, 2, 3, 4, 5].map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 5.0,
                                      ),
                                      decoration: const BoxDecoration(
                                        color: Colors.amber,
                                      ),
                                      child: Text(
                                        'text $i',
                                        style: const TextStyle(fontSize: 16.0),
                                      ));
                                },
                              );
                            }).toList(),
                          )
              ],
            ),
          ),
        );
      }),
    );
  }
}

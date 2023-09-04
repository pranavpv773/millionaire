import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:OWPM/backend/api_urls.dart';
import 'package:OWPM/module/home/cubit/controller/home_controller.dart';
import 'package:OWPM/module/home/cubit/home_cubit_cubit.dart';
import 'package:OWPM/utils/common_scaffold.dart';
import 'package:OWPM/utils/container.dart';
import 'package:OWPM/utils/helpers.dart';
import 'package:OWPM/utils/shimmers.dart';
import 'package:OWPM/utils/size.dart';

import 'widgets/buy_now_certificate.dart';
import 'widgets/count_timer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<HomeCubit>().getallBanners();
    context.read<HomeCubit>().getUrl();
    context.read<HomeCubit>().getUserModel();
    super.initState();
  }

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      child: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
        return GetBuilder<HomeController>(builder: (_) {
          return Column(
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 375),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children: [
                state.bannerStatus == BannerStatus.loading
                    ? const ShimmerBanner()
                    : state.bannerStatus == BannerStatus.error
                        ? Text(
                            "something went wrong",
                            style: context.textTheme.bodySmall,
                          )
                        : CarouselSlider(
                            options: CarouselOptions(
                              autoPlay: true,
                              aspectRatio: 16 / 9,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enableInfiniteScroll: true,
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              viewportFraction: 1,
                            ),
                            items: state.banners.map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    width: context.width,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          "$imageBaseurl/uploads/${i.image.toString()}",
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                const CommonShadowContainer(
                  child: CountTimerWidget(),
                ),
                const BuyNowGreenCertificate(),
                const SizeBoxH(h32)
              ],
            ),
          );
        });
      }),
    );
  }
}

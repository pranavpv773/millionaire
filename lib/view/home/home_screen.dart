import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/get_utils.dart';
// import 'package:get/get.dart';
import 'package:millionaire_app/controller/cubit/home/home_cubit_cubit.dart';
import 'package:millionaire_app/utils/colors.dart';
import 'package:millionaire_app/utils/common_scaffold.dart';
import 'package:millionaire_app/utils/helpers.dart';
import 'package:millionaire_app/utils/shimmers.dart';
import 'package:millionaire_app/utils/size.dart';

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
    return CommonScaffold(
      //   backgroundColor: AppColors.bgColor,
      child: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizeBoxH(32),
            state.bannerStatus == BannerStatus.loading
                ? const ShimmerListTile()
                : state.bannerStatus == BannerStatus.error
                    ? Text(
                        "something went wrong",
                        style: context.textTheme.bodySmall,
                      )
                    : CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
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
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Container(
                                  width: context.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          "http://3.6.123.80:3001/uploads/${i.image.toString()}",
                                        ),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
            const CommonShadowContainer(child: OwpmWidget()),
            CommonShadowContainer(
              child: Column(
                children: [
                  Container(
                    width: context.width,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.secondary),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Grand Prize",
                            style: context.textTheme.bodyMedium!.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(
                            height: h8,
                          ),
                          Text(
                            "AED 83,000,000",
                            style: context.textTheme.bodyLarge!.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ]),
                  ),
                  const SizeBoxH(h20),
                  Container(
                    height: 600,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: AssetImage(
                          "asset/logos/green certificate1.jpeg",
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizeBoxH(h20),
                  SizedBox(
                    width: context.width,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shadowColor: AppColors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        backgroundColor: AppColors.primary,
                        elevation: 12.0,
                      ),
                      child: Text(
                        'BUY NOW',
                        style: context.textTheme.titleMedium!.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizeBoxH(h32)
          ],
        );
      }),
    );
  }
}

class CommonShadowContainer extends StatelessWidget {
  final Widget child;
  const CommonShadowContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        elevation: 12,
        borderRadius: BorderRadius.circular(10),
        shadowColor: AppColors.black,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: child,
        ),
      ),
    );
  }
}

class OwpmWidget extends StatelessWidget {
  final bool home;
  const OwpmWidget({super.key, this.home = true});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: context.width,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.secondary),
            child: Center(
              child: Row(
                children: [
                  Text(
                    "Join The Draw Every Sunday At 8PM (UAE) ",
                    style: context.textTheme.bodyMedium!.copyWith(
                        color: AppColors.black, fontWeight: FontWeight.w500),
                  ),
                  Image.asset(
                    'asset/flag.jpeg',
                    width: 18,
                  )
                ],
              ),
            ),
          ),
          const SizeBoxH(h20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              TimeCountWidget(count: "02", text: 'DAYS'),
              // SizeBoxV(h8),
              TimeCountWidget(count: "04", text: 'HOURS'),
              // SizeBoxV(h8),
              TimeCountWidget(count: "35", text: 'MIN'),
              // SizeBoxV(h8),
              TimeCountWidget(count: "20", text: 'SEC'),
            ],
          ),
          const SizeBoxH(h20),
          Container(
            width: 198,
            decoration: BoxDecoration(
                image: const DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("asset/orange_button.jpeg")),
                color: AppColors.white,
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24),
              child: Row(
                children: [
                  Icon(
                    Icons.play_circle_fill_rounded,
                    color: AppColors.white,
                    size: 18,
                  ),
                  const SizeBoxV(8),
                  Text(
                    "Watch Videos",
                    style: context.textTheme.titleMedium!.copyWith(
                        color: AppColors.white, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TimeCountWidget extends StatelessWidget {
  final String count;
  final String text;
  const TimeCountWidget({super.key, required this.count, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: context.textTheme.bodySmall!
              .copyWith(fontWeight: FontWeight.w600, color: AppColors.black),
        ),
        const SizeBoxH(h8),
        CircleAvatar(
          radius: 40,
          backgroundImage: const AssetImage(
            'asset/rounded_ball.png',
          ),
          foregroundColor: AppColors.transparent,
          backgroundColor: AppColors.transparent,
          child: Text(
            count,
            style: context.textTheme.labelMedium!.copyWith(
                color: AppColors.white,
                fontSize: 26,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

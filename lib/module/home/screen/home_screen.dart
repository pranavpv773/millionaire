// ignore_for_file: use_build_context_synchronously

import 'package:OWPM/module/claim/cubit/claim_cubit.dart';
import 'package:OWPM/module/draws/cubit/draws_cubit.dart';
import 'package:OWPM/module/draws/screen/widgets/winnig_tile.dart';
import 'package:OWPM/utils/button.dart';
import 'package:OWPM/utils/colors.dart';
import 'package:OWPM/utils/container.dart';
import 'package:OWPM/utils/lauch_urls.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:OWPM/module/home/cubit/controller/home_controller.dart';
import 'package:OWPM/module/home/cubit/home_cubit_cubit.dart';
import 'package:OWPM/utils/common_scaffold.dart';
import 'package:OWPM/utils/shimmers.dart';

import '../../../utils/helpers.dart';
import '../../../utils/size.dart';
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
    context.read<ClaimCubit>().getcountryListFn();
    context.read<DrawsCubit>().getPastDraws();
    context.read<DrawsCubit>().getPrizeListFn();
    super.initState();
  }

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: 250,
      strokeWidth: 3,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: () async {
        await Future.delayed(
          const Duration(milliseconds: 1000),
        );
        context.read<HomeCubit>().getallBanners();
        context.read<HomeCubit>().getUrl();
        context.read<HomeCubit>().getUserModel();
        context.read<DrawsCubit>().getPastDraws();
        context.read<DrawsCubit>().getPrizeListFn();
      },
      child: CommonScaffold(
        child: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
          return BlocBuilder<DrawsCubit, DrawsState>(
              builder: (context, dState) {
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
                                              i.image.toString(),
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                    Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(15)),
                      child: const CountTimerWidget(),
                    ),
                    dState.pastDrawStatus == PastDrawStatus.loading ||
                            dState.prizeStatus == PrizeStatus.loading
                        ? const ShimmerListTile()
                        : dState.pastDrawStatus == PastDrawStatus.error ||
                                dState.prizeStatus == PrizeStatus.error
                            ? const SizedBox.shrink()
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Draw Results',
                                      style: context.textTheme.displayMedium!
                                          .copyWith(
                                        color: AppColors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                    dState.pastDrawStatus == PastDrawStatus.loading ||
                            dState.prizeStatus == PrizeStatus.loading
                        ? const ShimmerListTile()
                        : dState.pastDrawStatus == PastDrawStatus.error ||
                                dState.prizeStatus == PrizeStatus.error
                            ? const SizedBox.shrink()
                            : Container(
                                padding: const EdgeInsets.all(15),
                                child: Table(
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  border: TableBorder.all(
                                      width: 2,
                                      color: AppColors.primary
                                          .withOpacity(0.6)), //table border
                                  children: [
                                    const TableRow(children: [
                                      TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: TableHeaderText(
                                            text: "MATCH",
                                          )),
                                      TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: TableHeaderText(
                                              text: "NUMBER OF WINNERS",
                                            ),
                                          )),
                                      TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: TableHeaderText(
                                            text: "WINNINGS",
                                          )),
                                      // TableCell(child: Text("Nation"))
                                    ]),
                                    TableRow(children: [
                                      const TableCell(
                                          child: TableRowsText(
                                        text: "5",
                                      )),
                                      TableCell(
                                          child: TableRowsText(
                                        text: dState.pastDrawList[0].fiveMatch
                                            .toString(),
                                      )),
                                      TableCell(
                                          child: TableRowsText(
                                        text:
                                            "\$ ${(dState.priceList[0].price!.toInt() / dState.pastDrawList[0].fiveMatch!.toInt()).round().toString()}",
                                      )),
                                      // TableCell(child: Text("Nepal"))
                                    ]),
                                    TableRow(children: [
                                      const TableCell(
                                          child: TableRowsText(
                                        text: "4",
                                      )),
                                      TableCell(
                                          child: TableRowsText(
                                        text: dState.pastDrawList[0].fourMatch
                                            .toString(),
                                      )),
                                      TableCell(
                                          child: TableRowsText(
                                        text:
                                            "\$ ${(dState.priceList[1].price!.toInt() / dState.pastDrawList[0].fourMatch!.toInt()).round().toString()}",
                                      )),
                                      // TableCell(child: Text("USA"))
                                    ]),
                                    TableRow(children: [
                                      const TableCell(
                                          child: TableRowsText(
                                        text: "3",
                                      )),
                                      TableCell(
                                          child: TableRowsText(
                                        text: dState.pastDrawList[0].threeMatch
                                            .toString(),
                                      )),
                                      TableCell(
                                          child: TableRowsText(
                                        text:
                                            "\$ ${(dState.priceList[2].price!.toInt() / dState.pastDrawList[0].threeMatch!.toInt()).round().toString()}",
                                      )),
                                    ]),
                                  ],
                                )),
                    const SizeBoxH(10),
                    const BuyNowGreenCertificate(),
                    const SizeBoxH(h10),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: BlocBuilder<DrawsCubit, DrawsState>(
                        builder: (context, state) {
                          return BlocBuilder<HomeCubit, HomeState>(
                              builder: (context, homeState) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizeBoxH(h32),
                                Text(
                                  'Winnings',
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    color: AppColors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1,
                                  ),
                                ),
                                const SizeBoxH(h20),
                                AnimationLimiter(
                                  child: GridView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: 4,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 16.0,
                                              mainAxisExtent: 216,
                                              mainAxisSpacing: 16.0),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return AnimationConfiguration
                                            .staggeredGrid(
                                          position: index,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          columnCount: 4,
                                          child: ScaleAnimation(
                                            child: FadeInAnimation(
                                              child: WinningTileWidget(
                                                index: index,
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                                const SizeBoxH(10),
                                CommonShadowContainer(
                                  padding: 0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Watch live draw',
                                        style: context.textTheme.displayMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1),
                                      ),
                                      const SizeBoxH(h12),
                                      Text(
                                        'Watch our weekly draw every Sunday at 8.00 pm, UAE time.',
                                        style: context.textTheme.displaySmall!
                                            .copyWith(
                                                color: AppColors.grey,
                                                letterSpacing: 0.55),
                                      ),
                                      const SizeBoxH(h20),
                                      CommonButtonV1(
                                        label: 'Watch Now',
                                        onPressed: () =>
                                            launchURLs(homeState.liveUrl),
                                      )
                                    ],
                                  ),
                                ),
                                const SizeBoxH(h32),
                              ],
                            );
                          });
                        },
                      ),
                    ),
                  ],
                ),
              );
            });
          });
        }),
      ),
    );
  }
}

class TableRowsText extends StatelessWidget {
  final String text;
  const TableRowsText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: context.textTheme.bodySmall!.copyWith(
            color: AppColors.primary.withOpacity(0.6),
            fontSize: 18,
            fontWeight: FontWeight.w800),
      ),
    );
  }
}

class TableHeaderText extends StatelessWidget {
  final String text;
  const TableHeaderText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
          child: Text(
        text,
        textAlign: TextAlign.center,
        style: context.textTheme.bodyMedium!.copyWith(
            color: AppColors.primary,
            fontSize: 16,
            //  letterSpacing: 0.5,
            fontWeight: FontWeight.w900),
      )),
    );
  }
}

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:millionaire_app/controller/cubit/draws/draws_cubit.dart';
import 'package:millionaire_app/utils/colors.dart';
import 'package:millionaire_app/utils/common_scaffold.dart';
import 'package:millionaire_app/utils/helpers.dart';
import 'package:millionaire_app/utils/shimmers.dart';
import 'package:millionaire_app/utils/size.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class DrawsScreen extends StatefulWidget {
  const DrawsScreen({super.key});

  @override
  State<DrawsScreen> createState() => _DrawsScreenState();
}

class _DrawsScreenState extends State<DrawsScreen> {
  @override
  void initState() {
    context.read<DrawsCubit>().getPastDraws();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: 250,
      // backgroundColor: Colors.yellow,
      // color: Colors.red,
      strokeWidth: 3,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 1000));
        // ignore: use_build_context_synchronously
        context.read<DrawsCubit>().getPastDraws();
      },
      child: CommonScaffold(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: BlocBuilder<DrawsCubit, DrawsState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizeBoxH(h32),
                  Text(
                    'Winnings',
                    style: context.textTheme.titleMedium!.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  const SizeBoxH(h12),
                  AnimationLimiter(
                    child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 4,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16.0,
                                mainAxisSpacing: 16.0),
                        itemBuilder: (BuildContext context, int index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 375),
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
                  const SizeBoxH(h20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Past Draws',
                        style: context.textTheme.titleMedium!.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<DrawsCubit>().changePastDrawsLength();
                        },
                        child: Text(state.seePastDraw,
                            style: context.textTheme.titleMedium!
                                .copyWith(color: Colors.blue)),
                      ),
                    ],
                  ),
                  const SizeBoxH(h12),
                  state.pastDrawStatus == PastDrawStatus.loading
                      ? const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: ShimmerList(),
                        )
                      : state.pastDrawStatus == PastDrawStatus.error
                          ? const Text("Something Went wrong")
                          : AnimationLimiter(
                              child: ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.pastDrawLength,
                                separatorBuilder: (context, indexd) =>
                                    const SizeBoxH(16),
                                itemBuilder: (context, index) {
                                  DateTime dateTime = DateTime.parse(state
                                      .pastDrawList[index].date
                                      .toString());
                                  String formattedDatetime =
                                      DateFormat("dd MMM yyyy")
                                          .format(dateTime);

                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 375),
                                    child: SlideAnimation(
                                      verticalOffset: 50.0,
                                      child: FadeInAnimation(
                                        child: Material(
                                          elevation: 4,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    color: AppColors.grey
                                                        .withOpacity(0.02))),
                                            child: ListTile(
                                              //subtitle: Text("Winning no:"),
                                              leading: Icon(
                                                Icons.filter_1_rounded,
                                                size: 24,
                                                color: AppColors.primary
                                                    .withOpacity(0.7),
                                              ),
                                              minLeadingWidth:
                                                  context.width * 0.02,
                                              title: Text(
                                                "${state.pastDrawList[index].raffleId}",
                                                style: context
                                                    .textTheme.titleMedium!
                                                    .copyWith(
                                                        color: AppColors.grey,
                                                        fontSize: 16),
                                              ),
                                              trailing: Text(
                                                formattedDatetime,
                                                style: context
                                                    .textTheme.titleMedium!
                                                    .copyWith(
                                                        color: AppColors
                                                            .secondary
                                                            .withOpacity(0.7),
                                                        fontSize: 16),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                  const SizeBoxH(h32),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class WinningTileWidget extends StatelessWidget {
  final int index;
  WinningTileWidget({super.key, required this.index});
  List price = [
    'First prize',
    'Second prize',
    'Third prize',
    'Mega Raffle prize'
  ];
  List priceMoney = [
    r'10000$',
    r'5000$',
    r'1000$',
    r'10000$ per month',
  ];
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.secondary.withOpacity(0.5))),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                price[index],
                style: context.textTheme.bodyMedium!
                    .copyWith(color: Colors.grey, fontSize: 16),
              ),
              const SizeBoxH(h8),
              Text(
                priceMoney[index],
                style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              )
            ]),
      ),
    );
  }
}

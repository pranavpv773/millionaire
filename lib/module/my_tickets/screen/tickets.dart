import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:OWPM/module/my_tickets/cubit/ticket_cubit.dart';
import 'package:OWPM/utils/colors.dart';
import 'package:OWPM/utils/common_scaffold.dart';
import 'package:OWPM/utils/helpers.dart';
import 'package:OWPM/utils/shimmers.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:OWPM/utils/size.dart';

import 'widgets/ticket_empty_screen.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key});

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  @override
  void initState() {
    context.read<TicketCubit>().getMyTickets();
    super.initState();
  }

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
        // ignore: use_build_context_synchronously
        context.read<TicketCubit>().getMyTickets();
      },
      child: CommonScaffold(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizeBoxH(16),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'My Tickets',
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.black,
                  ),
                ),
              ),
              const SizeBoxH(h12),
              BlocBuilder<TicketCubit, TicketState>(builder: (context, state) {
                return state.myticketStatus == MyTicketStatus.loading
                    ? const ShimmerList()
                    : state.myTickets.isEmpty
                        ? const TicketEmptyScreen()
                        : AnimationLimiter(
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                DateTime dateTime = DateTime.parse(state
                                    .myTickets[index].createdAt
                                    .toString());
                                String formattedDatetime =
                                    DateFormat("dd MMM yyyy").format(dateTime);
                                DateTime drawDateTime = DateTime.parse(
                                    state.myTickets[index].date.toString());
                                String formattedDrawDatetime =
                                    DateFormat("dd MMM yyyy")
                                        .format(drawDateTime);

                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 375),
                                  child: SlideAnimation(
                                    verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: Material(
                                        elevation: 0,
                                        borderRadius: BorderRadius.circular(8),
                                        child: Container(
                                          height: 320,
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            image: const DecorationImage(
                                                image: AssetImage(
                                                    'asset/v2/green_card.jpeg'),
                                                fit: BoxFit.fitWidth),
                                            border: Border.all(
                                              color: AppColors.white
                                                  .withOpacity(0.2),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: AppColors.transparent,
                                          ),
                                          child: Stack(
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.spaceEvenly,
                                            // crossAxisAlignment:
                                            //     CrossAxisAlignment.start,
                                            children: [
                                              Positioned(
                                                top: 56,
                                                left: 10,
                                                right: 10,
                                                child: Center(
                                                  child: RichTextWidget(
                                                    text1: 'Draw date : ',
                                                    style1: context
                                                        .textTheme.titleMedium!
                                                        .copyWith(
                                                      letterSpacing: 0.9,
                                                      color: AppColors.white
                                                          .withOpacity(0.7),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14,
                                                    ),
                                                    text2:
                                                        formattedDrawDatetime,
                                                    style2: context
                                                        .textTheme.titleMedium!
                                                        .copyWith(
                                                      letterSpacing: 2,
                                                      color: AppColors.white
                                                          .withOpacity(0.7),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                left: 10,
                                                right: 10,
                                                child: Center(
                                                  child: RichTextWidget(
                                                    text1: 'Purchase date : ',
                                                    style1: context
                                                        .textTheme.titleMedium!
                                                        .copyWith(
                                                      letterSpacing: 0.9,
                                                      color: AppColors.white
                                                          .withOpacity(0.7),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                    ),
                                                    text2: formattedDatetime,
                                                    style2: context
                                                        .textTheme.titleMedium!
                                                        .copyWith(
                                                      letterSpacing: 2,
                                                      color: AppColors.white
                                                          .withOpacity(0.7),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 75,
                                                left: 5,
                                                right: 5,
                                                child: Center(
                                                  child: RichTextWidget(
                                                    text1: 'RAFFLE ID: ',
                                                    style1: context
                                                        .textTheme.titleMedium!
                                                        .copyWith(
                                                      fontFamily:
                                                          GoogleFonts.yatraOne()
                                                              .fontFamily,
                                                      letterSpacing: 0.16,
                                                      color: AppColors.yellowV2,
                                                      fontSize: 16,
                                                    ),
                                                    text2: state
                                                        .myTickets[index]
                                                        .raffleId
                                                        .toString(),
                                                    style2: context
                                                        .textTheme.titleMedium!
                                                        .copyWith(
                                                      letterSpacing: 2,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 30,
                                                left: 5,
                                                right: 5,
                                                child: Center(
                                                  child: SizedBox(
                                                    height: 44.0,
                                                    child: ListView(
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        children: List.generate(
                                                          state.myTickets[index]
                                                              .number!.length,
                                                          (index2) => Center(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          16.0),
                                                              child: Container(
                                                                height: 30,
                                                                width: 30,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30),
                                                                    border: Border.all(
                                                                        strokeAlign:
                                                                            0.6,
                                                                        width:
                                                                            2,
                                                                        color: AppColors
                                                                            .white)),
                                                                // backgroundColor:
                                                                //     AppColors
                                                                //         .transparent,
                                                                // radius: 35,
                                                                // backgroundImage:
                                                                //     const AssetImage(
                                                                //   'asset/v2/round.png',
                                                                // ),
                                                                child: Center(
                                                                  child: Text(
                                                                    "${state.myTickets[index].number![index2].toString()} ",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: context
                                                                        .textTheme
                                                                        .titleMedium!
                                                                        .copyWith(
                                                                      letterSpacing:
                                                                          0.16,
                                                                      color: AppColors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900,
                                                                      fontSize:
                                                                          16,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizeBoxH(8),
                              itemCount: state.myTickets.length,
                            ),
                          );
              }),
              const SizeBoxH(30)
            ],
          ),
        ),
      ),
    );
  }
}

class RichTextWidget extends StatelessWidget {
  const RichTextWidget({
    super.key,
    required this.text1,
    required this.text2,
    required this.style2,
    this.style1,
  });
  final String text1;
  final String text2;
  final TextStyle style2;
  final TextStyle? style1;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: text1,
          style: style1 ??
              context.textTheme.titleMedium!.copyWith(
                letterSpacing: 0.16,
                color: AppColors.black,
                fontSize: 16,
              ),
          children: <TextSpan>[
            TextSpan(
              text: text2,
              style: style2,
            )
          ]),
    );
  }
}

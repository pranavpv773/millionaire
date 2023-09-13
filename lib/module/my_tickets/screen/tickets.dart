import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:OWPM/module/my_tickets/cubit/ticket_cubit.dart';
import 'package:OWPM/utils/colors.dart';
import 'package:OWPM/utils/common_scaffold.dart';
import 'package:OWPM/utils/helpers.dart';
import 'package:OWPM/utils/shimmers.dart';
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Tickets',
                style: context.textTheme.bodyMedium!.copyWith(
                  color: AppColors.black,
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
                                        elevation: 4,
                                        borderRadius: BorderRadius.circular(8),
                                        child: Container(
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: AppColors.grey
                                                  .withOpacity(0.2),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: AppColors.white,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  RichTextWidget(
                                                    text1: 'Raffle id: ',
                                                    text2: state
                                                        .myTickets[index]
                                                        .raffleId
                                                        .toString(),
                                                    style2: context
                                                        .textTheme.titleMedium!
                                                        .copyWith(
                                                      color: AppColors.primary,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 44.0,
                                                    child: ListView(
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        children: List.generate(
                                                          state.myTickets[index]
                                                              .number!.length,
                                                          (index2) => Center(
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4),
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: AppColors
                                                                          .grey)),
                                                              child: Text(
                                                                // ignore: invalid_use_of_protected_member
                                                                "${state.myTickets[index].number![index2].toString()} ",
                                                                style: context
                                                                    .textTheme
                                                                    .titleMedium!
                                                                    .copyWith(
                                                                  letterSpacing:
                                                                      0.16,
                                                                  color:
                                                                      AppColors
                                                                          .black,
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )),
                                                  ),
                                                  RichTextWidget(
                                                    text1: 'Draw Date: ',
                                                    text2:
                                                        formattedDrawDatetime,
                                                    style2: context
                                                        .textTheme.titleMedium!
                                                        .copyWith(
                                                      color:
                                                          AppColors.secondary,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  RichTextWidget(
                                                    text1: 'Created Date: ',
                                                    text2: formattedDatetime,
                                                    style2: context
                                                        .textTheme.titleMedium!
                                                        .copyWith(
                                                      color: AppColors.primary,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: AppColors.primary
                                                      .withOpacity(0.7),
                                                ),
                                                child: Icon(
                                                  Icons
                                                      .local_attraction_rounded,
                                                  size: 24,
                                                  color: AppColors.white
                                                      .withOpacity(0.7),
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
                                  const SizeBoxH(16),
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
  });
  final String text1;
  final String text2;
  final TextStyle style2;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: text1,
          style: context.textTheme.titleMedium!.copyWith(
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

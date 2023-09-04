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
                                        height: 70,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                AppColors.grey.withOpacity(0.2),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: AppColors.white,
                                        ),
                                        child: Center(
                                          child: ListTile(
                                            minLeadingWidth:
                                                context.width * 0.02,
                                            leading: Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: AppColors.primary
                                                    .withOpacity(0.7),
                                              ),
                                              child: Icon(
                                                Icons.local_attraction_rounded,
                                                size: 24,
                                                color: AppColors.white
                                                    .withOpacity(0.7),
                                              ),
                                            ),
                                            title: Text(
                                              state.myTickets[index].raffleId
                                                  .toString(),
                                              style: context
                                                  .textTheme.titleMedium!
                                                  .copyWith(
                                                letterSpacing: 0.16,
                                                color: AppColors.black,
                                                fontSize: 16,
                                              ),
                                            ),
                                            trailing: Text(
                                              formattedDatetime,
                                              style: context
                                                  .textTheme.titleMedium!
                                                  .copyWith(
                                                color: AppColors.secondary,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )),
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

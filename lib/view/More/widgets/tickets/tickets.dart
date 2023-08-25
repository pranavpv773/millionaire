import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:millionaire_app/controller/cubit/my_tickets/ticket_cubit.dart';
import 'package:millionaire_app/utils/colors.dart';
import 'package:millionaire_app/utils/common_scaffold.dart';
import 'package:millionaire_app/utils/helpers.dart';
import 'package:millionaire_app/utils/shimmers.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:millionaire_app/utils/size.dart';

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
      // backgroundColor: Colors.yellow,
      // color: Colors.red,
      strokeWidth: 3,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 1000));
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
                    : AnimationLimiter(
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              DateTime dateTime = DateTime.parse(
                                  state.myTickets[index].date.toString());
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
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.grey
                                                  .withOpacity(0.2)),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: AppColors.white),
                                      child: ListTile(
                                        minLeadingWidth: context.width * 0.02,
                                        leading: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: AppColors.primary
                                                  .withOpacity(0.7)),
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
                                          style: context.textTheme.titleMedium!
                                              .copyWith(
                                                  letterSpacing: 0.16,
                                                  color: AppColors.black,
                                                  fontSize: 16),
                                        ),
                                        trailing: Text(
                                          formattedDatetime,
                                          style: context.textTheme.titleMedium!
                                              .copyWith(
                                                  color: AppColors.secondary,
                                                  fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  )),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizeBoxH(16),
                            itemCount: state.myTickets.length),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:millionaire_app/controller/cubit/my_tickets/ticket_cubit.dart';
import 'package:millionaire_app/utils/colors.dart';
import 'package:millionaire_app/utils/helpers.dart';
import 'package:millionaire_app/utils/shimmers.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tickets'),
        backgroundColor: AppColors.primary,
      ),
      body: BlocBuilder<TicketCubit, TicketState>(builder: (context, state) {
        return state.myticketStatus == MyTicketStatus.loading
            ? const Padding(
                padding: EdgeInsets.all(16.0),
                child: ShimmerList(),
              )
            : AnimationLimiter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
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
                                        color: AppColors.grey.withOpacity(0.2)),
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.white),
                                child: ListTile(
                                  minLeadingWidth: context.width * 0.02,
                                  leading: Icon(
                                    Icons.local_attraction_rounded,
                                    size: 24,
                                    color: AppColors.primary.withOpacity(0.7),
                                  ),
                                  title: Text(
                                    state.myTickets[index].raffleId.toString(),
                                    style: context.textTheme.titleMedium!
                                        .copyWith(
                                            color: AppColors.grey,
                                            fontSize: 16),
                                  ),
                                  trailing: Text(
                                    formattedDatetime,
                                    style: context.textTheme.titleMedium!
                                        .copyWith(
                                            color: AppColors.secondary
                                                .withOpacity(0.7),
                                            fontSize: 16),
                                  ),
                                ),
                              ),
                            )),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizeBoxH(16),
                      itemCount: state.myTickets.length),
                ),
              );
      }),
    );
  }
}

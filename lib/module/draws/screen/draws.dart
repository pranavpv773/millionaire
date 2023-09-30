// // ignore_for_file: must_be_immutable

// import 'package:OWPM/module/my_tickets/screen/tickets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:get/get_utils/get_utils.dart';
// import 'package:OWPM/module/draws/cubit/draws_cubit.dart';
// import 'package:OWPM/module/home/cubit/home_cubit_cubit.dart';
// import 'package:OWPM/utils/button.dart';
// import 'package:OWPM/utils/colors.dart';
// import 'package:OWPM/utils/common_scaffold.dart';
// import 'package:OWPM/utils/container.dart';
// import 'package:OWPM/utils/helpers.dart';
// import 'package:OWPM/utils/lauch_urls.dart';
// import 'package:OWPM/utils/shimmers.dart';
// import 'package:OWPM/utils/size.dart';
// // ignore: depend_on_referenced_packages
// import 'package:intl/intl.dart';

// import 'widgets/winnig_tile.dart';

// class DrawsScreen extends StatefulWidget {
//   const DrawsScreen({super.key});

//   @override
//   State<DrawsScreen> createState() => _DrawsScreenState();
// }

// class _DrawsScreenState extends State<DrawsScreen> {
//   @override
//   void initState() {
//     context.read<DrawsCubit>().getPastDraws();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//       displacement: 250,
//       strokeWidth: 3,
//       triggerMode: RefreshIndicatorTriggerMode.onEdge,
//       onRefresh: () async {
//         await Future.delayed(const Duration(milliseconds: 1000));
//         // ignore: use_build_context_synchronously
//         context.read<DrawsCubit>().getPastDraws();
//       },
//       child: CommonScaffold(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: BlocBuilder<DrawsCubit, DrawsState>(
//             builder: (context, state) {
//               return BlocBuilder<HomeCubit, HomeState>(
//                   builder: (context, homeState) {
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizeBoxH(h32),
//                     Text(
//                       'Winnings',
//                       style: context.textTheme.bodyMedium!.copyWith(
//                         color: AppColors.black,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w400,
//                         letterSpacing: 1,
//                       ),
//                     ),
//                     const SizeBoxH(h20),
//                     AnimationLimiter(
//                       child: GridView.builder(
//                           physics: const NeverScrollableScrollPhysics(),
//                           shrinkWrap: true,
//                           itemCount: 4,
//                           gridDelegate:
//                               const SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 2,
//                                   crossAxisSpacing: 16.0,
//                                   mainAxisExtent: 216,
//                                   mainAxisSpacing: 16.0),
//                           itemBuilder: (BuildContext context, int index) {
//                             return AnimationConfiguration.staggeredGrid(
//                               position: index,
//                               duration: const Duration(milliseconds: 500),
//                               columnCount: 4,
//                               child: ScaleAnimation(
//                                 child: FadeInAnimation(
//                                   child: WinningTileWidget(
//                                     index: index,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }),
//                     ),
//                     const SizeBoxH(10),
//                     const Divider(),
//                     const SizeBoxH(10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Past Draws',
//                           style: context.textTheme.bodyMedium!.copyWith(
//                             color: AppColors.black,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w400,
//                             letterSpacing: 1,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizeBoxH(h15),
//                     state.pastDrawStatus == PastDrawStatus.loading
//                         ? const Padding(
//                             padding: EdgeInsets.all(16.0),
//                             child: ShimmerList(),
//                           )
//                         : state.pastDrawStatus == PastDrawStatus.error
//                             ? const Text("Something Went wrong")
//                             : AnimationLimiter(
//                                 child: ListView.separated(
//                                   shrinkWrap: true,
//                                   physics: const NeverScrollableScrollPhysics(),
//                                   itemCount: state.pastDrawList.length,
//                                   separatorBuilder: (context, indexd) =>
//                                       const SizeBoxH(16),
//                                   itemBuilder: (context, index) {
//                                     DateTime dateTime = DateTime.parse(state
//                                         .pastDrawList[index].date
//                                         .toString());
//                                     String formattedDatetime =
//                                         DateFormat("dd MMM yyyy")
//                                             .format(dateTime);

//                                     return AnimationConfiguration.staggeredList(
//                                       position: index,
//                                       duration:
//                                           const Duration(milliseconds: 375),
//                                       child: SlideAnimation(
//                                         verticalOffset: 50.0,
//                                         child: FadeInAnimation(
//                                           child: Material(
//                                             elevation: 4,
//                                             borderRadius:
//                                                 BorderRadius.circular(8),
//                                             child: Container(
//                                               padding: const EdgeInsets.all(16),
//                                               decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(8),
//                                                   border: Border.all(
//                                                       color: AppColors.grey
//                                                           .withOpacity(0.02))),
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 children: [
//                                                   Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       RichTextWidget(
//                                                         text1: 'Raffle id: ',
//                                                         text2: state
//                                                             .pastDrawList[index]
//                                                             .raffleId
//                                                             .toString(),
//                                                         style2: context
//                                                             .textTheme
//                                                             .titleMedium!
//                                                             .copyWith(
//                                                           color:
//                                                               AppColors.primary,
//                                                           fontSize: 16,
//                                                         ),
//                                                       ),
//                                                       state
//                                                               .pastDrawList[
//                                                                   index]
//                                                               .winningNumber!
//                                                               .isEmpty
//                                                           ? const SizedBox
//                                                               .shrink()
//                                                           : SizedBox(
//                                                               height: 44.0,
//                                                               child: ListView(
//                                                                   shrinkWrap:
//                                                                       true,
//                                                                   scrollDirection:
//                                                                       Axis
//                                                                           .horizontal,
//                                                                   children: List
//                                                                       .generate(
//                                                                     state
//                                                                         .pastDrawList[
//                                                                             index]
//                                                                         .winningNumber!
//                                                                         .length,
//                                                                     (index2) =>
//                                                                         Center(
//                                                                       child:
//                                                                           Container(
//                                                                         padding:
//                                                                             const EdgeInsets.all(4),
//                                                                         decoration:
//                                                                             BoxDecoration(border: Border.all(color: AppColors.grey)),
//                                                                         child:
//                                                                             Text(
//                                                                           // ignore: invalid_use_of_protected_member
//                                                                           "${state.pastDrawList[index].winningNumber![index2].toString()} ",
//                                                                           style: context
//                                                                               .textTheme
//                                                                               .titleMedium!
//                                                                               .copyWith(
//                                                                             letterSpacing:
//                                                                                 0.16,
//                                                                             color:
//                                                                                 AppColors.black,
//                                                                             fontSize:
//                                                                                 16,
//                                                                           ),
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   )),
//                                                             ),
//                                                       RichTextWidget(
//                                                         text1: 'Drawe Date: ',
//                                                         text2:
//                                                             formattedDatetime,
//                                                         style2: context
//                                                             .textTheme
//                                                             .titleMedium!
//                                                             .copyWith(
//                                                           color: AppColors
//                                                               .secondary,
//                                                           fontSize: 16,
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   Container(
//                                                     width: 40,
//                                                     height: 40,
//                                                     decoration: BoxDecoration(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               8),
//                                                       color: AppColors.primary
//                                                           .withOpacity(0.7),
//                                                     ),
//                                                     child: Icon(
//                                                       Icons
//                                                           .local_attraction_rounded,
//                                                       size: 24,
//                                                       color: AppColors.white
//                                                           .withOpacity(0.7),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                     const SizeBoxH(10),
//                     const Divider(),
//                     const SizeBoxH(10),
//                     CommonShadowContainer(
//                       padding: 0,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Watch live draw',
//                             style: context.textTheme.displayMedium!.copyWith(
//                                 fontWeight: FontWeight.bold, letterSpacing: 1),
//                           ),
//                           const SizeBoxH(h12),
//                           Text(
//                             'Watch our weekly draw every Sunday at 8.00 pm, UAE time.',
//                             style: context.textTheme.displaySmall!.copyWith(
//                                 color: AppColors.grey, letterSpacing: 0.55),
//                           ),
//                           const SizeBoxH(h20),
//                           CommonButtonV1(
//                             label: 'Watch Now',
//                             onPressed: () => launchURLs(homeState.liveUrl),
//                           )
//                         ],
//                       ),
//                     ),
//                     const SizeBoxH(h32),
//                   ],
//                 );
//               });
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

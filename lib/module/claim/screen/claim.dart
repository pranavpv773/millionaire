import 'dart:developer';

import 'package:OWPM/module/claim/cubit/claim_cubit.dart';
import 'package:OWPM/utils/apppref.dart';
import 'package:OWPM/utils/button.dart';
import 'package:OWPM/utils/colors.dart';
import 'package:OWPM/utils/common_scaffold.dart';
import 'package:OWPM/utils/helpers.dart';
import 'package:OWPM/utils/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/get_utils.dart';

class ClaimScreen extends StatefulWidget {
  const ClaimScreen({super.key});

  @override
  State<ClaimScreen> createState() => _ClaimScreenState();
}

class _ClaimScreenState extends State<ClaimScreen> {
  @override
  void initState() {
    context.read<ClaimCubit>().clearState();
    super.initState();
  }

  final countryfocus = FocusNode();
  final bankfocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        child: Padding(
      padding: const EdgeInsets.all(16),
      child: BlocBuilder<ClaimCubit, ClaimState>(builder: (context, state) {
        return SizedBox(
          height: context.height,
          width: context.width,
          child: Column(
            children: [
              TextFormField(
                readOnly: false,
                controller: state.raffleIdCntrllr,
                onChanged: (String val) {},
                maxLines: null,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  labelText: 'Raffle ID',
                  fillColor: Colors.white70,
                  alignLabelWithHint: true,
                  isDense: true,
                ),
              ),
              const SizeBoxH(20),
              PrimaryCommonButton(
                  onPressed: () {
                    context.read<ClaimCubit>().getcliamFn(context);
                  },
                  label: 'CLAIM NOW'),
              state.claimTicketStatus == ClaimTicketStatus.initial
                  ? const SizedBox.shrink()
                  : state.claimTicketStatus == ClaimTicketStatus.loading ||
                          state.claimBankStatus == ClaimBankStatus.loading
                      ? SizedBox(
                          height: 400,
                          width: context.width,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : state.claimTicketStatus == ClaimTicketStatus.error
                          ? SizedBox(
                              height: 400,
                              width: context.width,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'asset/v2/ticket.png',
                                      width: 100,
                                    ),
                                    const SizeBoxH(20),
                                    Text(
                                      state.errorText,
                                      style: context.textTheme.displayMedium!
                                          .copyWith(color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Column(
                              children: [
                                const SizeBoxH(20),

                                const Text("FILL YOUR BANK DETAILS"),
                                const SizeBoxH(20),
                                // CommonTextForm(
                                //     prefixIcon: Image.asset(
                                //       'asset/v2/countries3.png',
                                //       width: 24,
                                //     ),
                                //     borderColor: AppColors.black,
                                //     onChanged: (v) {},
                                //     controller: TextEditingController(),
                                //     hintText: 'Country'),
                                const SizeBoxH(10),
                                CommonSearchField(
                                  controller: state.countryCntrllr,
                                  hintStyle:
                                      context.textTheme.bodySmall!.copyWith(
                                    fontSize: 16,
                                    color: AppColors.grey,
                                  ),
                                  readOnly: false,
                                  icon: Icons.keyboard_arrow_down_rounded,
                                  iconColor: AppColors.primary,
                                  searchStyle: context.textTheme.bodySmall!
                                      .copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                  onSearchTextChanged: (query) {
                                    final filter = state.countryList
                                        .where((element) => element
                                            .toString()
                                            .toLowerCase()
                                            .contains(query.toLowerCase()))
                                        .toList();
                                    return filter
                                        .map((e) => SearchFieldListItem<String>(
                                            e.toString(), e.toString(),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16.0,
                                                      horizontal: 12),
                                              child: Text(e.toString(),
                                                  style: context
                                                      .textTheme.bodySmall!
                                                      .copyWith(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                            )))
                                        .toList();
                                  },
                                  key: const Key("countryKey"),
                                  hint: 'Country',
                                  suggestionsDecoration: SuggestionDecoration(
                                      border: Border.all(color: AppColors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  suggestions: state.countryList
                                      .map(
                                        (e) => SearchFieldListItem<String>(
                                          e.toString(),
                                          e.toString(),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16.0, horizontal: 12),
                                            child: Text(
                                              e.toString(),
                                              style: context
                                                  .textTheme.bodySmall!
                                                  .copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  focusNode: countryfocus,
                                  onSuggestionTap: (p0) async {
                                    AppPref.countryName = p0.value;
                                    context
                                        .read<ClaimCubit>()
                                        .getcountryBankListFn();
                                    countryfocus.unfocus();
                                  },
                                ),
                                const SizeBoxH(10),
                                // CommonTextForm(
                                //     prefixIcon: Image.asset(
                                //       'asset/v2/bank.png',
                                //       width: 24,
                                //     ),
                                //     borderColor: AppColors.black,
                                //     onChanged: (v) {},
                                //     controller: TextEditingController(),
                                //     hintText: 'Bank'),
                                CommonSearchField(
                                  controller: state.bankCntrllr,
                                  hintStyle:
                                      context.textTheme.bodySmall!.copyWith(
                                    fontSize: 16,
                                    color: AppColors.grey,
                                  ),
                                  readOnly: false,
                                  icon: Icons.keyboard_arrow_down_rounded,
                                  iconColor: AppColors.primary,
                                  searchStyle: context.textTheme.bodySmall!
                                      .copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                  onSearchTextChanged: (query) {
                                    final filter = state.bankList
                                        .where((element) =>
                                            element['branch_name']
                                                .toString()
                                                .toLowerCase()
                                                .contains(query.toLowerCase()))
                                        .toList();
                                    return filter
                                        .map((e) => SearchFieldListItem<String>(
                                            e['branch_name'].toString(),
                                            e['branch_name'].toString(),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16.0,
                                                      horizontal: 12),
                                              child: Text(
                                                  e['branch_name'].toString(),
                                                  style: context
                                                      .textTheme.bodySmall!
                                                      .copyWith(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                            )))
                                        .toList();
                                  },
                                  key: const Key("bankKey"),
                                  hint: 'Bank name',
                                  suggestionsDecoration: SuggestionDecoration(
                                      border: Border.all(color: AppColors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  suggestions: state.bankList
                                      .map(
                                        (e) => SearchFieldListItem<String>(
                                          e['branch_name'].toString(),
                                          e['branch_name'].toString(),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16.0, horizontal: 12),
                                            child: Text(
                                              e['branch_name'].toString(),
                                              style: context
                                                  .textTheme.bodySmall!
                                                  .copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  focusNode: bankfocus,
                                  onSuggestionTap: (p0) async {
                                    AppPref.bankName = p0.value;
                                    log(AppPref.bankName);
                                    bankfocus.unfocus();
                                  },
                                ),
                                const SizeBoxH(10),
                                CommonTextForm(
                                    prefixIcon: Image.asset(
                                      'asset/v2/iban.png',
                                      width: 24,
                                    ),
                                    borderColor: AppColors.black,
                                    onChanged: (v) {},
                                    controller: TextEditingController(),
                                    hintText: 'IBAN'),
                                const SizeBoxH(20),
                                PrimaryCommonButton(
                                    onPressed: () {}, label: 'SUBMIT'),
                              ],
                            ),
            ],
          ),
        );
      }),
    ));
  }
}

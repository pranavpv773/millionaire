// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:OWPM/module/home/cubit/home_cubit_cubit.dart';
import 'package:OWPM/module/home/model/get_wallet_model.dart';
import 'package:OWPM/utils/apppref.dart';

import '../service/wallet_services.dart';

class WalletController extends GetxController implements GetxService {
  DateTime date = DateTime.now();
  bool isLoading = false;
  TextEditingController amountController = TextEditingController();
  TextEditingController numberOfCoinController = TextEditingController();
  var walletModal = GetWalletModel().obs;
  RxInt cost = 0.obs;
  RxBool isCostZero = true.obs;
  @override
  void onInit() {
    getWallet();
    super.onInit();
  }

//find before 3,6,9, month dates
  String getMonthsBeforeDate(int before) {
    // Subtract 3 months from the current date
    int year = date.year;
    int month = date.month - before;
    int day = date.day;

    // Handle negative or zero months
    while (month <= 0) {
      month += 12;
      year--;
    }
    log("3 month"
        "${year.toString()}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}");
    return "${year.toString()}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}";
  }

//get User data
  void getWallet() async {
    var response = await WalletServices().getWallet();
    if (response!.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      walletModal.value = data;
    } else {
      log(response.body);
    }
    update();
  }

//get coin cost
  void getCoinCost() async {
    var params = {"amount": numberOfCoinController.text.toString()};
    var response = await WalletServices().getCoinCost(params);
    if (response.statusCode == 201) {
      isCostZero.value = false;
      Map<String, dynamic> data = jsonDecode(response.body.toString());
      cost.value = data['data']['cost'];
    } else {
      log(response.body);
    }
    update();
  }

//stripe payment
  calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;
    return calculatedAmount.toString();
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount.toString()),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51NJUz3SHMOClJV0JUTBqqW9yYW9KSe1giJbhImSi2EpBGbcTcTa5U8AUgI3sGfn1KxiH7NC46rj44jhM77wMO3Qo008a8j26fT',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return jsonDecode(response.body);
    } catch (e) {
      log("erre change user $e");
    }
  }

  Map<String, dynamic>? paymentIntentData1 = {};
  Future<void> makePaymentFromCheckout(context, {required String date}) async {
    var params = {"amount": 20};
    try {
      var response = await WalletServices().rechargeWallet(params);
      if (response.statusCode == 201) {
        var data = jsonDecode(response.body.toString());
        AppPref.transactionId =
            data!["data"]['stripe_payment']['transactionId'].toString();
        AppPref.clientUrl =
            data!["data"]['stripe_payment']['clientSecret'].toString();
        try {
          paymentIntentData1 = await createPaymentIntent("1000", "INR");
          if (paymentIntentData1 != null) {
            await Stripe.instance.initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                customFlow: false,
                googlePay: const PaymentSheetGooglePay(
                  testEnv: true,
                  merchantCountryCode: "AED",
                ),
                merchantDisplayName: "prospect",
                customerId: paymentIntentData1!["customer"],
                paymentIntentClientSecret: data!["data"]['stripe_payment']
                    ['clientSecret'],
                customerEphemeralKeySecret: paymentIntentData1!["ephemeralkey"],
              ),
            );
          }
        } catch (e) {
          log("message $e");
        }
        //STEP 3: Display Payment sheet
        try {
          await Stripe.instance.presentPaymentSheet().then((value) {
            log("data$value");
            validatePayment(context, date: date);
          });
          log("success");
        } on Exception catch (e) {
          if (e is StripeException) {
            log("error from stripe $e");
          } else {
            log("Unforeseen erro $e");
          }
        } catch (e) {
          log("Exceptio   ---$e");
        }
        // displayPaymentSheet();
      }
    } catch (err) {
      log(err.toString());
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance
          .presentPaymentSheet(
        options: const PaymentSheetPresentOptions(),
      )
          .then((value) {
        // log("datas" + datas.toString());
        log("message");
        // successtoast(title: "Payment Successfully");
        // log("Payment Successfully");
      });
    } catch (e) {
      log('$e');
    }
  }

//validate payment
  void validatePayment(BuildContext context, {required String date}) async {
    String clintUrl = AppPref.clientUrl;
    String transactionId = AppPref.transactionId;
    String trimedId = clintUrl.substring(0, 27);
    var params = {'paymentIntentId': trimedId, 'transactionId': transactionId};
    var response = await WalletServices().validatePayment(params);
    if (response.statusCode >= 200 || response.statusCode <= 299) {
      context.read<HomeCubit>().purchaseTicketFns(
        data: {"number": [], "date": date, "password": ""},
        context: context,
      );
    } else {
      log(response.body);
    }
    update();
  }
}

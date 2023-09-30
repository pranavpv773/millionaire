import 'dart:async';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:get/get.dart';

class HomeController extends GetxController {
  late Timer _timer;
  RxInt days = 0.obs;
  RxInt hours = 0.obs;
  RxInt minutes = 0.obs;
  RxInt seconds = 0.obs;
  late tz.Location dubai;
  late tz.TZDateTime nextSunday8PM;
  Duration _remainingTime =
      const Duration(); // The remaining time in the countdown
  RxList numberList = [].obs;

  @override
  void onInit() {
    tz.initializeTimeZones();
    dubai = tz.getLocation('Asia/Dubai');
    calculateCountdown();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      calculateCountdown();
    });
    super.onInit();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

//Lottery draw countdown
  void calculateCountdown() {
    final now = tz.TZDateTime.now(
        tz.getLocation('Asia/Dubai')); // Get the current time in Dubai timezone
    var lastDayOfMonth = tz.TZDateTime(
        tz.getLocation('Asia/Dubai'),
        now.year,
        now.month + 1,
        1,
        20); // Set the target time to 8:00 PM on the last day of the month in Dubai timezone

    if (now.isAfter(lastDayOfMonth)) {
      // If today is after the target time, calculate the target for the next month
      lastDayOfMonth = lastDayOfMonth.add(const Duration(days: 30));
    }

    final difference = lastDayOfMonth.difference(now);
    _remainingTime = difference;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime.inSeconds > 0) {
        _remainingTime = _remainingTime - const Duration(seconds: 1);
      } else {
        _timer.cancel();
      }
      update();
    });

    days.value = _remainingTime.inDays;
    hours.value = _remainingTime.inHours % 24;
    minutes.value = _remainingTime.inMinutes % 60;
    seconds.value = _remainingTime.inSeconds % 60;

    update();
  }

  addOrRemoveFromList({required int item}) {
    if (numberList.contains(item)) {
      numberList.remove(item);
    } else {
      if (numberList.length == 5) {
        Get.snackbar(
          "Warning",
          "You can only be able to select five numbers",
          icon: const Icon(Icons.dangerous_outlined, color: Colors.white),
          snackPosition: SnackPosition.TOP,
        );
      } else {
        numberList.add(item);
      }
    }
  }

  clearNumberList() {
    numberList.clear();
    update();
  }
}

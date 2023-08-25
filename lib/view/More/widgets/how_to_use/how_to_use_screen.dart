import 'package:flutter/material.dart';
import 'package:millionaire_app/utils/colors.dart';

class HowToUseScreen extends StatefulWidget {
  const HowToUseScreen({super.key});

  @override
  State<HowToUseScreen> createState() => _HowToUseScreenState();
}

class _HowToUseScreenState extends State<HowToUseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("How to use"),
        backgroundColor: AppColors.primary,
      ),
      body: const CountdownWidget(),
    );
  }
}

class CountdownWidget extends StatefulWidget {
  const CountdownWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CountdownWidgetState createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [],
      ),
    );
  }
}

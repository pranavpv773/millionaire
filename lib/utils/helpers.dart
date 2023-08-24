import 'package:flutter/material.dart';

class SizeBoxV extends StatelessWidget {
  final double size;

  const SizeBoxV([this.size = 4]) : super(key: null);

  @override
  Widget build(BuildContext context) => Center(child: SizedBox(width: size));
}

class SizeBoxH extends StatelessWidget {
  final double size;

  const SizeBoxH([this.size = 4]) : super(key: null);

  @override
  Widget build(BuildContext context) => SizedBox(height: size);
}

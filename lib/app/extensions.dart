import 'package:flutter/material.dart';

extension $BuildContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  EdgeInsets get mediaQueryPadding => MediaQuery.of(this).padding;

  double get height => mediaQuery.size.height;

  double get width => mediaQuery.size.width;

  double get topPadding => mediaQuery.padding.top;

  double get bottomPadding => mediaQuery.padding.bottom;

  double get topInset => mediaQuery.viewInsets.top;

  double get bottomInset => mediaQuery.viewInsets.bottom;

  bool get iskeypad => mediaQuery.viewInsets.bottom != 0;

  get args => ModalRoute.of(this)?.settings.arguments as Map<dynamic, dynamic>;

  TextDirection get textDirection => Directionality.of(this);

  double get heightPadding =>
      height - ((mediaQuery.padding.top + mediaQuery.padding.bottom) / 100.0);
  double get widthPadding =>
      height - ((mediaQuery.padding.left + mediaQuery.padding.right) / 100.0);
  double heightPer(double per) => height * per / 100;
  double widthPer(double per) => width * per / 100;
  double heightPaddingPer(double per) => heightPadding * per / 100;
  double widthPaddingPer(double per) => widthPadding * per / 100;

  hideKeyboard() {
    final currentFocus = FocusScope.of(this);
    if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}

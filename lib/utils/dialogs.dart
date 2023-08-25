import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:millionaire_app/utils/colors.dart';
import 'package:millionaire_app/utils/size.dart';

import 'button.dart';
import 'helpers.dart';

void commonBottomSheetDialog(BuildContext context, double max, double initial,
    double min, Widget child) {
  showModalBottomSheet(
    context: context, backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),

    isScrollControlled: true, // set this to true
    builder: (_) {
      return DraggableScrollableSheet(
        maxChildSize: max,
        initialChildSize: initial,
        minChildSize: min,
        expand: false,
        builder: (_, controller) {
          return Container(
            //color: Colors.black,
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              controller: controller,
              child: child,
            ),
          );
        },
      );
    },
  );
}

errorBottomSheetDialogs({
  required BuildContext context,
  required String title,
  required String subtitle,
  String errorStatus = 'error',
  Widget? button,
  bool isDismissible = true,
  bool enableDrag = true,
}) {
  var brightness = MediaQuery.of(context).platformBrightness;
  bool isDarkMode = brightness == Brightness.dark;
  showModalBottomSheet(
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    context: context,
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadiusDirectional.only(
        topEnd: Radius.circular(25),
        topStart: Radius.circular(25),
      ),
    ),
    builder: (context) => CommonSheetWidget(
        subtitle: subtitle,
        title: title,
        button: button,
        errorstatus: errorStatus),
  );
}

class CommonSheetWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? button;
  final String errorstatus;
  const CommonSheetWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    this.button,
    this.errorstatus = 'error',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsetsDirectional.only(
        start: 0,
        end: 0,
        bottom: 5,
        top: 5,
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              //    if (!kIsWeb) CommonSheetHolder(),
              SizedBox(height: context.height * 0.03),
              errorstatus == 'error'
                  ? Image.asset(
                      'assets/images/error_image.png',
                      scale: 1,
                      color: const Color(0xffF34D3F),
                    )
                  : Image.asset(
                      'assets/images/error_image.png',
                      scale: 1,
                      color: const Color(0xffF34D3F),
                    ),
              const SizeBoxH(h12),
              SizedBox(
                height: context.height * 0.02,
              ),
              Text(
                title,
                maxLines: 3,
                textAlign: TextAlign.center,
                style: context.textTheme.displaySmall,
              ),
              subtitle == ''
                  ? Container()
                  : SizedBox(
                      height: context.height * 0.015,
                    ),
              subtitle == ''
                  ? Container()
                  : Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleMedium,
                    ),
              const SizeBoxH(h12),
              button == null
                  ? Column(
                      children: [
                        SizeBoxH(context.height * 0.02),
                        CommonButton(
                          hor: 15,
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            'Close',
                            style: context.textTheme.labelLarge,
                          ),
                        ),
                        SizeBoxH(context.height * 0.03),
                      ],
                    )
                  : button!,
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:millionaire_app/utils/colors.dart';

class CommonListTile extends StatelessWidget {
  final String? title;
  // final int? maxLineSubText;
  final VoidCallback? onPressed;

  final Color? bgColor;
  final Widget? child;
  final Widget? leading;
  final String? subtitle;
  final String? trailingtitle;
  final String? trailingsubtitle;
  final String? status;
  final Color statuscolor;
  final Color? leadingcolor;
  final String? statussubtext;
  final dynamic contentPadding;
  final Color? selectedTileColor;
  final Color? selectedColor;
  final dynamic textOverFlow;
  final bool? tileColorEnable;
  final Color? tileColorCustom;

  final Color? trailingColor;
  const CommonListTile({
    required this.onPressed,
    // this.maxLineSubText = 1,
    this.title,
    this.child,
    this.bgColor,
    Key? key,
    this.leading,
    this.subtitle,
    this.selectedColor,
    this.contentPadding,
    this.trailingtitle,
    this.trailingsubtitle,
    this.trailingColor,
    this.status,
    this.tileColorEnable = false,
    this.leadingcolor,
    this.tileColorCustom,
    required this.statuscolor,
    this.selectedTileColor,
    this.statussubtext,
    this.textOverFlow = TextOverflow.ellipsis,
  })  : assert(child == null || title == null, "cannot assign both at once."),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        children: [
          Material(
            color: AppColors.transparent,
            child: ListTile(
              selectedColor: selectedColor,
              selectedTileColor: selectedTileColor,
              contentPadding: contentPadding,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              tileColor: tileColorEnable == false
                  ? context.theme.primaryColor
                  : tileColorCustom,
              leading: leading,
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  trailingColor == Colors.green
                      ? Text(
                          trailingtitle ?? '',
                          style: context.textTheme.headlineMedium!
                              .copyWith(color: trailingColor),
                        )
                      : Text(
                          trailingtitle ?? '',
                          style: context.textTheme.headlineMedium,
                        ),
                  Text(
                    trailingsubtitle ?? '',
                    style: context.textTheme.titleMedium!.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        color: AppColors.black),
                  ),
                ],
              ),
              subtitle: status == null && statussubtext == null
                  ? null
                  : RichText(
                      // maxLines: maxLineSubText,
                      text: TextSpan(
                        children: [
                          status == null
                              ? const TextSpan()
                              : TextSpan(
                                  text: status ?? 'Verified',
                                  style: context.textTheme.titleMedium!
                                      .copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          color: AppColors.black),
                                ),
                          TextSpan(
                            text: statussubtext == '' ||
                                    status == null ||
                                    statussubtext == null
                                ? ''
                                : ' · ',
                            style: context.textTheme.titleSmall,
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                          statussubtext == null
                              ? const TextSpan()
                              : TextSpan(
                                  text: statussubtext ?? '27 Mar',
                                  style: context.textTheme.titleSmall,
                                ),
                        ],
                      ),
                    ),
              title: Text(
                title ?? '',
                maxLines: 1,
                overflow: textOverFlow,
                style: context.textTheme.displaySmall,
              ),
            ),
          ),
          ClipPath(
            clipper: ShapeBorderClipper(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            child: Container(
              height: 72,
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(
                          color: leadingcolor ?? AppColors.secondary,
                          width: 4))),
            ),
          ),
        ],
      ),
    );
  }
}

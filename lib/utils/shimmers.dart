import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:millionaire_app/utils/colors.dart';
import 'package:millionaire_app/utils/helpers.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerListTile extends StatelessWidget {
  const ShimmerListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDarkMode ? const Color(0XFF3b4043) : Colors.grey[300]!,
      highlightColor: isDarkMode ? const Color(0XFF161618) : Colors.grey[100]!,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 1,
        itemBuilder: (context, index) {
          return Container(
            height: 60,
            decoration: BoxDecoration(
                color: isDarkMode ? AppColors.bgDarkContainer : AppColors.white,
                borderRadius: BorderRadius.circular(5)),
            margin: const EdgeInsets.only(bottom: 5),
            padding: const EdgeInsets.all(11),
            child: Row(
              children: [
                // ClipRRect(
                //     borderRadius: BorderRadius.circular(10),
                //     child: ShimmerContainer(height: 40, width: 40)),
                // SizedBox(
                //   width: 16,
                // ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ShimmerText(
                            height: 16,
                            width: 50,
                          ),
                          // Spacer(),
                          // ShimmerText(
                          //   height: 12,
                          //   width: 70,
                          // ),
                        ],
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Align(
                      //     alignment: Alignment.topLeft,
                      //     child: ShimmerText(
                      //       height: 12,
                      //       width: 100,
                      //     ))
                    ],
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          height: 10,
        ),
      ),
    );
  }
}

class ShimmerList extends StatelessWidget {
  const ShimmerList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizeBoxH(16),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 9,
        itemBuilder: (context, index) {
          return Container(
            height: 50,
            decoration: BoxDecoration(
                color: AppColors.white, borderRadius: BorderRadius.circular(5)),
            // margin: const EdgeInsets.only(bottom: 5, left: 15, right: 15),
            // child: Column(
            //   children: [
            //     ShimmerText(
            //       height: 16,
            //       width: 50,
            //     ),
            //     const SizedBox(
            //       height: 10,
            //     ),
            //     ShimmerText(
            //       height: 16,
            //       width: 50,
            //     ),
            //   ],
            // ),
          );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class ShimmerText extends StatelessWidget {
  ShimmerText({super.key, required this.height, this.width});

  double? width;
  double height;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDarkMode ? const Color(0XFF3b4043) : Colors.grey[300]!,
      highlightColor: isDarkMode ? const Color(0XFF161618) : Colors.grey[100]!,
      child: Container(
          width: width ?? double.infinity,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: context.theme.primaryColor,
          )),
    );
  }
}

class ShimmerBanner extends StatefulWidget {
  const ShimmerBanner({super.key});

  @override
  State<ShimmerBanner> createState() => _ShimmerBannerState();
}

class _ShimmerBannerState extends State<ShimmerBanner> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.white,
      child: Container(
        height: context.height * 0.26,
        width: context.width,
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(5)),
        margin: const EdgeInsets.only(bottom: 5, left: 15, right: 15),
        padding: const EdgeInsets.all(11),
      ),
    );
  }
}

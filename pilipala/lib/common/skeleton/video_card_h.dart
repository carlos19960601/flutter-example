import 'package:flutter/material.dart';
import 'package:pilipala/common/constants.dart';
import 'package:pilipala/common/skeleton/skeleton.dart';

class VideoCardHSkeleton extends StatelessWidget {
  const VideoCardHSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
            StyleString.safeSpace, 7, StyleString.safeSpace, 7),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double width =
                (constraints.maxWidth - StyleString.cardSpace * 6) / 2;
            return SizedBox(
              height: width / StyleString.aspectRatio,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: StyleString.aspectRatio,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.onInverseSurface,
                            borderRadius:
                                BorderRadius.circular(StyleString.imgRadius.x),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 4, 6, 4),
                      child: Column(
                        children: [
                          Container(
                            color:
                                Theme.of(context).colorScheme.onInverseSurface,
                            width: 200,
                            height: 11,
                            margin: const EdgeInsets.only(bottom: 5),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

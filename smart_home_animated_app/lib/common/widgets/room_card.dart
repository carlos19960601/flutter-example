import 'package:flutter/material.dart';
import 'package:smart_home_animated_app/common/theme/sh_colors.dart';
import 'package:smart_home_animated_app/common/widgets/parallax_image_card.dart';
import 'package:smart_home_animated_app/common/widgets/shimmer_arrows.dart';
import 'package:smart_home_animated_app/models/smart_room.dart';

class RoomCard extends StatelessWidget {
  const RoomCard({
    super.key,
    required this.room,
    required this.onSwipeUp,
    required this.onSwipeDown,
    required this.onTap,
  });

  final SmartRoom room;
  final VoidCallback onSwipeUp;
  final VoidCallback onSwipeDown;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 200),
          child: GestureDetector(
            onTap: onTap,
            onVerticalDragUpdate: (details) {
              if (details.primaryDelta! < -10) onSwipeUp();
              if (details.primaryDelta! > 10) onSwipeDown();
            },
            child: Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.none,
              children: [
                ParallaxImageCard(
                  imageUrl: room.imageUrl,
                ),
                VerticalRoomTitle(room: room),
                const AnimatedUpwardArrows(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class AnimatedUpwardArrows extends StatelessWidget {
  const AnimatedUpwardArrows({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const ShimmerArrows(),
          const SizedBox(height: 24),
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            height: 4,
            width: 120,
            decoration: const BoxDecoration(
              color: SHColors.textColor,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }
}

class VerticalRoomTitle extends StatelessWidget {
  const VerticalRoomTitle({
    required this.room,
    super.key,
  });

  final SmartRoom room;

  @override
  Widget build(BuildContext context) {
    // final dx = 50 * animationValue;
    // final opacity = 1 - animationValue;
    return Align(
      alignment: Alignment.centerLeft,
      child: RotatedBox(
        quarterTurns: -1,
        child: FittedBox(
          child: Padding(
            padding: const EdgeInsets.only(left: 40, right: 20, top: 12),
            child: Text(
              room.name.replaceAll(' ', ''),
              maxLines: 1,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: SHColors.textColor),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hand_cricket/presentation/widgets/hand_gesture_animation.dart';

class HandAnimationContainer extends StatelessWidget {
  final int? userNumber;
  final int? botNumber;

  const HandAnimationContainer({
    super.key,
    required this.userNumber,
    required this.botNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 220,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0XFFAC853E)),
        borderRadius: BorderRadius.circular(20),
        color: Colors.black38,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Transform.flip(
              flipX: true,
              child: SizedBox(
                height: 130,
                child: HandGestureAnimation(
                  isUser: true,
                  number: userNumber,
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 130,
              child: HandGestureAnimation(
                isUser: true,
                number: botNumber,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

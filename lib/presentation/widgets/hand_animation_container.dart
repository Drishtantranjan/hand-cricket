import 'package:flutter/material.dart';
import 'package:hand_cricket/presentation/widgets/hand_gesture_animation.dart';

class HandAnimationContainer extends StatefulWidget {
  final int? userNumber;
  final int? botNumber;
  const HandAnimationContainer({this.userNumber, this.botNumber, super.key});

  @override
  State<HandAnimationContainer> createState() => _HandAnimationContainerState();
}

class _HandAnimationContainerState extends State<HandAnimationContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 220,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0XFFAC853E)),
        borderRadius: BorderRadius.circular(20),
        color: Colors.black38,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Transform.flip(
              flipX: true,
              child: Container(
                  height: 300,
                  child: HandGestureAnimation(
                    userNumber: widget.userNumber,
                    botNumber: null,
                  )),
            ),
          ),
          Expanded(
            child: Container(
              height: 300,
              child: HandGestureAnimation(
                userNumber: widget.userNumber,
                botNumber: 6,
                onAnimationComplete: () {
                  // Handle what happens after animation completes
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

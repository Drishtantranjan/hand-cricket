import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:shimmer_border_container/shimmer_border_container.dart';


class HandGestureAnimationContainer extends StatefulWidget {
  const HandGestureAnimationContainer({super.key});

  @override
  State<HandGestureAnimationContainer> createState() => _HandGestureAnimationContainerState();
}

class _HandGestureAnimationContainerState extends State<HandGestureAnimationContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: ShimmerBorderContainer(
        height: 150,
        width: double.infinity,
        backgroundColor: Colors.black,
        child: RiveAnimation.asset("assets/hand_cricket.riv"),
      ),
    );
  }
}

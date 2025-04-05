import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class HandGestureAnimationContainer extends StatefulWidget {
  const HandGestureAnimationContainer({super.key});

  @override
  State<HandGestureAnimationContainer> createState() => _HandGestureAnimationContainerState();
}

class _HandGestureAnimationContainerState extends State<HandGestureAnimationContainer> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: screenWidth * 0.12),
      child: Container(
        height: screenHeight * 0.2,
        width: double.infinity,

        decoration: BoxDecoration(

          border: Border.all(
            color: Color(0XFFAC853E)
          ),
          borderRadius: BorderRadius.circular(20),
          color: Colors.black38,
        ),
        child: RiveAnimation.asset("assets/hand_cricket.riv"),
      ),
    );
  }
}

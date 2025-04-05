import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopContainer extends StatefulWidget {
  final Function(int)? onNumberSelected;
  final List<int> runValues;
  final bool userBatting;

  const TopContainer({
    super.key,
    this.onNumberSelected,
    this.runValues = const [0, 0, 0, 0, 0, 0],
    this.userBatting = true,
  });

  @override
  State<TopContainer> createState() => _TopContainerState();
}

class _TopContainerState extends State<TopContainer> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: 80,
      width: screenWidth,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              "assets/Slice 1.svg",
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.015,
            left: widget.userBatting ? screenWidth * 0.15 : screenWidth * 0.62,
            child: _buildRunsScoredContainer(),
          ),
          Positioned(
            bottom: screenHeight * 0.015,
            left: widget.userBatting ? screenWidth * 0.62 : screenWidth * 0.15,
            child: _buildBallContainer(),
          ),
        ],
      ),
    );
  }

  Widget _buildRunsScoredContainer() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildRunContainer(25, 0),
            const SizedBox(width: 5),
            _buildRunContainer(25, 1),
            const SizedBox(width: 5),
            _buildRunContainer(25, 2),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildRunContainer(25, 3),
            const SizedBox(width: 5),
            _buildRunContainer(25, 4),
            const SizedBox(width: 5),
            _buildRunContainer(25, 5),
          ],
        ),
      ],
    );
  }

  Widget _buildRunContainer(double size, int index) {
    final runValue = widget.runValues[index];
    final isActive = runValue > 0;

    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: isActive ? Colors.green : Colors.black87,
      ),
      child: isActive
          ? Center(
              child: Text(
                runValue.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildBallContainer() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildBall(ballCount: 0),
            const SizedBox(width: 5),
            _buildBall(ballCount: 1),
            const SizedBox(width: 5),
            _buildBall(ballCount: 2),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildBall(ballCount: 3),
            const SizedBox(width: 5),
            _buildBall(ballCount: 4),
            const SizedBox(width: 5),
            _buildBall(ballCount: 5),
          ],
        ),
      ],
    );
  }

  Widget _buildBall({int ballCount = 0}) {
    final runValue = widget.runValues[ballCount];
    final isActive = runValue > 0;
    return SizedBox(
      height: 25,
      width: 25,
      child: Opacity(
        opacity: isActive ? 1.0 : 0.2,
        child: Image.asset("assets/ball.png"),
      ),
    );
  }
}

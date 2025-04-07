import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hand_cricket/presentation/assets_path.dart';

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
          Container(
            height: 400,
            color: Colors.black38,
          ),
          Positioned.fill(
            child: SvgPicture.asset(
              AssetsPath.topCard,
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
            _buildRunContainer(0),
            const SizedBox(width: 5),
            _buildRunContainer(1),
            const SizedBox(width: 5),
            _buildRunContainer(2),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildRunContainer(3),
            const SizedBox(width: 5),
            _buildRunContainer(4),
            const SizedBox(width: 5),
            _buildRunContainer(5),
          ],
        ),
      ],
    );
  }

  Widget _buildRunContainer(int index) {
    final runValue = index < widget.runValues.length ? widget.runValues[index] : 0;
    final isActive = runValue > 0;

    return Container(
      height: MediaQuery.of(context).size.height * 0.03,
      width: MediaQuery.of(context).size.width * 0.065,
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
    final runValue = ballCount < widget.runValues.length ? widget.runValues[ballCount] : 0;
    final isActive = runValue > 0;

    return SizedBox(
      height: 25,
      width: 25,
      child: Opacity(
        opacity: isActive ? 1.0 : 0.2,
        child: Image.asset(AssetsPath.ball),
      ),
    );
  }
}

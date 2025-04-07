import 'package:flutter/material.dart';
import 'package:hand_cricket/constants/assets_path.dart';

class NumberPickerWidget extends StatelessWidget {
  final Function(int) onNumberSelected;

  const NumberPickerWidget({super.key, required this.onNumberSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            _AnimatedNumberButton(number: 1, assetPath: AssetsPath.oneNumber),
            _AnimatedNumberButton(number: 2, assetPath: AssetsPath.twoNumber),
            _AnimatedNumberButton(number: 3, assetPath: AssetsPath.threeNumber),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            _AnimatedNumberButton(number: 4, assetPath: AssetsPath.fourNumber),
            _AnimatedNumberButton(number: 5, assetPath: AssetsPath.fiveNumber),
            _AnimatedNumberButton(number: 6, assetPath: AssetsPath.sixNumber),
          ],
        ),
      ],
    );
  }
}

class _AnimatedNumberButton extends StatefulWidget {
  final int number;
  final String assetPath;

  const _AnimatedNumberButton({
    required this.number,
    required this.assetPath,
  });

  @override
  State<_AnimatedNumberButton> createState() => _AnimatedNumberButtonState();
}

class _AnimatedNumberButtonState extends State<_AnimatedNumberButton>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 0.85;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0;
    });
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0;
    });
  }

  void _onTap() {
    final parent = context.findAncestorWidgetOfExactType<NumberPickerWidget>();
    parent?.onNumberSelected(widget.number);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: _onTap,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        child: Image.asset(widget.assetPath, height: 60),
      ),
    );
  }
}

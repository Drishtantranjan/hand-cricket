import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class HandGestureAnimation extends StatefulWidget {
  final int? userNumber;
  final int? botNumber;
  final VoidCallback? onAnimationComplete;

  const HandGestureAnimation({
    Key? key,
    this.userNumber,
    this.botNumber,
    this.onAnimationComplete,
  }) : super(key: key);

  @override
  State<HandGestureAnimation> createState() => _HandGestureAnimationState();
}

class _HandGestureAnimationState extends State<HandGestureAnimation> {
  Artboard? _artboard;
  StateMachineController? _controller;

  // Number inputs for user and bot
  SMINumber? _userNumberInput;
  SMINumber? _botNumberInput;

  @override
  void initState() {
    super.initState();
    _loadRiveFile();
  }

  Future<void> _loadRiveFile() async {
    try {
      final data = await rootBundle.load('assets/hand_cricket.riv');
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      final controller = StateMachineController.fromArtboard(
        artboard,
        'State Machine 1',
      );

      if (controller != null) {
        artboard.addController(controller);
        _controller = controller;

        // Look for number inputs — make sure they match your Rive file names
        _userNumberInput =
        controller.findInput<double>('Input') as SMINumber?;
        _botNumberInput =
        controller.findInput<double>('BotInput') as SMINumber?;

        setState(() {
          _artboard = artboard;
        });

        _triggerAnimation();
      }
    } catch (e) {
      debugPrint('Error loading Rive file: $e');
    }
  }

  void _triggerAnimation() {
    if (_userNumberInput != null && widget.userNumber != null) {
      _userNumberInput!.value = widget.userNumber!.toDouble();
    }

    if (_botNumberInput != null && widget.botNumber != null) {
      _botNumberInput!.value = widget.botNumber!.toDouble();
    }
  }

  @override
  void didUpdateWidget(covariant HandGestureAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.userNumber != oldWidget.userNumber ||
        widget.botNumber != oldWidget.botNumber) {
      _triggerAnimation();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_artboard == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Rive(
      artboard: _artboard!,
      fit: BoxFit.contain,
    );
  }
}

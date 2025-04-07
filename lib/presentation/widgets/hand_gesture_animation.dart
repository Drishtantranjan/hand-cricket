import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hand_cricket/presentation/assets_path.dart';
import 'package:rive/rive.dart';

class HandGestureAnimation extends StatefulWidget {
  final bool isUser;
  final int? number;
  final VoidCallback? onAnimationComplete;

  const HandGestureAnimation({
    Key? key,
    required this.isUser,
    required this.number,
    this.onAnimationComplete,
  }) : super(key: key);

  @override
  State<HandGestureAnimation> createState() => _HandGestureAnimationState();
}

class _HandGestureAnimationState extends State<HandGestureAnimation> {
  Artboard? _artboard;
  StateMachineController? _controller;
  SMINumber? _numberInput;

  @override
  void initState() {
    super.initState();
    _loadRiveFile();
  }

  Future<void> _loadRiveFile() async {
    try {
      final data = await rootBundle.load(AssetsPath.handAnimation);
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      final controller = StateMachineController.fromArtboard(
        artboard,
        'State Machine 1',
      );

      if (controller != null) {
        artboard.addController(controller);
        _controller = controller;

        _numberInput = controller.findInput<double>(
          widget.isUser ? 'Input' : 'BotInput',
        ) as SMINumber?;

        if (_numberInput == null) {
          debugPrint("Error: ${widget.isUser ? 'Input' : 'BotInput'} not found");
        }

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
    if (_numberInput != null && widget.number != null) {
      _numberInput!.value = widget.number!.toDouble();
    }
  }

  @override
  void didUpdateWidget(covariant HandGestureAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.number != oldWidget.number) {
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

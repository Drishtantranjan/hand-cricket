import 'package:flutter/material.dart';

class ScoreBoardContainer extends StatelessWidget {
  final int runsToWin;

  const ScoreBoardContainer({super.key, required this.runsToWin});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: OutwardCurveBadgeClipper(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFD700), Color(0xFFB8860B)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          'To win: $runsToWin',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14,
            shadows: [
              Shadow(
                blurRadius: 1,
                color: Colors.white,
                offset: Offset(0.5, 0.5),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class OutwardCurveBadgeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const double curveControl = 20;
    const double bottomRadius = 12;

    final path = Path();
    path.moveTo(0, 0); // top-left
    path.lineTo(size.width, 0); // top-right

    // Right outward curve
    path.cubicTo(
      size.width + curveControl, // control point 1 x
      size.height * 0.3, // control point 1 y
      size.width + curveControl, // control point 2 x
      size.height * 0.7, // control point 2 y
      size.width, // end x
      size.height - bottomRadius, // end y
    );

    // Bottom-right corner curve
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - bottomRadius,
      size.height,
    );

    // Bottom edge
    path.lineTo(bottomRadius, size.height);

    // Bottom-left corner curve
    path.quadraticBezierTo(
      0,
      size.height,
      0,
      size.height - bottomRadius,
    );

    // Left outward curve
    path.cubicTo(
      -curveControl,
      size.height * 0.7,
      -curveControl,
      size.height * 0.3,
      0,
      0,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

import 'package:flutter/material.dart';
import 'package:hand_cricket/presentation/assets_path.dart';

class AppbarCard extends StatelessWidget {
  const AppbarCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: Colors.black38,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildLogoRow(),
            const SizedBox(height: 10),
            _buildHighestScore(),
            const SizedBox(height: 10),
            _buildWeeklyScore(),
          ],
        ),
      ),
    );
  }
}

Widget _buildWeeklyScore({int weeklyScore = 0}) {
  return Text(
    "Your weekly score  :  $weeklyScore",
    style: TextStyle(
        fontWeight: FontWeight.bold, color: Colors.white, fontSize: 10),
  );
}

Widget _buildHighestScore() {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Color(0XFFAC853E)),
      borderRadius: BorderRadius.circular(5),
      color: Colors.black38,
    ),
    child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
        child: Text(
          "Current highest score : 135741",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 10),
        )),
  );
}

Widget _buildLogoRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        AssetsPath.scapiaLogo,
        height: 30,
      ),
      SizedBox(
        width: 10,
      ),
      Container(
        height: 20,
        width: 3,
        color: Colors.white54,
      ),
      Image.asset(
        AssetsPath.rcbLogo,
        height: 30,
      )
    ],
  );
}

import 'package:flutter/widgets.dart';
import 'package:qds_foundation/foundation.dart';

class ButtonGradient extends StatelessWidget {
  final double height;
  final Color color;

  const ButtonGradient({
    super.key,
    this.height = 80,
    this.color = wippyWhite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withAlpha(0),
            color,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}

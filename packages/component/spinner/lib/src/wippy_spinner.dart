import 'package:flutter/material.dart';
import 'package:qds_foundation/foundation.dart';

class WippySpinner extends StatelessWidget {
  static const double _spinnerSize = 48;
  static const double _borderWidth = 6;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        SizedBox(
          width: _spinnerSize,
          height: _spinnerSize,
          child: RepaintBoundary(
            child: CircularProgressIndicator(
              strokeCap: StrokeCap.round,
              backgroundColor: wippyGray300,
              strokeWidth: _borderWidth,
              color: wippyGray900,
            ),
          ),
        )
      ],
    );
  }
}

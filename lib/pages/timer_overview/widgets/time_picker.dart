import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class DurationPicker extends StatefulWidget {
  @override
  DurationPickerState createState() => DurationPickerState();
}

class DurationPickerState extends State<DurationPicker> {
  int _currentIntValue = 10;
  int _currentHorizontalIntValue = 10;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Column(
          children: [
            NumberPicker(
              value: _currentIntValue,
              minValue: 0,
              maxValue: 100,
              step: 10,
              haptics: true,
              onChanged: (value) => setState(() => _currentIntValue = value),
            ),
          ],
        ),
      ],
    );
  }
}

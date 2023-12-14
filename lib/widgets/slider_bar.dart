import 'package:flutter/material.dart';

class PriceSlider extends StatefulWidget {
  @override
  _PriceSliderState createState() => _PriceSliderState();
}

class _PriceSliderState extends State<PriceSlider> {
  double _minValue = 0;
  double _maxValue = 100;
  RangeValues _values = RangeValues(0, 100);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RangeSlider(
          values: _values,
          min: _minValue,
          max: _maxValue,
          onChanged: (values) {
            setState(() {
              _values = values;
              print(_values);
            });
          },
          labels: RangeLabels(
            _values.start.round().toString(),
            _values.end.round().toString(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Min: ${_values.start.round()}'),
            Text('Max: ${_values.end.round()}'),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class PriceSlider extends StatefulWidget {
  final ValueChanged<RangeValues>?
      onValuesChanged; // Callback to notify parent of selected values

  PriceSlider({Key? key, this.onValuesChanged}) : super(key: key);

  @override
  _PriceSliderState createState() => _PriceSliderState();
}

class _PriceSliderState extends State<PriceSlider> {
  double _minValue = 10000;
  double _maxValue = 100000;
  RangeValues _values = RangeValues(10000, 100000);

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

              // Notify the parent widget of the selected values
              if (widget.onValuesChanged != null) {
                widget.onValuesChanged!(_values);
              }
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

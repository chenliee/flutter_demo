import 'package:flutter/material.dart';

class SliderA extends StatefulWidget {
  const SliderA({Key? key}) : super(key: key);

  @override
  State<SliderA> createState() => _SliderAState();
}

class _SliderAState extends State<SliderA> {
  double _sliderValue = 0;
  num select = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('1'),
      ),
      body: MediaQuery.removePadding(
        context: context,
        child: Column(
          children: [
            SliderTheme(
              data: const SliderThemeData(
                  trackHeight: 12,
                  activeTrackColor: Colors.blue,
                  inactiveTrackColor: Colors.grey,
                  valueIndicatorColor: Colors.blue,
                  tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 10.0),
                  showValueIndicator: ShowValueIndicator.onlyForDiscrete,
                  minThumbSeparation: 100,
                  rangeTrackShape: RoundedRectRangeSliderTrackShape(),
                  valueIndicatorShape: PaddleSliderValueIndicatorShape()),
              child: Slider(
                onChanged: (value) {
                  setState(() {
                    _sliderValue = value;
                  });
                },
                value: _sliderValue,
                activeColor: Colors.blue,
                inactiveColor: Colors.grey,
                min: 0,
                max: 10.0,
                divisions: 10,
                label: '評分：$_sliderValue',
              ),
            ),
            Radio<num>(
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
              value: 1,
              groupValue: select,
              onChanged: (value) => setState(() {
                if (select == value) {
                  select = 0;
                } else {
                  select = 1;
                }
              }),
            ),
            Icon(
              select == 1
                  ? Icons.radio_button_checked_outlined
                  : Icons.circle_outlined,
              size: 22,
              color: select == 1 ? Colors.blue : Colors.grey,
            ),
            Checkbox(
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
              value: select == 1,
              onChanged: (value) {
                if (value == true) {
                  select = 1;
                } else {
                  select = 0;
                }
                setState(() {
                  select = select;
                });
              },
              shape: const CircleBorder(),
            ),
          ],
        ),
      ),
    );
  }
}

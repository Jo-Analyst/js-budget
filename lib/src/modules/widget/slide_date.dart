import 'package:flutter/material.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/list_month.dart';

class SlideDate extends StatefulWidget {
  final Function(String date) onGetDate;
  final int? year;
  final int? month;
  const SlideDate({
    this.year,
    this.month,
    required this.onGetDate,
    super.key,
  });

  @override
  State<SlideDate> createState() => _SlideDateState();
}

class _SlideDateState extends State<SlideDate> {
  int _indexMonth = DateTime.now().month - 1;
  int _year = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              if (_indexMonth == 0) {
                _indexMonth = 11;
                _year--;
                return;
              }

              _indexMonth--;
            });

            widget.onGetDate('${date[_indexMonth]} de $_year');
          },
          icon: const Icon(
            Icons.arrow_circle_left_outlined,
            size: 30,
          ),
        ),
        Text.rich(
          TextSpan(children: [
            TextSpan(text: '${date[_indexMonth]} de '),
            TextSpan(
              text: '$_year',
              style: const TextStyle(fontFamily: 'Anta'),
            ),
          ], style: textStyleLargeDefault),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              if (_indexMonth == 11) {
                _indexMonth = 0;
                _year++;
                return;
              }
              _indexMonth++;
            });

            widget.onGetDate('${date[_indexMonth]} de $_year');
          },
          icon: const Icon(
            Icons.arrow_circle_right_outlined,
            size: 30,
          ),
        ),
      ],
    );
  }
}

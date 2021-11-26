import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utilities.dart';
import '../globals.dart' as global;

class CurrentDatePicker extends StatelessWidget {
  final Function() pressLeft;
  final Function() pressRight;

  const CurrentDatePicker(
      {Key? key, required this.pressLeft, required this.pressRight})
      : super(key: key);

  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: pressLeft,
            icon: const Icon(Icons.arrow_left, size: 40, color: kIconColor)),
        Center(
            child: Text(
              DateFormat.yMMMd('ru').format(global.filterDate),
              style: const TextStyle(fontSize: 24, color: kFieldText),
            )),
        IconButton(
            onPressed: pressRight,
            icon: const Icon(Icons.arrow_right, size: 40, color: kIconColor)),
      ],
    );
  }
}

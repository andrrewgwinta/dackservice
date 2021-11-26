import 'package:flutter/material.dart';

import '../utilities.dart';
import '../globals.dart' as global;

class RadioRowDate extends StatefulWidget {
  FilterDateType selectedValue = global.fltDateType;

  RadioRowDate({Key? key}) : super(key: key);

  @override
  State<RadioRowDate> createState() => _RadioRowDateState();
}

class _RadioRowDateState extends State<RadioRowDate> {

  void onRadioClick(FilterDateType? value) {
    setState(() {
      widget.selectedValue = value!;
      global.fltDateType = widget.selectedValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //color: Colors.yellow,
      height: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RadioListTile<FilterDateType>(
            title: const Text('текущий день'),
            value: FilterDateType.fdtOneDay,
            groupValue: widget.selectedValue,
            onChanged: onRadioClick,
          ),
          RadioListTile<FilterDateType>(
            title: const Text('все не выполненные'),
            value: FilterDateType.fdtAllNoDone,
            groupValue: widget.selectedValue,
            onChanged: onRadioClick,
          ),
        ],
      ),
    );
  }
}

class RadioRowMachine extends StatefulWidget {
  FilterMachineType selectedValue = global.fltMachineType;

  @override
  State<RadioRowMachine> createState() => _RadioRowMachineState();
}

class _RadioRowMachineState extends State<RadioRowMachine> {

  void onRadioClick(FilterMachineType? value) {
    setState(() {
      widget.selectedValue = value!;
      global.fltMachineType  = widget.selectedValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //color: Colors.yellow,
      height: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RadioListTile<FilterMachineType>(
            title: const Text('только этот станок'),
            value: FilterMachineType.fmtOnlyCurrent,
            groupValue: widget.selectedValue,
            onChanged: onRadioClick,
          ),
          RadioListTile<FilterMachineType>(
            title: const Text('все видимые'),
            value: FilterMachineType.fdtAllVisible,
            groupValue: widget.selectedValue,
            onChanged: onRadioClick,
          ),
        ],
      ),
    );
  }
}

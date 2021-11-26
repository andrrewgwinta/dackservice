import 'package:flutter/material.dart';

import '../utilities.dart';

class InputRow extends StatefulWidget {
  final String initValue;
  final int gap;
  final Function(String) onChanged;
  final String label;
  final Function() onClear;

  const InputRow(
      {required this.initValue,
      required this.label,
      required this.gap,
      required this.onChanged,
      required this.onClear });

  @override
  State<InputRow> createState() => _InputRowState();
}

class _InputRowState extends State<InputRow> {
  final TextEditingController _controller = TextEditingController();

  //String text = '';

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initValue;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // void onChanged(String value) {
  //   text = value;
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Expanded(
          child: Container(
            decoration: API.kBoxDecoration(),
            height: 65,
            child: TextField(
              keyboardType: TextInputType.text,
              controller: _controller,
              onChanged: widget.onChanged,
              decoration: API.kInputDecoration(widget.label),
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
        ),
        SizedBox(
          width: widget.gap.toDouble(),
        ),
        IconButton(
            onPressed: () {
              _controller.text = '';
              widget.onClear();
            },
            icon: const Icon(Icons.cancel, size: 20, color: Colors.blue)),
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../globals.dart' as global;
import '../providers/machines.dart';
import '../providers/users.dart';
import '../utilities.dart';

class DialogSingleChoise extends StatelessWidget {
  String value;
  final void Function(String) pressOK;
  final ChoiseType choiseType;
  final bool twicePop;

  DialogSingleChoise(
      {Key? key,
      required this.choiseType,
      required this.value,
      required this.twicePop,
      required this.pressOK})
      : super(key: key);

  void doChoise(String val) {
    //print('in doChoise $val');
    value = val;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(choiseType == ChoiseType.ctMachine
          ? 'станки'
          : choiseType == ChoiseType.ctUser
              ? 'пользователи'
              : choiseType == ChoiseType.ctMachineByUser
                  ? 'станки для "${global.userName}"'
                  : ''),
      backgroundColor : kDialogBackGround,
      shape: kShapeBorder,
      elevation: kDialogElevation,
      children: [
        SizedBox(
          width: 300,
          height: 350,
          // MediaQuery.of(context).size.height -
          //     250,
          child: RadioList(
            items: (choiseType == ChoiseType.ctMachine)
                ? Provider.of<Machines>(context, listen: false).getMachinesDistinct()
                : (choiseType == ChoiseType.ctUser)
                    ? Provider.of<Users>(context, listen: false)
                        .getListUserByMachine(global.machineId)
                    : (choiseType == ChoiseType.ctMachineByUser)
                        ? Provider.of<Machines>(context, listen: false).getMachinesByUser(global.userId)
                        : [],
            init: value,
            onChange: doChoise,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 25,
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('отмена')),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                onPressed: () {
                  pressOK(value);
                  if (twicePop) {
                    Navigator.of(context).pop();
                  }
                  Navigator.of(context).pop();
                },
                child: const Text('запомнить'),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      ],
    );
  }
}

class RadioList extends StatefulWidget {
  final String? init;
  final Function(String) onChange;
  final List<NsiRecord> items;

  const RadioList(
      {Key? key, this.init, required this.items, required this.onChange})
      : super(key: key);

  @override
  State<RadioList> createState() => _RadioListState();
}

class _RadioListState extends State<RadioList> {
  String? _choiceResult;
  late List<NsiRecord> items;

  @override
  void initState() {
    super.initState();
    _choiceResult = widget.init;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        final item = widget.items[index];
        return Container(
          height: 35,
          padding: const EdgeInsets.only(left: 8.0, right: 35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.name,
                style: TextStyle(fontSize: 18),
              ),
              Radio<String>(
                value: item.id,
                groupValue: _choiceResult,
                onChanged: (String? value) {
                  setState(() {
                    _choiceResult = value ?? '';
                    widget.onChange(_choiceResult!);
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:provider/provider.dart';

import 'package:dackservice/providers/ordservice.dart';
import 'package:flutter/material.dart';

import '../utilities.dart';
import '../providers/staff.dart';

class DialogWorkerChecked extends StatelessWidget {
  final ServiceItem service;
  final Color contentColor;
  Function(String) pressOK;
  String codeString='';
  String stringOneId =  '';

  DialogWorkerChecked(
      {Key? key, required this.service, required this.contentColor, required this.pressOK})
      : super(key: key);

  void onChanging(bool val, String id) {

    stringOneId =  '$id^^';
    if (val) {
      if (!codeString.contains(stringOneId)) {
        codeString +=stringOneId;
      }
    }
    else {
      codeString = codeString.replaceAll(stringOneId, '');
    }
    print('in onChanging $codeString');
  }

  @override
  Widget build(BuildContext context) {
     final workers = Provider.of<Staff>(context, listen: false)
         .getWorkersList(service.machineId, service.workersIdString);
     codeString = (service.workersIdString=='')?'^^':service.workersIdString;

     //print('codeString $codeString');

    return SimpleDialog(
      title:
          Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            service.name,
            style: TextStyle(
                color: contentColor,
                overflow: TextOverflow.ellipsis,
                fontSize: 18),
          ),
          Text(
            service.orderName,
            style: TextStyle(
                color: contentColor,
                overflow: TextOverflow.ellipsis,
                fontSize: 16),
          ),
        ],
      ),
      backgroundColor: kDialogBackGround,
      shape: kShapeBorder,
      elevation: kDialogElevation,
      children: [
        SizedBox(
            width: 300,
            height: 350,
            child: CheckList(
              items: workers,
              onChanging: onChanging,
            )),
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
                   pressOK(codeString);
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

class CheckList extends StatefulWidget {
  final Function(bool, String) onChanging;
  final List<NsiRecord> items;

  const CheckList({Key? key, required this.items, required this.onChanging})
      : super(key: key);

  @override
  State<CheckList> createState() => _CheckListState();
}

class _CheckListState extends State<CheckList> {
  //String? _choiceResult;

  @override
  void initState() {
    super.initState();
    //_choiceResult = widget.init;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        final item = widget.items[index];

         return Container(
          height: 35,
          //padding: const EdgeInsets.only(left: 8.0, right: 35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 20,),
              Expanded(
                child: Text(
                  item.name,
                  style: const TextStyle(fontSize: 18),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Checkbox(
                value: widget.items[index].checked,
                onChanged: (bool? value) {
                  setState(() {
                    //value  = !value!;
                    widget.items[index].checked = value!;
                  });

                  widget.onChanging(value!, widget.items[index].id);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

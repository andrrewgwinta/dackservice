import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './globals.dart' as global;
import '../widgets/dialog_single_choice.dart';

const kDackGray = Color.fromRGBO(154, 152, 162, 1);
const kDackGreen1 = Color.fromRGBO(146, 192, 62, 1);
const kDackGreen2 = Color.fromRGBO(145, 192, 69, 1);
const kDackGreen3 = Color.fromRGBO(150, 190, 69, 1);
const kDackGreenLight = Color.fromRGBO(174, 208, 110, 1);

const kFieldBackGroud = Color(0xFFcfcfcf);
const kDialogBackGround = Color(0xFFddddff);
const kFieldBorder = Color(0xFF9999ff);
const kFieldText = Color(0xFF3333ff);
//const kFieldLabelText = Color(0xFF8080ff);
const kFieldLabelText = Color(0xFF0000ff);
const kIconColor = Color(0xFF0000b3);
const kShapeBorder = RoundedRectangleBorder(
    side: BorderSide(color:Colors.blueGrey, width: 1),
    borderRadius: BorderRadius.all(Radius.circular(15.0)));
const kDialogElevation = 24.0;

enum FilterDateType {
  fdtOneDayNoDone,
  fdtOneDayAll,
  fdtAllNoDone,
}

enum FilterMachineType {
  fmtOnlyCurrent,
  fdtAllVisible,
}

enum ChoiseType {
  ctMachine,
  ctUser,
  ctMachineByUser,
}

class API {
  API() : super();

  static Map<String, dynamic> get filterToJson => {
        'fltOrdNum': global.fltOrdNum,
        'fltOrdPerson': global.fltOrdPerson,
        'fltOrdNum1c': global.fltOrdNum1C,
        'fltDateType': global.fltDateType.index.toString(),
        'fltMachineType': global.fltMachineType.index.toString(),
        'filterDate': DateFormat.yMd('ru').format(global.filterDate),
        'machineId': global.machineId,
        'token': global.token,
      };

  static String get prefixURL {
    if ((global.serverName == null) || (global.serverName.trim() == '')) {
      return 'http://91.237.235.227:8012/dack/';
    } else {
      return 'http://${global.serverName}/dack/';
    }
  }

  static BoxDecoration kOrdArticleDecoration() {
    return BoxDecoration(
        border: Border.all(color: kFieldBorder, width: 1),
        color: kFieldBackGroud,
        borderRadius: BorderRadius.circular(10));
  }

  static BoxDecoration kBoxDecoration() {
    return BoxDecoration(
        border: Border.all(color: kFieldBorder, width: 1),
        color: kFieldBackGroud,
        borderRadius: BorderRadius.circular(10));
  }

  static InputDecoration kInputDecoration([String text = '']) {
    return InputDecoration(
      //prefixStyle: TextStyle(color: Colors.amberAccent),
      //labelText: text,
      hintText: text,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      contentPadding:
          const EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
    );
  }

  static choiseMachineDialog(BuildContext context, ChoiseType ct, bool twicePop,
      Function(String) clickOK) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogSingleChoise(
          choiseType: ct,
          twicePop: twicePop,
          value: global.machineId,
          pressOK: clickOK,
        );
      },
    );
  }

  static choiceUserDialog(BuildContext context, Function(String) clickOK) {
    if (global.machineId == '') {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('А станок?'),
          content: const Text('Сначала необходимо выбрать станок'),
          actions: [
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          elevation: kDialogElevation,
          shape: kShapeBorder,
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return DialogSingleChoise(
            choiseType: ChoiseType.ctUser,
            twicePop: false,
            value: global.userId,
            pressOK: clickOK,
          );
        },
      );
    }
  }
}

class Palette {
  static const MaterialColor kDackColor = MaterialColor(
    0xFF92c03e,
    // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xFF83ad38), //10%
      100: Color(0xFF759a32), //20%
      200: Color(0xFF92c03e), //30%
      300: Color(0xFF66862b), //40%
      400: Color(0xFF587325), //50%
      500: Color(0xFF49601f), //60%
      600: Color(0xFF3a4d19), //70%
      700: Color(0xFF2c3a13), //80%
      800: Color(0xFF0f1306), //90%
      900: Color(0xFF000000), //100%
    },
  );
}

const kTextStylePopUp = TextStyle(
  color: Colors.blue,
  fontSize: 18,
  overflow: TextOverflow.ellipsis,
);

class NsiRecord {
  final String id;
  final String name;
  late int npp;
  bool checked;

  NsiRecord({this.id = '', this.name = '', this.npp = 0, this.checked = false});

  @override
  String toString() {
    return 'id:$id  name:$name npp:${npp.toString()} checked:${checked.toString()}';
  }

  factory NsiRecord.fromJson(Map<String, dynamic> json) {
    return NsiRecord(
      id: json['id'].toString(),
      name: json['name'],
    );
  }
}

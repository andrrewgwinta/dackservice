import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import './globals.dart' as global;
import '../providers/machines.dart';
import '../providers/session.dart';
import '../providers/users.dart';
import '../widgets/dialog_single_choice.dart';

const kDackGray = Color.fromRGBO(154, 152, 162, 1);
const kDackGreen1 = Color.fromRGBO(146, 192, 62, 1);
const kDackGreen2 = Color.fromRGBO(145, 192, 69, 1);
const kDackGreen3 = Color.fromRGBO(150, 190, 69, 1);
const kDackGreenLight = Color.fromRGBO(174, 208, 110, 1);

const kFieldBackGroud = Color(0xFFcfcfcf);
const kFieldBorder = Color(0xFF9999ff);
const kFieldText = Color(0xFF3333ff);
const kFieldLabelText = Color(0xFF8080ff);
const kIconColor = Color(0xFF0000b3);




enum ChoiceType {
  ctMachine,
  ctUser,
}

class API {
  API() : super();

  static String get prefixURL {
    if ((global.serverName == null) || (global.serverName.trim() == '')) {
      return 'http://91.237.235.227:8012/dack/';
    } else {
      return 'http://${global.serverName}/dack/';
    }
  }

  static BoxDecoration kBoxDecoration() {
    return BoxDecoration(
        border: Border.all(color: kFieldBorder , width: 1),
        color: kFieldBackGroud,
        borderRadius: BorderRadius.circular(10));
  }

  static InputDecoration kInputDecoration() {
    return const InputDecoration(
      //prefixStyle: TextStyle(color: Colors.amberAccent),
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
    );
  }

  static choiseMachineDialog(BuildContext context, Function(String) clickOK) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogSingleChoise(
          choiseType: ChoiceType.ctMachine,
          value: global.machineId,
          pressOK: clickOK,
        );
      },
    );
  }

  static choiceUserDialog(BuildContext context, Function(String) clickOK) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogSingleChoise(
            choiseType: ChoiceType.ctUser,
            value: global.userId,
            pressOK: clickOK,
          );
      },
    );
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
  bool checked;

  NsiRecord({this.id = '', this.name = '', this.checked = false});

  @override
  String toString() {
    return 'id:$id  name:$name ';
  }

  factory NsiRecord.fromJson(Map<String, dynamic> json) {
    return NsiRecord(
      id: json['id'].toString(),
      name: json['name'],
    );
  }
}

List<String> orders= [
  "104КК1121  Интерьер Андрей",
  "106ПР1121  Хитрук ВИ",
  "103КК1121  Интерьер Андрей",
  "105ПР1121  Запорожец Валентина",
  "104ПР1121  Погожий",
  "102КК1121  Арели",
  "101КК1121  Айсберг",
  "28ТП1121  Ваш Аква (Жовтый)",
  "100КК1121  Александр",
  "103ПР1121  Денисенко Олег",
  "23МП1121  баландюк",
  "99КК1121  Худык",
  "102ПР1121  Шершенецький",
  "98КК1121  Дудукао",
  "22МП1121  ПОРФИЛЬЕВА",
  "101ПР1121  Фазлыев",
  "27ТП1121  мартенюк",
  "100ПР1121  Усатый",
  "16ТЕ1121  Калюжный",
  "46РС1121  Порфирьева",
  "14ГИ1121  Бабенко А",
  "97КК1121  Кустов",
  "01ПД1121  Вербовский",
  "45РС1121  Долинский",
  "44РС1121  Долинский",
  "99ПР1121  Бадалян",
  "43РС1121  Долинский",
  "98ПР1121  Долинский",
  "42РС1121  Студия 5",
  "13ГИ1121  Бабенко А",
  "41РС1121  Бабенко А",
  "97ПР1121  Падийя",
  "96ПР1121  Антарио",
  "96КК1121  Мир мебели",
  "26ТП1121  Никитина",
  "95КК1121  Колесник(оригинал)Валера",
  "94КК1121  Кукосьян",
  "93КК1121  Погорнила",
  "92КК1121  погонила",
  "25ТП1121  Балабанова Татьяна",
  "91КК1121  Холоднюк",
  "40РС1121  Пивторак",
  "21МП1121  ЮМАШЕВ",
  "24ТП1121  Верхоглядов",
  "12ГИ1121  Пивторак",
  "90КК1121  казаку",
  "89КК1121  Слюсаренко",
  "23ТП1121  Дехтяренко",
  "88КК1121  Фантаз",
  "39РС1121  ЧЕБОТАРЬ"
];
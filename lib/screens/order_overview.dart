import 'package:dackservice/providers/machines.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../globals.dart' as global;
import '../providers/session.dart';
import '../screens/logon_screen.dart';
import '../screens/setting_screen.dart';
import '../utilities.dart';
import '../widgets/filter_drawer.dart';

class OrderOverview extends StatefulWidget {
  static const routeName = '/orders';

  const OrderOverview({Key? key}) : super(key: key);

  @override
  State<OrderOverview> createState() => _OrderOverviewState();
}

class _OrderOverviewState extends State<OrderOverview> {
  @override
  Widget build(BuildContext context) {
    void changeMachine(String value) {
      global.machineId = value;
      global.machineName = Provider.of<Machines>(context, listen: false)
          .getNameById(global.machineId);
      Provider.of<Session>(context, listen: false).saveCurrentSession();
      setState(() {});
    }

    void incCurrentDay() {
      setState(() {
        print('before inc ${DateFormat.yMMMd('ru').format(global.filterDate)}');
        global.filterDate = global.filterDate.add(Duration(days: 1));
        print('after inc ${DateFormat.yMMMd('ru').format(global.filterDate)}');
      });
    }

    void decCurrentDay() {
      setState(() {
        global.filterDate = global.filterDate.subtract(Duration(days: 1));
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(global.machineName),
        //левое - вызов дравера-фильтра
        //****** правое меню
        actions: [
          // 1
          PopupMenuButton(
            //tooltip: '',
            child: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: TextButton(
                  onPressed: () {
                    API.choiseMachineDialog(context, changeMachine);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'сменить станок',
                        style: kTextStylePopUp,
                      ),
                      Icon(FontAwesomeIcons.sync)
                    ],
                  ),
                ),
              ),
              //
              PopupMenuItem(
                child: TextButton(
                  onPressed: () {
                    //Navigator.of(context).pushNamed(GenreScreen.routeName);
                    //диалог выбора станка
                  },
                  child: Row(
                    children: const [
                      Text(
                        'станки и персонал',
                        style: kTextStylePopUp,
                      ),
                      Icon(FontAwesomeIcons.userFriends)
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
              ),

              PopupMenuItem(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(SettingScreen.routeName);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'настройки',
                        style: kTextStylePopUp,
                      ),
                      Icon(FontAwesomeIcons.tools)
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                child: TextButton(
                  onPressed: () {
                    global.token = '';
                    Navigator.of(context)
                        .pushReplacementNamed(LogonScreen.routeName);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'выход ',
                        style: kTextStylePopUp,
                      ),
                      Icon(FontAwesomeIcons.signOutAlt)
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 15,
          )
        ],
        //**
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(FontAwesomeIcons.search),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
      ),
      drawer: FilterDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              //color:Colors.yellow,
              //padding: const EdgeInsets.only(bottom:25.0),
              //margin: EdgeInsets.only(bottom: 10),
              decoration: API.kBoxDecoration(),
              child: CurrentDatePicker(
                  pressLeft: decCurrentDay, pressRight: incCurrentDay),
            ),
            SizedBox(height: 6),
            Expanded(child: OrderList()),
          ],
        ),
      ),
    );
  }
}

class CurrentDatePicker extends StatelessWidget {
  final Function() pressLeft;
  final Function() pressRight;

  const CurrentDatePicker(
      {Key? key, required this.pressLeft, required this.pressRight})
      : super(key: key);

  Widget build(BuildContext context) {
    print('rebuild CurrentDatePicker');

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

class OrderList extends StatefulWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (ctx, index) => Text(orders[index]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../globals.dart' as global;
import '../providers/machines.dart';
import '../providers/ordservice.dart';
import '../providers/session.dart';
import '../screens/logon_screen.dart';
import '../screens/setting_screen.dart';
import '../utilities.dart';
import '../widgets/filter_drawer.dart';
import '../widgets/order_card_widget.dart';
import '../widgets/current_date_widget.dart';


class OrderOverview extends StatefulWidget {
  static const routeName = '/orders';

  const OrderOverview({Key? key}) : super(key: key);

  @override
  State<OrderOverview> createState() => _OrderOverviewState();
}

class _OrderOverviewState extends State<OrderOverview> {

  @override
  Widget build(BuildContext context) {
    print('rebuild main page');

    void changeMachine(String value) {
      print('in chamge Machine');
      //TODO
      setState(() {
        global.machineId = value;
        global.machineName = Provider.of<Machines>(context, listen: false)
            .getNameById(global.machineId);
        Provider.of<Session>(context, listen: false).saveCurrentSession();
        Provider.of<OrdServices>(context, listen: false).loadOrdServices();
      });
    }

    void incCurrentDay() {
      setState(() {
        global.filterDate = global.filterDate.add(Duration(days: 1));
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
            itemBuilder: (_) =>
            [
              PopupMenuItem(
                child: TextButton(
                  onPressed: () {
                     API.choiseMachineDialog(context, ChoiseType.ctMachineByUser, true,  changeMachine);
                     // Navigator.of(context).pop();
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
            const SizedBox(height: 6),
            Expanded(child: OrderList()),
          ],
        ),
      ),
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
    print('rebuild Order list');
    return FutureBuilder(
        future:
        Provider.of<OrdServices>(context, listen: false).loadOrdServices(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            //return(Text("kdkd"));
            return Consumer<OrdServices>(
              builder: (ctx, readData, child) =>
              readData.items.length == 0
                  ? const Center(
                  child: Text(
                    'таких записей нет',
                    style: TextStyle(fontSize: 30, color: kFieldText),
                  ))
                  : ListView.builder(
                itemCount: readData.items.length,
                itemBuilder: (ctx, index) =>
                    OrderCard(service: readData.items[index]),
              ),
            );
          }
        });
  }
}


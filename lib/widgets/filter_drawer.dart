import 'package:dackservice/providers/session.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../globals.dart' as global;
import '../screens/order_overview.dart';
import '../utilities.dart';

import '../widgets/radio_row.dart';
import '../widgets/input_filter_row.dart';

class FilterDrawer extends StatefulWidget {
  const FilterDrawer({Key? key}) : super(key: key);

  @override
  State<FilterDrawer> createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding:
        const EdgeInsets.only(left: 8.0, right: 8, bottom: 10, top: 40),
        child: Container(
          //color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InputRow(
                            initValue: global.fltOrdNum,
                            label: 'номер заказа',
                            gap: 70,
                            onChanged: (String value) {
                              global.fltOrdNum = value;
                            },
                            onClear: () {
                              global.fltOrdNum = '';
                            },

                          ),
                          const SizedBox(
                            height: 4,
                          ),

                          InputRow(
                            initValue: global.fltOrdPerson,
                            label: 'наименование',
                            gap: 20,
                            onChanged: (String value) {
                              global.fltOrdPerson = value;
                            },
                            onClear: () {
                              global.fltOrdPerson = '';
                            },),
                          const SizedBox(
                            height: 4,
                          ),

                          InputRow(
                            initValue: global.fltOrdNum1C,
                            label: 'номер заказа 1С',
                            gap: 50,
                            onChanged: (String value) {
                              global.fltOrdNum1C = value;
                            },
                            onClear: () {
                              global.fltOrdNum1C = '';
                            },),
                          const SizedBox(
                            height: 12,
                          ),


                          Container(
                              decoration: API.kBoxDecoration(),
                              width: double.infinity,
                              padding: EdgeInsets.all(8),
                              //padding: EdgeInsets.only(top: 8),
                              child: RadioRowDate()),
                          const SizedBox(
                            height: 4,
                          ),
                          Container(
                            decoration: API.kBoxDecoration(),
                            width: double.infinity,
                            padding: const EdgeInsets.all(8),
                            child: RadioRowMachine(),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          // Container(
                          //   decoration: API.kBoxDecoration(),
                          //   width: double.infinity,
                          //   padding: EdgeInsets.all(8),
                          //   child: InputRow(initValue : global.fltOrdNum),
                          // ),

                        ],
                      ),
                    )),
                SizedBox(
                  height: 50,
                  //color: Colors.green,
                  child: // //** кнопки
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 2.0),
                            child: ElevatedButton(
                                onPressed: () async {
                                  // await filterProvider.readFilterData().then(
                                  //         (value) =>
                                  //         Navigator.of(context).pushNamed('/'));
                                  Navigator.of(context)
                                      .pushNamed(OrderOverview.routeName);
                                },
                                child: const Icon(Icons.arrow_back)),
                          )),
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4.0),
                            child: ElevatedButton(
                                onPressed: () {
                                  Provider.of<Session>(context, listen: false)
                                      .setDefaultFilter();
                                  Navigator.of(context).pushNamed(
                                      OrderOverview.routeName);
                                },
                                child: const Text('сброс')),
                          )),
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4.0),
                            child: ElevatedButton(
                                onPressed: () {
                                  Provider.of<Session>(context, listen: false)
                                      .saveCurrentFilter();
                                  Navigator.of(context).pushNamed(
                                      OrderOverview.routeName);
                                },
                                child: const Text('готово')),
                          )),
                    ],
                  )
// //***закончились кнопки
                  ,
                ),
              ],
            )),
      ),
    );
  }
}



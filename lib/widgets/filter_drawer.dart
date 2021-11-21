import 'package:dackservice/screens/order_overview.dart';
import 'package:flutter/material.dart';

import '../screens/order_overview.dart';

class FilterDrawer extends StatefulWidget {
  const FilterDrawer({Key? key}) : super(key: key);

  @override
  State<FilterDrawer> createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding:
            const EdgeInsets.only(top: 40.0, left: 10, right: 10, bottom: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('день или все'),
            Text('один станок или все видимые'),
            Text('поиск по номеру заказа'),
            Text('поиск по наименованию'),
            Text('поиск по номеру заказа 1C'),

            //** кнопки
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: ElevatedButton(
                          onPressed: () async {
                            // await filterProvider.readFilterData().then(
                            //         (value) =>
                            //         Navigator.of(context).pushNamed('/'));
                            Navigator.of(context).pushNamed(OrderOverview.routeName);
                          },
                          child: const Icon(Icons.arrow_back)),
                    )),
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ElevatedButton(
                          onPressed: () {
                            // filterProvider.clearFilter();
                            // genres.setCheckedValue('');
                            // filterProvider.saveFilterData().then((value) =>
                            //     Navigator.of(context).pushNamed('/'));
                          },
                          child: const Text('сброс')),
                    )),
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ElevatedButton(
                          onPressed: () {
                            // filter.fltSeries = '';
                            // filter.fltGenres = genres.codeCheckString;
                            // widget.pressDone();
                            // filterProvider.saveFilterData().then((value) =>
                            //     Navigator.of(context).pushNamed('/'));
                          },
                          child: const Text('готово')),
                    )),
              ],
            )


          ],


        ),
      ),
    );
  }
}

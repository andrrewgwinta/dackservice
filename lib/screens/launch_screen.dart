import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:provider/provider.dart';

import '../globals.dart' as global;
import '../providers/machines.dart';
import '../providers/session.dart';
import '../providers/users.dart';
import '../screens/logon_screen.dart';

class LaunchScreen extends StatefulWidget {
  static const routeName = '/launch';

  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('ru');
    _appInitialization();
  }

  void _appInitialization() async {
    await Provider.of<Session>(context, listen: false).loadSavedSession();
    await Provider.of<Machines>(context, listen: false).loadOrdMachines();
    await Provider.of<Users>(context, listen: false).loadUsers();

    print('in launchScreen  ${global.machineId} ${global.userId}');
    global.starting = false;
    //Navigator.of(context).popUntil(ModalRoute.withName('/'));
    // Navigator.of(context)
    //     .pushNamedAndRemoveUntil('/launch', (Route<dynamic> route) => false);
    Navigator.pushReplacementNamed(context, LogonScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    print('in Build launchscreen  ${global.machineId} ${global.userId}' );

    return const Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     'запуск',
      //     style: TextStyle(color: Colors.white),
      //   ),
      // ),
      body: LaunchBody(),

    );
  }
}

class LaunchBody extends StatelessWidget {
  const LaunchBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Container(
       decoration: BoxDecoration(
         //color: Theme.of(context).primaryColor,
         image: DecorationImage(
           image: Image.asset('assets/image/biesse_start1.png').image,
           fit: BoxFit.fitWidth,
         ),
       ),
       child: Center(child: CircularProgressIndicator(),),
     );
  }
}
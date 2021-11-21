import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';

import '../globals.dart' as global;
import '../utilities.dart';
import '../providers/session.dart';

class SettingScreen extends StatelessWidget {
  static const routeName = '/setting';

  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          'настройки',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: const SettingWidget(),
    );
  }
}

class SettingWidget extends StatefulWidget {
  const SettingWidget({Key? key}) : super(key: key);

  @override
  _StateSettingWidget createState() => _StateSettingWidget();
}

class _StateSettingWidget extends State<SettingWidget> {
  final TextEditingController _controller = TextEditingController();
  bool _keyboardVisible = false;
  late StreamSubscription<bool> keyboardSubscription;
  String serverText = '';

  @override
  void initState() {
    super.initState();
    var keyboardVisibilityController = KeyboardVisibilityController();
    // Query
    //print('Keyboard visibility direct query: ${keyboardVisibilityController.isVisible}');
    // Subscribe
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      //print('Keyboard visibility update. Is visible: $visible');
      setState(() {
        _keyboardVisible = visible;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    keyboardSubscription.cancel();
    super.dispose();
  }

  void saveServerName(){
       final session = Provider.of<Session>(context, listen: false);
       session.setServerName(serverText);
       session.saveCurrentSession();
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = global.serverName;
    //print('rebuild SettingWidget');

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 0),
              child: Text(
                'имя сервера(или IP), порт',
                style: TextStyle(color: Palette.kDackColor[100]),
              )),
          Container(
            height: 65,
            decoration: API.kBoxDecoration(),
            //padding: EdgeInsets.all(5),
            //margin: EdgeInsets.all(5),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: TextField(
                  controller: _controller,
                  onChanged: (value) => serverText = value,
                  decoration: API.kInputDecoration(),
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: _keyboardVisible
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.all(4),
                  height: 35,
                  width: double.infinity,
                  //color: Colors.yellow,
                  child: _keyboardVisible
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FloatingActionButton(
                              onPressed: ()=>saveServerName(),
                              child: const Icon(Icons.forward,
                                  size: 20, color: Colors.white),
                            ),
                          ],
                        )
                      : ElevatedButton(
                          child: const Text(
                            'запомнить',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: ()=>saveServerName(),
                          //style: E,
                        )),
            ],
          )),
        ],
      ),
    );
  }
}

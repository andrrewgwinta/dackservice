import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './helpers/custom_route.dart';
import './providers/session.dart';
import './providers/machines.dart';
import './providers/users.dart';
import './providers/ordservice.dart';
import './providers/ordarticle.dart';
import './providers/staff.dart';



import './screens/launch_screen.dart';
import './screens/logon_screen.dart';
import './screens/order_overview.dart';
import './screens/setting_screen.dart';
import './utilities.dart';
import '../globals.dart' as global;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Session()),
        ChangeNotifierProvider(create: (ctx) => Machines()),
        ChangeNotifierProvider(create: (ctx) => Users()),
        ChangeNotifierProvider(create: (ctx) => OrdServices()),
        ChangeNotifierProvider(create: (ctx) => OrdArticles()),
        ChangeNotifierProvider(create: (ctx) => Staff()),
      ],
      child: Consumer<Session>(
        builder: (ctx, auth, _) =>
            MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'выполнение операций',
              theme: ThemeData(
                //brightness: Brightness.dark,
                //primarySwatch: Palette.kDackColor,
                pageTransitionsTheme: PageTransitionsTheme(builders: {
                  TargetPlatform.android: CustomPageTransitionBuilder(),
                  TargetPlatform.iOS: CustomPageTransitionBuilder(),
                }),
              ),

              routes: {
                '/': (ctx) =>(global.starting)?LaunchScreen():LogonScreen(),
                // {
                //   if (global.starting) {
                //     return LaunchScreen();
                //   }
                //   else
                //     if (auth.noServer) {
                //       return SettingScreen();
                //     }
                //     else
                //   if (auth.noToken) {
                //   return LogonScreen();
                //   }
                // },

                LogonScreen.routeName: (ctx) => LogonScreen(),
                SettingScreen.routeName: (ctx) => SettingScreen(),
                OrderOverview.routeName: (ctx) => OrderOverview(),
                LaunchScreen.routeName: (ctx) => LaunchScreen(),
              },
            ),
      ),
    );
  }
}

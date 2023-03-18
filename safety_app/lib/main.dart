import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensors_plus/sensors_plus.dart';

import 'accelerometerInfo.dart';
import 'items/colors.dart' as colors;
import 'items/textStyles.dart' as textStyles;

import 'items/chatWidgets.dart' as chatWidgets;
import 'items/mainWidgets.dart' as mainWidgets;

import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: colors.backgroundColor,
      ),
      home: homeScreen(),
    );
  }
}

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  bool triggerred = false;
  @override
  void initState() {
    super.initState();
    // smt();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colors.backgroundColor,
        body: InkWell(
          child: triggerred
              ? Column(
                  children: [
                    Expanded(
                        child: Container(
                      color: Colors.red,
                    )),
                  ],
                )
              : SafeArea(
                  minimum: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Column(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              color: colors.backgroundColor,
                              child: Row(children: [
                                Text("Edit",
                                    style: textStyles.blueUnderlineText),
                                Expanded(
                                    child: Container(
                                        color: colors.backgroundColor)),
                                Icon(Icons.camera_alt_outlined,
                                    color: colors.primaryHighlight),
                                SizedBox(
                                  width: 15,
                                ),
                                Icon(Icons.mode_edit_outline,
                                    color: colors.primaryHighlight),
                              ]),
                            ),
                          )),
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              color: colors.backgroundColor,
                              child: Text(
                                "Chats",
                                style: TextStyle(
                                  fontSize: 38,
                                  color: colors.foregroundText,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              alignment: Alignment.topLeft,
                            ),
                          )),
                      SizedBox(
                        height: 14,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [
                            Text(
                              "Broadcast Lists",
                              style: textStyles.blueUnderlineText,
                            ),
                            Expanded(child: Container()),
                            Text(
                              "New Group",
                              style: textStyles.blueUnderlineText,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Divider(
                          color: colors.backgroundColor,
                          thickness: 0.75,
                          height: 10),
                      Divider(
                        color: colors.lowGrey,
                        thickness: 0.75,
                        height: 0,
                      ),
                      Expanded(
                          flex: 21,
                          child: ListView(
                            children: [...chatWidgets.userChatList],
                          )),
                      Divider(
                        color: colors.lowGrey,
                        thickness: 0.75,
                        height: 0,
                      ),
                      Expanded(
                          flex: 3,
                          child: Container(
                              color: colors.bottomNavBarColor,
                              child: mainWidgets.BottomNavBarUI())),
                    ],
                  ),
                ),
          onDoubleTap: () {
            setState(() {
              triggerred = !triggerred;
            });
          },
        ));
  }
}

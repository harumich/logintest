import 'package:flutter/material.dart';
import 'package:logintest/model/account.dart';

class TimeLinePage extends StatefulWidget {
  const TimeLinePage({Key? key}) : super(key: key);

  @override
  _TimeLinePageState createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  Account myAccount = Account(
    id: '1',
    name: 'Flutterラボ',
    selfIntroduction: 'こんばんは',
    useId: 'flutter_labo',
    imagePath: 'https://pics.prcm.jp/5497864537d25/82527407/jpeg/82527407_480x599.jpeg',
    createdTime: DateTime.now(),
    updatedTime: DateTime.now(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('タイムライン')),
    );
  }
}

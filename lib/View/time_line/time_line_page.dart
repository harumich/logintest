import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logintest/model/account.dart';
import 'package:logintest/model/post.dart';

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
    userId: 'flutter_labo',
    imagePath: 'https://pics.prcm.jp/5497864537d25/82527407/jpeg/82527407_480x599.jpeg',
    createdTime: DateTime.now(),
    updatedTime: DateTime.now(),
  );

  List<Post> postList = [
    Post(
      id: '1',
      content: '初めまして',
      postAccountId: '1',
      createdTime: DateTime.now()
    ),
    Post(
        id: '2',
        content: 'ご機嫌よう！',
        postAccountId: '1',
        createdTime: DateTime.now()
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('タイムライン', style: TextStyle(color: Colors.black),),
        backgroundColor: Theme.of(context).canvasColor,//bodyと同じ色の背景に
        elevation: 2,//appBarとbodyの境界線の太さ
      ),
      body: ListView.builder(  //ListView.builderは同じようなものを繰り返し表示させていくのに使うwidget
        itemCount: postList.length,  //いくつ表示する？
        itemBuilder: (context, index) {  //何を表示させる
          return Container(  //widget内のUIを設計
            decoration: BoxDecoration(  //区切りを創る
              border: index == 0 ? Border(  //区切りを創る
                top: BorderSide(color: Colors.grey, width: 0),
                bottom: BorderSide(color: Colors.grey, width: 0),
              ) : Border(bottom: BorderSide(color: Colors.grey, width: 0),)
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),  //widget内にゆとりを持たせる
            child: Row(
              children: [
                CircleAvatar(  //CircleAvatar: 丸形のwidgetを表示させたいときに使う
                  radius: 22,
                  foregroundImage: NetworkImage(myAccount.imagePath),  //NetworkImage=インターネット上の画像
                ),
                Expanded(  //myAccount.name＆myAccount.userIdとDateFormatの間にスペースを創る
                  child: Container(  //myAccount.name＆myAccount.userIdとDateFormatの間にスペースを創る
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,  //contentを真ん中から左に移動させる
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,  //myAccount.name＆myAccount.userIdとDateFormatの間にスペースを創る
                          children: [
                            Row(  //myAccount.name＆myAccount.userIdとDateFormatの間にスペースを創る
                              children: [
                                Text(myAccount.name, style: TextStyle(fontWeight: FontWeight.bold),),
                                Text('@${myAccount.userId}', style: TextStyle(color: Colors.green)),
                              ],
                            ),
                            Text(DateFormat('M/d/yy').format(postList[index].createdTime!)),  // !='null'は絶対ないよ  //intlをインポートする  //String型に変更する
                          ],
                        ),
                        Text(postList[index].content),  //contentを表示
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

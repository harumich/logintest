import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logintest/View/time_line/post_page.dart';
import 'package:logintest/model/account.dart';
import 'package:logintest/model/post.dart';
import 'package:logintest/utils/firestore/posts.dart';
import 'package:logintest/utils/firestore/users.dart';

class TimeLinePage extends StatefulWidget {
  const TimeLinePage({Key? key}) : super(key: key);

  @override
  _TimeLinePageState createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('タイムライン', style: TextStyle(color: Colors.black),),
        backgroundColor: Theme.of(context).canvasColor,//bodyと同じ色の背景に
        elevation: 2,//appBarとbodyの境界線の太さ
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: PostFirestore.posts.orderBy('created_time', descending: true).snapshots(),
        builder: (context, postSnapshot) {
          if(postSnapshot.hasData) {
            List<String> postAccountIds = [];
            postSnapshot.data!.docs.forEach((doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              if(!postAccountIds.contains(data['post_account_id'])) {
                postAccountIds.add(data['post_account_id']);
              }
            });
            return FutureBuilder<Map<String, Account>?>(
              future: UserFirestore.getPostUserMap(postAccountIds),
              builder: (context, userSnapshot) {
                if(userSnapshot.hasData && userSnapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(  //ListView.builderは同じようなものを繰り返し表示させていくのに使うwidget
                    itemCount: postSnapshot.data!.docs.length,  //いくつ表示する？
                    itemBuilder: (context, index) {//何を表示させる
                      Map<String, dynamic> data = postSnapshot.data!.docs[index].data() as Map<String, dynamic>;
                      Post post = Post(
                        id: postSnapshot.data!.docs[index].id,
                        content: data['content'],
                        postAccountId: data['post_account_id'],
                        createdTime: data['created_time']
                      );
                      Account postAccount = userSnapshot.data![post.postAccountId]!;
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
                              foregroundImage: NetworkImage(postAccount.imagePath),  //NetworkImage=インターネット上の画像
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
                                            Text(postAccount.name, style: TextStyle(fontWeight: FontWeight.bold),),
                                            Text('@${postAccount.userId}', style: TextStyle(color: Colors.green)),
                                          ],
                                        ),
                                        Text(DateFormat('M/d/yy').format(post.createdTime!.toDate())),  // !='null'は絶対ないよ  //intlをインポートする  //String型に変更する
                                      ],
                                    ),
                                    Text(post.content),  //contentを表示
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Container();
                }
              }
            );
          } else {
            return Container();
          }

        }
      ),
    );
  }
}

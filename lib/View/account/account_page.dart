import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logintest/View/account/edit_account_page.dart';
import 'package:logintest/model/account.dart';
import 'package:logintest/model/post.dart';
import 'package:logintest/utils/authentication.dart';
import 'package:logintest/utils/firestore/posts.dart';
import 'package:logintest/utils/firestore/users.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Account myAccount = Authentication.myAccount!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,  //SingleChildScrollViewのエラー対策
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(right: 15, left: 15, top: 20),
                  height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 32,
                                foregroundImage: NetworkImage(myAccount.imagePath),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(myAccount.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                  Text('@${myAccount.userId}', style: TextStyle(color: Colors.grey),),
                                ],
                              )
                            ],
                          ),
                          OutlinedButton(
                              onPressed: () async {
                                var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => EditAccountPage()));
                                if(result == true) {
                                  setState(() {
                                    myAccount = Authentication.myAccount!;
                                  });
                                }
                              }, child: Text('編集')
                          )
                        ],
                      ),
                      SizedBox(height: 15),
                      Text(myAccount.selfIntroduction)
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(
                      color: Colors.blue, width: 3
                    ))
                  ),
                  child: Text('投稿', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
                ),
                Expanded(child: StreamBuilder<QuerySnapshot>(
                  stream: UserFirestore.users.doc(myAccount.id).collection('my_posts').orderBy('created_time', descending: true).snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      List<String> myPostIds = List.generate(snapshot.data!.docs.length, (index) {
                        return snapshot.data!.docs[index].id;
                      });
                      return FutureBuilder<List<Post>?>(
                        future: PostFirestore.getPostsFromIds(myPostIds),
                        builder: (context, snapshot) {
                          if(snapshot.hasData) {
                            return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  Post post = snapshot.data![index];
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
                                });
                          } else {
                            return Container();
                          }
                        }
                      );
                    } else {
                      return Container();
                    }
                  }
                )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  TextEditingController contentController = TextEditingController();  //テキストフィールドの入力値を取得するための設定

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('新規投稿', style: TextStyle(color: Colors.black),),
        backgroundColor: Theme.of(context).canvasColor,//bodyと同じ色の背景に
        elevation: 2,
        iconTheme: IconThemeData(color: Colors.black),  //戻る矢印を黒色にする
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: contentController,  //テキストフィールドの入力値を取得
            ),
            SizedBox(height: 30),
            ElevatedButton(
                onPressed: () {

                },
                child: Text('投稿')
            )
          ]
        ),
      ),
    );
  }
}

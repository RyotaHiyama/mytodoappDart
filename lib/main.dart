import 'package:flutter/material.dart';

void main() {
  //最初に表示するWidget
  runApp(MyTodoApp());
}

class MyTodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      //右上に表示されるdebugラベルを消す
      debugShowCheckedModeBanner: false,
      //アプリ名
      title: 'My Todo App',
      theme: ThemeData(
        //テーマカラー
        primarySwatch: Colors.blue,
      ),
      //リスト一覧画面を表示
      home: TodoListPage(),
    );
  }
}

//リスト一覧画面用widget
class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

//リスト一覧画面用Widget
class _TodoListPageState extends State<TodoListPage> {
  //Todoリストのデータ
  List<String> todoList = [];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      //AppBarを表示し，タイトルも設定
      appBar: AppBar(
        title: Text('リスト一覧画面'),
      ),
      //データを元にListViewを作成
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(todoList[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //pushで新規画面に遷移
          //リスト追加画面から渡される値を受け取る
          final newListText = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context){
              //遷移先の画面としてリスト追加画面を指定
              return TodoAddPage();
            }),
          );
          if (newListText != null){
          //  キャンセルした場合はnewListTextがnullとなるので注意
            setState(() {
              //リスト追加
              todoList.add(newListText);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class TodoAddPage extends StatefulWidget {
  @override
  _TodoAddPageState createState() => _TodoAddPageState();
}

//リスト追加画面用Widget
class _TodoAddPageState extends State<TodoAddPage> {
  //入力されたテキストをデータとして持つ
  String _text = '';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('リスト追加'),
      ),
      body: Container(
        //余白をつける
        padding: EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //入力されたテキストを表示
            Text(_text, style: TextStyle(color: Colors.blue)),
            const SizedBox(height: 8),
            //テキスト入力
            TextField(
            //  入力されたテキストの値を受け取る（valueが入力されたテキスト）
              onChanged: (String value) {
                //データが変更したことを知らせる（画面を更新する）
                setState(() {
                //  データを変更
                  _text = value;
                });
              },
            ),
            const SizedBox(height: 8),
            Container(
              //横幅いっぱいに広げる
              width: double.infinity,
              //リスト追加ボタン
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue
                ),
                onPressed: () {
                  Navigator.of(context).pop(_text);
                },
                child: Text('リスト追加', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              //横幅いっぱいに広げる
              width: double.infinity,
              //キャンセルボタン
              child: TextButton(
                //ボタンをクリックしたときの処理
                onPressed: () {
                  //popで前の画面に戻る
                  Navigator.of(context).pop();
                },
                child: Text('キャンセル'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

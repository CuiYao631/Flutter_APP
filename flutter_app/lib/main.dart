import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() =>runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '测试程序',
      theme: new ThemeData(
        primaryColor: Colors.black,
      ),
      home: new RandomWords(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class RandomWords extends StatefulWidget{
  @override
  createState()=>new RandomWordsState();

}
class RandomWordsState extends State<RandomWords>{
  final _suggestions=<WordPair>[];
  final _saved=new Set<WordPair>();
  final _biggerFont=const TextStyle(fontSize: 18.0);
  Widget _buildSuggestions(){
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      // 对于每个建议的单词对都会调用一次itemBuilder，然后将单词对添加到ListTile行中
      // 在偶数行，该函数会为单词对添加一个ListTile row.
      // 在奇数行，该函数会添加一个分割线widget，来分隔相邻的词对。
      // 注意，在小屏幕上，分割线看起来可能比较吃力
      itemBuilder: (context, i){
        // 在每一列之前，添加一个1像素高的分隔线widget
        if(i.isOdd)return new Divider();
        // 语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整），比如i为：1, 2, 3, 4, 5
        // 时，结果为0, 1, 1, 2, 2， 这可以计算出ListView中减去分隔线后的实际单词对数量
      final index =i ~/2;
      if(index>=_suggestions.length){
        _suggestions.addAll(generateWordPairs().take(10));
      }
      return _builodRow(_suggestions[index]);
      }
    );
  }
  Widget _builodRow(WordPair pair){
    final alreadySaved=_saved.contains(pair);
    return new ListTile(
      title: new  Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite:Icons.favorite_border,
        color: alreadySaved ? Colors.red:null,
      ),
      onTap: (){
        setState(() {
          if(alreadySaved){
            _saved.remove(pair);
          }else{
            _saved.add(pair);
          }
        });
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    //final wordPair=new WordPair.random();
    //return new Text(wordPair.asPascalCase);
    return new Scaffold(
      appBar: new AppBar(
        leading: new Icon(Icons.account_circle),
        title: new Text('主页'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved),
          new IconButton(icon: new Icon(Icons.add), onPressed: addtt)
        ],
      ),
      body: _buildSuggestions(),
    );
  }
  void addtt(){
    Navigator.of(context).push(
      new MaterialPageRoute(builder: null)
      
    );
  }
  void _pushSaved(){
    Navigator.of(context).push(
      new MaterialPageRoute(
          builder: (context){
            final tiles=_saved.map(
                (pair){
                  return new ListTile(
                    title: new Text(
                      pair.asPascalCase,
                      style: _biggerFont,
                    ),
                  );
                },
            );
            final divided=ListTile.divideTiles(
              context: context,
              tiles: tiles
            )
            .toList();
            return new Scaffold(
              appBar: new AppBar(
                title: new  Text('收藏页'),
              ),
              body:  new ListView(children: divided,),
            );
        },
      ),
    );
  }
}
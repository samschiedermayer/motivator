import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Motivator',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new MyHomePage(title: 'Motivator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _pageIndex = 0;

  void _onBottomBarTapped(int i) {
    setState(() {
      _pageIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_pageIndex) {
      case 0:
        return new Scaffold(
          appBar: new AppBar(
            title: new Text(widget.title),
          ),
          body: new Center(
            child: new Text('Home'),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _pageIndex,
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                title: new Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.assistant_photo),
                title: new Text('Goals'),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.account_box),
                title: new Text('Me'),
              )
            ],
            onTap: _onBottomBarTapped,
          ),
        );

      case 1:
        return new Scaffold(
          appBar: new AppBar(
            title: new Text(widget.title),
          ),
          body: new Center(
            child: new Text('Goals'),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _pageIndex,
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                title: new Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.assistant_photo),
                title: new Text('Goals'),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.account_box),
                title: new Text('Me'),
              )
            ],
            onTap: _onBottomBarTapped,
          ),
        );

      case 2:
        return new Scaffold(
          appBar: new AppBar(
            title: new Text(widget.title),
          ),
          body: new Center(
            child: new Text('Me'),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _pageIndex,
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                title: new Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.assistant_photo),
                title: new Text('Goals'),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.account_box),
                title: new Text('Me'),
              )
            ],
            onTap: _onBottomBarTapped,
          ),
        );
    }
  }
}

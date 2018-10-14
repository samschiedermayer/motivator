import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

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
//          appBar: _buildTopBar(),
          body: _buildHome(),
          bottomNavigationBar: _buildBottomNavBar(),
        );

      case 1:
        return new Scaffold(
//          appBar: _buildTopBar(),
          body: _buildGoals(),
          bottomNavigationBar: _buildBottomNavBar(),
        );

      case 2:
        return new Scaffold(
//          appBar: _buildTopBar(),
          body: _buildMe(),
          bottomNavigationBar: _buildBottomNavBar(),
        );
    }
  }

  Widget _buildHome() {
    return new Scaffold(
        body: new Align(
      child: new Padding(
        padding: EdgeInsets.only(top: 40.0),
        child: new Column(
          children: <Widget>[
            new Text(
                'Home',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: new Image(
                  image: AssetImage('assets/kitten_domination.jpg'),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildGoals() {
    return new Scaffold(
      body: new Center(
        child: new Text('Goals'),
      ),
    );
  }

  Widget _buildMe() {
    return new Scaffold(
      body: new Center(
        child: new Text('Me'),
      ),
    );
  }

  BottomNavigationBar _buildBottomNavBar() {
    return new BottomNavigationBar(
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
    );
  }

  AppBar _buildTopBar() {
    return new AppBar(
      title: new Text(widget.title),
    );
  }
}

Future<String> loadAsset(String assetName) async {
  return await rootBundle.loadString('assets/' + assetName);
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  void _onNewGoalTapped() async {
    final textController = TextEditingController();
    await showDialog(
        context: context,
        child: new AlertDialog(
          content: new Row(
            children: <Widget>[
              new Expanded(
                  child: new TextField(
                autofocus: true,
                decoration: new InputDecoration(
                  labelText: 'My Goal',
                  hintText: 'Conquer the world',
                ),
                controller: textController,
              ))
            ],
          ),
          actions: <Widget>[
            new FlatButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                }),
            new FlatButton(
                child: const Text('SUBMIT'),
                onPressed: () {
                  Navigator.pop(context);
                  Firestore.instance.collection('goals').add({"name": textController.text});
                })
          ],
        ));
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (_pageIndex) {
      case 0:
        return new Scaffold(
          appBar: _buildTopBar(context),
          body: _buildHome(context),
          bottomNavigationBar: _buildBottomNavBar(context),
        );

      case 1:
        return new Scaffold(
          appBar: _buildTopBar(context),
          body: _buildGoals(context),
          bottomNavigationBar: _buildBottomNavBar(context),
        );

      case 2:
        return new Scaffold(
          appBar: _buildTopBar(context),
          body: _buildMe(context),
          bottomNavigationBar: _buildBottomNavBar(context),
        );
    }
  }

  Widget _buildHome(BuildContext context) {
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

  Widget _buildGoals(BuildContext context) {
    return new Scaffold(
      body: _buildGoalsBody(context),
      floatingActionButton:
          new FloatingActionButton(onPressed: _onNewGoalTapped),
    );
  }

  Widget _buildMe(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Text('Me'),
      ),
    );
  }

  BottomNavigationBar _buildBottomNavBar(BuildContext context) {
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

  AppBar _buildTopBar(BuildContext context) {
    return new AppBar(
      title: new Text(widget.title),
    );
  }

  Widget _buildGoalsBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('goals').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Goal.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.name),
          trailing: Text(record.deadline.toString()),
          onTap: () => print(record),
        ),
      ),
    );
  }
}

class Goal {
  final String name;
  final String deadline;
  final DocumentReference reference;

  Goal.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        name = map['name'],
        deadline =
            (map['dateTime'] != null) ? map['dateTime'].toString() : 'anytime';

  Goal.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$deadline>";
}

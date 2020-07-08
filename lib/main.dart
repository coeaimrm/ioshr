import 'package:flutter/material.dart';
import 'package:hrs/instant_feed.dart';
import 'package:hrs/dashboard.dart';
void main() {
  runApp(new MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Generated App',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2196f3),
        accentColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFfafafa),
      ),
      routes: <String, WidgetBuilder>{
        '/page1': (BuildContext context) => new HomePage(),
        '/page2': (BuildContext context) => new InstantFeedPage(),
        '/page3': (BuildContext context) => new Dashboard()},
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('HR App'),
      ),
      body:
      new Container(
        child:
        new Center(
          child:
          new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Text(
                  "Welcome to",
                  style: new TextStyle(fontSize: 49.0,
                      color: const Color(0xFFf7eded),
                      fontWeight: FontWeight.w700,
                      fontFamily: "Roboto"),
                ),

                new Text(
                  "Instant",
                  style: new TextStyle(fontSize: 40.0,
                      color: const Color(0xFFfbf9f9),
                      fontWeight: FontWeight.w700,
                      fontFamily: "Roboto"),
                ),

                new Text(
                  "Feedback App",
                  style: new TextStyle(fontSize: 40.0,
                      color: const Color(0xFFfbf9f9),
                      fontWeight: FontWeight.w700,
                      fontFamily: "Roboto"),
                ),
                SizedBox(
                  height: 50.0,
                ),

                RaisedButton(
                    color: Color(0xff11b719),
                    textColor: Colors.white,
                    child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text("Instant Feedback",
                                style: TextStyle(fontSize: 24.0)),
                          ],
                          )),
                         onPressed: () {Navigator.of(context).pushNamed('/page2');},
                         shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0))),
                SizedBox(
                  height: 50.0,
                ),
                RaisedButton(
                    color: Color(0xff11b719),
                    textColor: Colors.white,
                    child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text("Dashboard", style: TextStyle(fontSize: 24.0)),
                           ],
                           )),
                          onPressed: () {Navigator.of(context).pushNamed('/page3');},
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)))
              ]

          ),

        ),

        color: const Color(0xFFef6666),
        padding: const EdgeInsets.all(0.0),
        alignment: Alignment.center,
        width: 1.7976931348623157e+308,
        height: 1.7976931348623157e+308,
      ),

    );
  }
}


import 'dart:async';
import 'package:flutter/material.dart';
import 'gameDetails.dart';
import 'about.dart';
import 'loadGame.dart';
import 'ScoreScreen.dart';
import 'user_name_dialog.dart';
import 'database_helpers.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.blueAccent));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]); //used for portrait mode..
  runApp(MyApp());
}

List dataBase;
List names = [];
int count;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal, //primary theme color
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    read();
  }

  del() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    await helper.deleteall();
    print(dataBase);
  } // To delete all records from database. But not used in this program.

  @override
  Widget build(BuildContext context) {
    double height =
        MediaQuery.of(context).size.height; // to get the device's height
    double width =
        MediaQuery.of(context).size.width; // to get the device's width

    final topPadding = MediaQuery.of(context).padding.top; // top safearea
    final bottomPadding =
        MediaQuery.of(context).padding.bottom; // bottom safearea
    return WillPopScope(
      onWillPop: () {
        DateTime currentBackPressTime;
        DateTime now = DateTime.now();
        if (currentBackPressTime == null ||
            now.difference(currentBackPressTime) < Duration(seconds: 2)) {
          currentBackPressTime = now;
          //return Future.value(false);
          return SystemNavigator.pop();
        }
        return Future.value(true);
      }, // double tap to exit code
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.indigo, Colors.blue]),
              ),
              height: height - topPadding - bottomPadding,
              width: width,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                    height: height * 0.06,
                    width: width * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 11),
                          child: PopupMenuButton(
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: Column(
                                  children: [
                                    //SizedBox(height:10),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, bottom: 10.0),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    GameDetails()),
                                          );
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.games_outlined,
                                              color: Colors.black,
                                              size: 23.0,
                                            ),
                                            SizedBox(width: 10),
                                            Text('Game Details')
                                          ],
                                        ),
                                      ),
                                    ),
                                    //SizedBox(height:10),
                                    Divider(
                                      height: 2.0,
                                      thickness: 2.0,
                                    ),
                                    //SizedBox(height:10),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, bottom: 10.0),
                                      child: InkWell(
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.settings,
                                              color: Colors.black,
                                              size: 23.0,
                                            ),
                                            SizedBox(width: 10),
                                            Text('Setting')
                                          ],
                                        ),
                                      ),
                                    ),
                                    //SizedBox(height:10),
                                    Divider(
                                      height: 2.0,
                                      thickness: 2.0,
                                    ),
                                    //SizedBox(height:10),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, bottom: 10.0),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => About()),
                                          );
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.info_outline,
                                              color: Colors.black,
                                              size: 23.0,
                                            ),
                                            SizedBox(width: 10),
                                            Text('About')
                                          ],
                                        ),
                                      ),
                                    ),
                                    //SizedBox(height:10),
                                  ],
                                ),
                              ),
                            ],
                            child: Icon(
                              Icons.menu,
                              color: Colors.tealAccent,
                              size: 35.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.5,
                        ),
                        IconButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Thanks for Rating!'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                          icon: Icon(Icons.star),
                          iconSize: 38,
                          color: Colors.yellow,
                        ),
                        IconButton(
                          onPressed: () {
                            print(topPadding);
                            print(bottomPadding);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Thanks for Sharing!'),
                              duration: Duration(seconds: 1),
                            ));
                          },
                          icon: Icon(Icons.share),
                          iconSize: 35,
                          color: Colors.orange,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Card(
                    elevation: 60.0,
                    color: null,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(5),
                      height: height * .10,
                      width: width * .9,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                'Stone Scissor Paper',
                                style: TextStyle(
                                    color: Colors.pink,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.035,
                  ),
                  Card(
                    elevation: 10.0,
                    color: null,
                    shape: RoundedRectangleBorder(
                      //borderRadius: BorderRadius.circular(40.0)
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40.0),
                          bottomRight: Radius.circular(40.0),
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0)),
                    ),
                    child: Container(
                      height: height * .10,
                      width: width * .65,
                      child: TextButton(
                          onPressed: () {
                            userNameDialog(context).then((name) {
                              print(name);
                            });
                          },
                          child: Text(
                            'New Game',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 20),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  Card(
                    elevation: 10.0,
                    color: null,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(40.0),
                          bottomRight: Radius.circular(40.0)),
                    ),
                    child: Container(
                      height: height * .10,
                      width: width * .55,
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoadGame()),
                            );
                          },
                          child: Text(
                            "Load Game",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 19),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  Card(
                    elevation: 10.0,
                    color: null,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(40.0),
                          bottomRight: Radius.circular(40.0)),
                    ),
                    child: Container(
                      height: height * .10,
                      width: width * 0.45,
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ScoreScreen()),
                            );
                          },
                          child: Text(
                            "Scores",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 20),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  Card(
                    elevation: 10.0,
                    color: null,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(40.0),
                          bottomRight: Radius.circular(40.0)),
                    ),
                    child: Container(
                      height: height * .10,
                      width: width * 0.35,
                      child: TextButton(
                        onPressed: () {
                          SystemNavigator.pop();
                        },
                        child: Text(
                          "Exit",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.14),
                  Text(
                    'Version: 1.0.0',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

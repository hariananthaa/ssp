import 'package:flutter/material.dart';
import 'dart:math';
import 'main.dart';

String name1, score1, updated = '1';

class ScoreScreen extends StatefulWidget {
  @override
  _ScoreScreenState createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    print(dataBase);
    print(names);
    if (names.isEmpty) {
      setState(() {
        count = 1;
        print('loose');
      });
    }
    print('countis $count');
    customAppbar() {
      return PreferredSize(
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 25.0, left: 20.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.indigo, Colors.blue]),
            ),
            child: Text(
              'ScoreBoard',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          preferredSize: Size.fromHeight(80));
    }

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return;
      },
      child: SafeArea(
        child: Scaffold(
            appBar: customAppbar(),
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo, Colors.blue],
                ),
              ),
              child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                itemExtent: 85,
                itemCount: count,
                itemBuilder: (context, index) {
                  //print('count $count');
                  //print('index $index');
                  if (names.isEmpty) {
                    print('database is empty');
                    return Container(
                      alignment: Alignment.center,
                      child: Center(
                        child: Text(
                          'No Score',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 27,
                          ),
                        ),
                      ),
                    );
                  } else
                    return InkWell(
                      onTap: () {
                        print('usercount $count');
                        print('index $index');
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 5.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            SizedBox(width: 7),
                            Container(
                              width: width * 0.15,
                              child: CircleAvatar(
                                radius: 29,
                                backgroundColor: Colors.primaries[
                                    Random().nextInt(Colors.primaries.length)],
                                foregroundColor: Colors.white,
                                child: Text(
                                  (index + 1).toString(),
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 4),
                            Container(
                              padding: EdgeInsets.all(10),
                              width: width * 0.62,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    dataBase[0][index]['name'],
                                    style: TextStyle(
                                      fontSize: 23,
                                    ),
                                  ),
                                  Text(
                                    'Efficiency : ${dataBase[0][index]['winningPercent']}%',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: width * 0.15,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Points',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    (dataBase[0][index]["points"]).toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                          ],
                        ),
                      ),
                    );
                },
              ),
            )),
      ),
    );
  }
}

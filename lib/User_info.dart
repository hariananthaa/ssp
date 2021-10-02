import 'package:flutter/material.dart';

class UserInfo extends StatefulWidget {
  final int index;
  final List userInfo;
  UserInfo({this.index, this.userInfo});
  @override
  _UserInfoState createState() => _UserInfoState(index, userInfo);
}

class _UserInfoState extends State<UserInfo> {
  int index;
  List userInfo;
  _UserInfoState(this.index, this.userInfo);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    //double height = 100;
    //double width = 0;

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('UserInfo'),
            backgroundColor: Colors.indigoAccent,
          ),
          body: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(12),
                child: Text(
                  userInfo[index]['name'],
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Divider(
                height: 2,
                thickness: 3,
                color: Colors.black26,
                indent: 15,
                endIndent: 15,
              ),
              Container(
                padding:
                    EdgeInsets.only(right: 25, left: 15, top: 15, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 77,
                      backgroundColor: Colors.pink,
                      foregroundColor: Colors.white,
                      child: Text(
                        userInfo[index]['name'][0],
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 8,
                              backgroundColor: Colors.black54,
                            ),
                            Text(
                              ' Points',
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepOrange,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 35,
                            ),
                            Text(
                              (userInfo[index]['points']).toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 8,
                              backgroundColor: Colors.black54,
                            ),
                            Text(
                              ' Efficiency',
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 35,
                            ),
                            Text(
                              '${userInfo[index]['winningPercent']}%',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                height: 2,
                thickness: 3,
                color: Colors.black26,
                indent: 15,
                endIndent: 15,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        text: 'Total Round : ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: (userInfo[index]['overallRound']).toString(),
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    RichText(
                      text: TextSpan(
                        text: '${userInfo[index]['name']}: ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: (userInfo[index]['userPoint']).toString(),
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Computer : ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: (userInfo[index]['comPoint']).toString(),
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Tie : ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: (userInfo[index]['tiePoint']).toString(),
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 2,
                thickness: 3,
                color: Colors.black26,
                indent: 15,
                endIndent: 15,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(13),
                child: Column(
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        text: 'Profile Created : ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: userInfo[index]['createdTime'],
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Profile Updated : ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: userInfo[index]['updatedTime'],
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 2,
                thickness: 3,
                color: Colors.black26,
                indent: 15,
                endIndent: 15,
              ),
              Container(
                alignment: Alignment.center,
                width: width * 0.60,
                margin: EdgeInsets.all(17),
                padding: EdgeInsets.all(13),
                decoration: BoxDecoration(
                  gradient:
                      LinearGradient(colors: [Colors.indigo, Colors.blue]),
                ),
                child: Text(
                  'All the best..',
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

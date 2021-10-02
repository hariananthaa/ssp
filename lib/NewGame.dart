import 'dart:math';

import 'package:flutter/material.dart';

import 'database_helpers.dart';
import 'main.dart';

enum WidgetMarker { stone, scissor, paper, normal }
String tieImage = 'asset/winning.png',
    failureImage = 'asset/failure.png',
    winningImage = 'asset/victory.png';
String winningResult = 'Congratulation',
    failureResult = 'You are not Win',
    tieResult = 'Congratulation';
String winningMsg = 'You won the game',
    failureMsg = 'Believe in yourself',
    tieMsg = 'Both are Winners';
double winningPercent = 0.0;
int points = 000;
String rank = '-';
String createdTime;

// ignore: must_be_immutable
class NewGame1 extends StatefulWidget {
  final String name, round;
  bool isTobeUpdated = false;
  NewGame1({
    this.name,
    this.round,
    this.isTobeUpdated,
  });
  @override
  _NewGame1State createState() => _NewGame1State(name, round, isTobeUpdated);
}

class _NewGame1State extends State<NewGame1> {
  int rand, tiePoint = 0, userPoint = 0, comPoint = 0, currentRound = 0;
  WidgetMarker selectedWidgetMarker = WidgetMarker.normal;
  bool isFABClickable = false, isStartClickable = true;
  bool enabledStone = false,
      enabledScissor = false,
      enabledPaper = false,
      enabledStart = true,
      isTobeUpdated;
  var onPressedStone, onPressedScissor, onPressedPaper, onPressedStart;
  String name2, result = 'Press Start', round;
  _NewGame1State(this.name2, this.round, this.isTobeUpdated);
  void buttonFunction() async {
    Duration seconds = Duration(seconds: 1);
    Future.delayed(seconds, () {
      setState(() {
        isFABClickable = true;
        enabledScissor = true;
        enabledStone = true;
        enabledPaper = true;
        if (currentRound < int.parse(round)) {
          currentRound++;
          rand = null;
          selectedWidgetMarker = WidgetMarker.normal;
        }
        print('round $currentRound finished');
        print('total_round $round');
        result = 'Round $currentRound';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (enabledStart) {
      onPressedStart = () {
        currentRound++;
        print('Round $currentRound');
        setState(() {
          enabledStart = false;
          onPressedStart = null;
          enabledStone = true;
          enabledScissor = true;
          enabledPaper = true;
          isFABClickable = true;
          isStartClickable = false;
          result = 'Round $currentRound';
        });
      };
    }
    if (enabledStone) {
      onPressedStone = () {
        rand = comChoice();
        setState(() {
          selectedWidgetMarker = WidgetMarker.stone;
          isFABClickable = false;
          enabledStone = false;
          onPressedStone = null;
          enabledScissor = false;
          onPressedScissor = null;
          enabledPaper = false;
          onPressedPaper = null;
        });
        showResults(rand, selectedWidgetMarker);
        buttonFunction();
        if (currentRound > int.parse(round) - 1) {
          isFABClickable = false;
          enabledStone = false;
          onPressedStone = null;
          currentRound = currentRound - 1;
          Duration seconds = Duration(seconds: 1);
          Future.delayed(seconds, () {
            if (userPoint > comPoint) {
              setState(() {
                acknowledgement(
                    context, winningImage, winningResult, winningMsg);
              });
            } else if (userPoint < comPoint) {
              setState(() {
                acknowledgement(
                    context, failureImage, failureResult, failureMsg);
              });
            } else
              setState(() {
                acknowledgement(context, tieImage, tieResult, tieMsg);
              });
          });
        }
      };
    }
    if (enabledScissor) {
      onPressedScissor = () {
        rand = comChoice();
        setState(() {
          selectedWidgetMarker = WidgetMarker.scissor;
          isFABClickable = false;
          enabledScissor = false;
          onPressedScissor = null;
          enabledPaper = false;
          onPressedPaper = null;
          enabledStone = false;
          onPressedStone = null;
        });
        showResults(rand, selectedWidgetMarker);
        buttonFunction();
        if (currentRound > int.parse(round) - 1) {
          isFABClickable = false;
          enabledStone = false;
          onPressedStone = null;
          currentRound = currentRound - 1;
          Duration seconds = Duration(seconds: 1);
          Future.delayed(seconds, () {
            if (userPoint > comPoint) {
              setState(() {
                acknowledgement(
                    context, winningImage, winningResult, winningMsg);
              });
            } else if (userPoint < comPoint) {
              setState(() {
                acknowledgement(
                    context, failureImage, failureResult, failureMsg);
              });
            } else
              setState(() {
                acknowledgement(context, tieImage, tieResult, tieMsg);
              });
          });
        }
      };
    }
    if (enabledPaper) {
      onPressedPaper = () {
        rand = comChoice();
        setState(() {
          selectedWidgetMarker = WidgetMarker.paper;
          isFABClickable = false;
          enabledPaper = false;
          onPressedPaper = null;
          enabledStone = false;
          onPressedStone = null;
          enabledScissor = false;
          onPressedScissor = null;
        });
        showResults(rand, selectedWidgetMarker);
        buttonFunction();
        if (currentRound > int.parse(round) - 1) {
          isFABClickable = false;
          enabledStone = false;
          onPressedStone = null;
          currentRound = currentRound - 1;
          Duration seconds = Duration(seconds: 1);
          Future.delayed(seconds, () {
            if (userPoint > comPoint) {
              setState(() {
                acknowledgement(
                    context, winningImage, winningResult, winningMsg);
              });
            } else if (userPoint < comPoint) {
              setState(() {
                acknowledgement(
                    context, failureImage, failureResult, failureMsg);
              });
            } else
              setState(() {
                acknowledgement(context, tieImage, tieResult, tieMsg);
              });
          });
        }
      };
    }
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    //double width = 220;
    //double height = 400;
    return WillPopScope(
      onWillPop: () {
        return showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Warning!!'),
            content: Text('You want to Quit?'),
            actions: <Widget>[
              TextButton(
                child: Text('NO'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                  child: Text('Yes'),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp()),
                        ModalRoute.withName("/Home"));
                  }),
            ],
          ),
        );
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.indigo, Colors.blue]),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  //SizedBox(height: height * 0.03,),
                  SizedBox(
                    height: height * 0.008,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Card(
                        elevation: 10.0,
                        color: null,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Container(
                          height: height * 0.05,
                          width: width * .29,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      'Effi:',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                  FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      '${winningPercent.toString()}%',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 10.0,
                        color: null,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Container(
                          height: height * 0.05,
                          width: width * .33,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      'Round:',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                  FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      '0$currentRound/0$round',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 10.0,
                        color: null,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Container(
                          height: height * 0.05,
                          width: width * .27,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10, top: 16, bottom: 15),
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Container(
                                      height: 7,
                                      width: 12,
                                      child: Image(
                                        image: AssetImage('asset/coins.png'),
                                      ),
                                    ),
                                  ),
                                  FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      '$points',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 8.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          top: 05.0,
                          bottom: 10.0,
                        ),
                        height: height * 0.24,
                        width: width * 0.25,
                        decoration: BoxDecoration(
                          color: null,
                        ),
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Colors.primaries[
                                    Random().nextInt(Colors.primaries.length)],
                                foregroundColor: Colors.white,
                                radius: 27.0,
                                child: Text(
                                  'C',
                                  style: TextStyle(
                                      //color: Colors.indigo,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),
                              ),
                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  'Computer',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                              Text(
                                comPoint.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: null,
                        ),
                        height: height * 0.24,
                        width: width * .5,
                        child: Card(
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Center(
                            child: Container(
                              child: getCustomContainerCom(),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: 5.0,
                        ),
                        height: height * 0.24,
                        width: width * 0.25,
                        decoration: BoxDecoration(
                          color: null,
                        ),
                        child: Column(
                          children: <Widget>[
                            FloatingActionButton(
                              child: Icon(Icons.save),
                              onPressed: () {},
                            ),
                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                'Save',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: height * 0.09,
                          width: width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.indigo, Colors.blue],
                            ),
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 13.0,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 3.0, color: Colors.indigo),
                                  color: Colors.yellow,
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                margin: EdgeInsets.only(left: 05.0),
                                child: Center(
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      result,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        //fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                              Container(
                                width: 13.0,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 3.0, color: Colors.blue),
                                  color: Colors.yellow,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 40.0),
                        height: height * 0.24,
                        width: width * 0.25,
                        decoration: BoxDecoration(
                          color: null,
                        ),
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Opacity(
                                opacity: isStartClickable ? 1.0 : 0.3,
                                child: FloatingActionButton(
                                    backgroundColor: Colors.green,
                                    child: Text('Start'),
                                    onPressed: onPressedStart),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: height * 0.24,
                        width: width * .5,
                        child: Card(
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Center(
                            child: Container(
                              child: getCustomContainer(),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: 10.0,
                          bottom: 5.0,
                        ),
                        height: height * 0.24,
                        width: width * 0.25,
                        decoration: BoxDecoration(
                          color: null,
                        ),
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Colors.primaries[
                                    Random().nextInt(Colors.primaries.length)],
                                foregroundColor: Colors.white,
                                radius: 27.0,
                                child: Text(
                                  name2[0].toUpperCase(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),
                              ),
                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  name2,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                              Text(
                                userPoint.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.005,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Opacity(
                        opacity: isFABClickable ? 1.0 : 0.2,
                        child: FloatingActionButton(
                            child: Image(
                              image: AssetImage('asset/stone.png'),
                            ),
                            onPressed: onPressedStone),
                      ),
                      SizedBox(
                        height: height * 0.11,
                        width: width * 0.1,
                      ),
                      Opacity(
                        opacity: isFABClickable ? 1.0 : 0.2,
                        child: FloatingActionButton(
                            child: Image(
                              image: AssetImage('asset/scissor.png'),
                            ),
                            onPressed: onPressedScissor),
                      ),
                      SizedBox(
                        height: height * 0.11,
                        width: width * 0.1,
                      ),
                      Opacity(
                        opacity: isFABClickable ? 1.0 : 0.2,
                        child: FloatingActionButton(
                            child: Image(
                              image: AssetImage('asset/paper.png'),
                            ),
                            onPressed: onPressedPaper),
                      ),
                    ],
                  ),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      'To choose, Use these buttons..',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
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

  int comChoice() {
    Random rand = new Random();
    //print(rand.nextInt(3));
    return rand.nextInt(3);
  }

  Widget getCustomContainerCom() {
    switch (rand) {
      case 0:
        print(rand);
        return getstoneContainerCom();
      case 1:
        print(rand);
        return getscissorContainerCom();
      case 2:
        print(rand);
        return getpaperContainerCom();
      default:
        return getContainerCom();
    }
  }

  Widget getContainerCom() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.33,
      width: width * 0.5,
      color: null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Computer'),
          Text('Choice'),
        ],
      ),
    );
  }

  Widget getstoneContainerCom() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.33,
      width: width * 0.5,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('asset/stone2.png'),
        ),
        color: null,
      ),
    );
  }

  Widget getscissorContainerCom() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.33,
      width: width * 0.8,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('asset/scissor2.png'),
        ),
        color: null,
      ),
    );
  }

  Widget getpaperContainerCom() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.33,
      width: width * 0.8,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('asset/paper2.png'),
        ),
        color: null,
      ),
    );
  }

  Widget getContaineruser() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.33,
      width: width * 0.5,
      color: null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Your'),
          Text('Choice'),
        ],
      ),
    );
  }

  Widget getCustomContainer() {
    switch (selectedWidgetMarker) {
      case WidgetMarker.stone:
        return getstoneContainer();
      case WidgetMarker.scissor:
        return getscissorContainer();
      case WidgetMarker.paper:
        return getpaperContainer();
      case WidgetMarker.normal:
        return getContaineruser();
    }
    return getContainerCom();
  }

  Widget getstoneContainer() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.33,
      width: width * 0.5,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('asset/stone1.png'),
        ),
        color: null,
      ),
    );
  }

  Widget getscissorContainer() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.33,
      width: width * 0.8,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('asset/scissor1.png'),
        ),
        color: null,
      ),
    );
  }

  Widget getpaperContainer() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.33,
      width: width * 0.8,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('asset/paper1.png'),
        ),
        color: null,
      ),
    );
  }

  void showResults(int rand, selectedWidgetMarker) {
    switch (selectedWidgetMarker) {
      case WidgetMarker.stone:
        if (rand == 0) {
          tiePoint = tiePoint + 1;
          result = 'Tie';
        } else if (rand == 1) {
          userPoint = userPoint + 1;
          result = 'You Win!!';
        } else {
          comPoint++;
          result = 'You Lose..';
        }
        break;
      case WidgetMarker.scissor:
        if (rand == 1) {
          tiePoint = tiePoint + 1;
          result = 'Tie';
        } else if (rand == 2) {
          userPoint = userPoint + 1;
          result = 'You Win!!';
        } else {
          comPoint++;
          result = 'You Lose..';
        }
        break;
      case WidgetMarker.paper:
        if (rand == 2) {
          tiePoint = tiePoint + 1;
          result = 'Tie';
        } else if (rand == 0) {
          userPoint = userPoint + 1;
          result = 'You Win!!';
        } else {
          comPoint++;
          result = 'You Lose..';
        }
        break;
    }
    print(result);
  }

  _save() async {
    Profile name = Profile();
    name.name = name2;
    name.userPoint = userPoint;
    name.comPoint = comPoint;
    name.tiePoint = tiePoint;
    name.overallRound = int.parse(round);
    winningPercent =
        double.parse((userPoint / int.parse(round) * 100.0).toStringAsFixed(2));
    print(winningPercent);
    name.winningPercent = winningPercent;
    points = (winningPercent * userPoint).round();
    print(points);
    name.points = points;
    name.rank = rank;
    createdTime = DateTime.now().toString().substring(0, 16);
    name.createdTime = createdTime;
    print(DateTime.now());
    name.updatedTime = DateTime.now().toString().substring(0, 16);
    DatabaseHelper helper = DatabaseHelper.instance;
    dataBase = await helper.insert(name);
    //print(isToBeUpdated);
    print('inserted ');
    print('dataase $dataBase');
    //initState();
  }

  _update() async {
    Profile name = Profile();
    //print(isToBeUpdated);
    DatabaseHelper helper = DatabaseHelper.instance;
    int id = await helper.search(name2);
    print('id in _update fun $id');
    Profile tempName = await helper.queryWord(id);
    print('userpoint $userPoint');
    print('newuserpoint ${tempName.userPoint}');
    name.name = name2;
    name.userPoint = userPoint + tempName.userPoint;
    print('userpoint ${name.userPoint}');
    name.comPoint = comPoint + tempName.comPoint;
    print(name.comPoint);
    name.tiePoint = tiePoint + tempName.tiePoint;
    print(name.tiePoint);
    name.overallRound = int.parse(round) + tempName.overallRound;
    print(name.overallRound);
    winningPercent = double.parse(((userPoint + tempName.userPoint) /
            (double.parse(round) + tempName.overallRound) *
            100.0)
        .toStringAsFixed(2));
    print(winningPercent);
    name.winningPercent = winningPercent;
    points = (winningPercent * (userPoint + tempName.userPoint)).round();
    name.points = points;
    print('points ${name.points}');
    name.createdTime = createdTime;
    name.updatedTime = DateTime.now().toString().substring(0, 16);
    dataBase = await helper.update(name, id);
    //print('id $result');
    //initState();
  }

  acknowledgement(BuildContext context, String img, String res, String msg) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (isTobeUpdated == true)
      _update();
    else
      _save();
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                  ModalRoute.withName("/Home"));
              return null;
            },
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                height: 430,
                width: width,
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        height: 130,
                        child: Image.asset(img),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Text(
                              res,
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink,
                              ),
                            ),
                            Text(
                              name2,
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            Text(
                              msg,
                              style: TextStyle(
                                fontSize: 21.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 10,
                        thickness: 2,
                        color: Colors.teal,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
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
                                    text: round,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Your points : ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: userPoint.toString(),
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Computer points : ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: comPoint.toString(),
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Draw : ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: tiePoint.toString(),
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
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              print(isTobeUpdated);
                              //print('User list $User');
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyApp()),
                                  ModalRoute.withName("/Home"));
                            },
                            child: Text('Okay'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

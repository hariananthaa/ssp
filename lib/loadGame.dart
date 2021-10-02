import 'package:flutter/material.dart';
import 'User_info.dart';
import 'NewGame.dart';
import 'dart:math';
import 'database_helpers.dart';
import 'main.dart';

String name1, score1;
bool updated = true;
int index1;
int userIndex;
bool _isSelected = false;
List<int> _selectedProfile = <int>[];

class LoadGame extends StatefulWidget {
  @override
  _LoadGameState createState() => _LoadGameState();
}

read() async {
  DatabaseHelper helper = DatabaseHelper.instance;
  List sortedData = await helper.sort();
  List unsortedData = await helper.data();
  print(sortedData);
  print(unsortedData);
  dataBase = [sortedData, unsortedData];
  if (dataBase != null) {
    names.clear();
    for (int i = 0; i < dataBase[1].length; i++) {
      names.add(dataBase[1][i]['name']);
    }
  }
  count = names.length;
  print('names $names');
  //print('count $count');
}

class _LoadGameState extends State<LoadGame> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    //double width = 250;
    if (names.isEmpty) {
      setState(() {
        count = 1;
      });
    }
    customAppbar() {
      return PreferredSize(
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.indigo, Colors.blue]),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'LoadGame',
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                getDeleteIcon(),
              ],
            ),
          ),
          preferredSize: Size.fromHeight(80));
    }

    return WillPopScope(
      onWillPop: () {
        setState(() {
          if (_isSelected == true) {
            _isSelected = false;
            _selectedProfile.clear();
          }
        });
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
              itemCount: count,
              itemExtent: 75,
              itemBuilder: (context, index) {
                userIndex = index;
                //print('index of user $index');
                if (names.isEmpty) {
                  print('database is empty');
                  return Container(
                    alignment: Alignment.center,
                    child: Center(
                      child: Text(
                        'No profile',
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
                      if (_selectedProfile.contains(index)) {
                        setState(() {
                          _isSelected = false;
                          _selectedProfile.removeWhere((val) => val == index);
                        });
                      } else if (_isSelected != true) {
                        getRound(context, index);
                      }
                    },
                    onLongPress: () {
                      print(index);
                      if (!_selectedProfile.contains(index)) {
                        setState(() {
                          index1 = index;
                          _isSelected = true;
                          _selectedProfile.add(index);
                        });
                      }
                    },
                    child: Card(
                      color: (_selectedProfile.contains(index))
                          ? Colors.lightBlueAccent.withOpacity(1)
                          : null,
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
                                names[index][0],
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            width: width * 0.62,
                            child: Text(
                              names[index],
                              style: TextStyle(
                                fontSize: 23,
                              ),
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.info_outline,
                                    size: 35.0,
                                    color: Colors.black54,
                                  ),
                                  onPressed: () {
                                    print('ind $index');
                                    setState(() {
                                      userIndex = index;
                                    });
                                    print(userIndex);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UserInfo(
                                                index: userIndex,
                                                userInfo: dataBase[1],
                                              )),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                        ],
                      ),
                    ),
                  );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<String> getRound(BuildContext context, index) {
    final _formKey = GlobalKey<FormState>();
    dynamic autovalidate = AutovalidateMode.onUserInteraction;
    var round1;
    final roundController = new TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'PROFILE',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                          color: Colors.pink,
                          decoration: TextDecoration.underline,
                          decorationThickness: 2,
                          decorationColor: Colors.indigo,
                        ),
                      ),
                      TextFormField(
                          autovalidateMode: autovalidate,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Total Round',
                          ),
                          controller: roundController,
                          validator: (value) {
                            if (value.isEmpty || value == null) {
                              return 'Required';
                            } else if (value.length > 2) {
                              return 'Must between 1 to 99';
                            } else if (value == '0') {
                              return 'Must be greater than zero';
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextButton(
                            onPressed: () {
                              autovalidate = AutovalidateMode.always;
                              if (_formKey.currentState.validate()) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NewGame1(
                                              name: dataBase[1][index]['name'],
                                              round: round1,
                                              isTobeUpdated: updated,
                                            )),
                                    ModalRoute.withName("/Home"));
                              }
                              round1 = roundController.text;
                            },
                            //elevation: 5.0,
                            child: Text("Submit"),
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

  Widget getDeleteIcon() {
    if (_isSelected == true)
      return deleteIcon(index1);
    else
      return Container();
  }

  delFunction(int id) async {
    print(id);
    DatabaseHelper helper = DatabaseHelper.instance;
    int res = await helper.delete(id);
    setState(() {
      read();
      count--;
      names.removeAt(index1);
      _isSelected = false;
      _selectedProfile.removeWhere((val) => val == index1);
    });
    print(res);
    //print(user);
    print('deleted id $id');
  }

  Widget deleteIcon(index1) {
    return IconButton(
      icon: Icon(
        Icons.delete,
        color: Colors.white,
        size: 30,
      ),
      onPressed: () {
        print('index $index1');
        int id = dataBase[1][index1]['_id'];
        delFunction(id);
        print('deleted');
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'NewGame.dart';
import 'database_helpers.dart';

Future<String> userNameDialog(BuildContext context) {
  final _formKey = GlobalKey<FormState>();
  dynamic autovalidate = AutovalidateMode.onUserInteraction;
  var name1;
  var round1;
  final nameController = new TextEditingController();
  final roundController = new TextEditingController();
  int count = 0;
  List users = [];
  Profile user;

  void _search() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    count = await helper.getCount();
    int idcount = 1;
    int i = 1;
    while (idcount <= count) {
      user = await helper.queryWord(i);
      if (user != null) {
        users.add(user.name);
      }
      i++;
    }
    print(user);
  }

  return showDialog(
      context: context,
      builder: (context) {
        _search();
        return WillPopScope(
          onWillPop: () {
            DateTime currentBackPressTime;
            DateTime now = DateTime.now();
            if (currentBackPressTime == null ||
                now.difference(currentBackPressTime) > Duration(seconds: 2)) {
              currentBackPressTime = now;
              Navigator.pop(context);
            }
            return Future.value(true);
          },
          child: Dialog(
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
                          decoration: InputDecoration(
                            labelText: 'Username',
                          ),
                          controller: nameController,
                          validator: (value) {
                            _search();
                            for (int i = 0; i < users.length; i++) {
                              if (value == users[i]) {
                                return 'Already exist.Try new';
                              }
                            }
                            if (value.isEmpty || value == null) {
                              return 'Required';
                            } else if (value.length > 10) {
                              return 'Maxi 10 character only.';
                            } else
                              return null;
                          }),
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
                                            name: name1, round: round1)),
                                    ModalRoute.withName("/Home"));
                              }
                              name1 = nameController.text;
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
          ),
        );
      });
}

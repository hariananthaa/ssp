import 'package:flutter/material.dart';

class GameDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    //double width = 250;

    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop();
        return;
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                //height: height-topPadding-bottomPadding,
                width: width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FittedBox(
                      fit: BoxFit.fill,
                      child: Container(
                        //width: 200,
                        child: Column(
                          children: <Widget>[
                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                'Welcome to SSP',
                                //textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo),
                              ),
                            ),
                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                '(Stone Scissor Paper)',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.blue),
                                softWrap: false,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      height: 2,
                      thickness: 2,
                      indent: 5,
                      endIndent: 5,
                      color: Colors.black45,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FittedBox(
                      fit: BoxFit.fill,
                      child: Container(
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Text(
                            'Game Details',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    FittedBox(
                      fit: BoxFit.fill,
                      child: Container(
                        width: width,
                        alignment: Alignment.centerLeft,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Text(
                            'Efficiency:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Text(
                            '     Efficiency is generally calculated as the ratio of input and output. '
                            'Like wise here, it is defined as the ratio of number of rounds you win & number of total rounds.'
                            ' It is denoted as percentage.',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                            maxLines: 10,
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FittedBox(
                      fit: BoxFit.fill,
                      child: Container(
                        width: width,
                        alignment: Alignment.centerLeft,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Text(
                            'Points:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Text(
                            '     In this game, Ranking is based on points only.'
                            ' Here, Points are calculated not only based on efficiency, but also based on number of rounds you win.'
                            '',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                            maxLines: 10,
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Text(
                            '     So, in order to increase your rank, you must have high efficiency & high number of wining.',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.justify,
                            maxLines: 5,
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FittedBox(
                      fit: BoxFit.fill,
                      child: Container(
                        width: width,
                        alignment: Alignment.centerLeft,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Text(
                            'Note:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Text(
                            '     You can create more number of profiles according to your wish.',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.justify,
                            maxLines: 10,
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Text(
                            '     You can delete the profile. Just longpress your profile in load game section, then delete the profile.',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.justify,
                            maxLines: 5,
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

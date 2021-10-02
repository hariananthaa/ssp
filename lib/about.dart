import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
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
                            child: Text('Welcome to SSP',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo
                              ),
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text('(Stone Scissor Paper)',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue
                              ),
                              softWrap:false,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Divider(height: 2,thickness: 2,indent: 5,endIndent: 5,color: Colors.black45,),
                  SizedBox(height:10,),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

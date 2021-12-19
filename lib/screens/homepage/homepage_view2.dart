import 'package:flutter/material.dart';
import 'package:flutter_app/utils/styles.dart';
import 'package:flutter_app/utils/utils.dart';

class HomepageView2 extends StatefulWidget {
  HomepageView2({Key? key}) : super(key: key);

  @override
  _HomepageView2State createState() => _HomepageView2State();
}

class _HomepageView2State extends State<HomepageView2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          'View 2'.h1(),
          'H1 hello'.h1(),
          'H2 hic hic'.h2(),
          'H3 ha ha'.h3(),
          'H4 is here'.h4(),
          'H5 Olala'.h5(),
          'H6 Alolo'.h6(),
          'Body text'.body(),
          'Caption text'.caption(),
          ElevatedButton(
            onPressed: () {
              alert(msg: 'Hello world....');
            },
            child: 'Show sample flush bar'.body(),
          ),
          ElevatedButton(
            onPressed: () {
              alert(msg: 'Hello Flutter', color: Colors.green.shade300, backgroundColor: Colors.green.shade900);
            },
            child: 'Another sample flush bar'.body(),
          ),
        ],
      ),
    );
  }
}

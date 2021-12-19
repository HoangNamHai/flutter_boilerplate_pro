import 'package:flutter/material.dart';
import 'package:flutter_app/utils/custom_printer.dart';
import 'package:flutter_app/utils/styles.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: CustomPrinter('HomePageScreen'),
);

String md = '''
## Emphasis

**This is bold text**

__This is bold text__

*This is italic text*

_This is italic text_

~~Strikethrough~~


## Blockquotes


> Blockquotes can also be nested...
>> ...by using additional greater-than signs right next to each other...
> > > ...or with spaces between arrows.


## Lists

Unordered

+ Create a list by starting a line with `+`, `-`, or `*`
+ Sub-lists are made by indenting 2 spaces:
  - Marker character change forces new list start:
    * Ac tristique libero volutpat at
    + Facilisis in pretium nisl aliquet
    - Nulla volutpat aliquam velit
+ Very easy!

''';

class HomePageScreen extends StatefulWidget {
  static String tag = '/homepage';

  HomePageScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    logger.v("Verbose log");
    logger.d("Debug log");
    logger.i("Info log");
    logger.w("Warning log");
    logger.e("Error log");
    logger.wtf("What a terrible failure log");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // md.markdown(),
              'H1 ở đây'.h1(),
              'H2 ở kia'.h2(),
              'H3 ở đó'.h3(),
              'H4 is here'.h4(),
              'H5 Olala'.h5(),
              'H6 Alolo'.h6(),
              'Body text'.body(),
              'Caption text'.caption(),
              'You have pushed the button this many times:'.body(),
              '$_counter'.h1(),
              // Text(
              //   '$_counter',
              //   style: Theme.of(context).textTheme.headline4,
              // ),
              ElevatedButton(
                onPressed: () {
                  alert(msg: 'Hello world....');
                },
                child: Text('Show sample flush bar'),
              ),
              ElevatedButton(
                onPressed: () {
                  alert(msg: 'Hello Flutter', color: Colors.green.shade300, backgroundColor: Colors.green.shade900);
                },
                child: Text('Another sample flush bar'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app/utils/custom_printer.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: CustomPrinter('HomePageScreen'),
);

class HomePageScreen extends StatefulWidget {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
              onPressed: () {
                alert(msg: 'Hello world....');
              },
              child: Text('Show sample flush bar'),
            ),
            ElevatedButton(
              onPressed: () {
                alert(
                    msg: 'Hello Flutter',
                    color: Colors.green.shade300,
                    backgroundColor: Colors.green.shade900);
              },
              child: Text('Another sample flush bar'),
            ),
          ],
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
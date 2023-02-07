import 'package:flutter/material.dart';
import 'package:flutter_app/utils/styles.dart';

const String md = '''
## Emphasis v6

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

class HomepageView1 extends StatefulWidget {
  HomepageView1({Key? key}) : super(key: key);

  @override
  _HomepageView1State createState() => _HomepageView1State();
}

class _HomepageView1State extends State<HomepageView1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: md.markdown(),
    );
  }
}

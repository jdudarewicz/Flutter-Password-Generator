import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './utils/PasswordGenerator.dart';


///Stateful class for homepage widget, intializing with the [title] of the application
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  State<StatefulWidget> createState() => new MyHomePageState();
}

///The homepage state
///
///Password generation is achieved through PasswordGenerator class
///[_letterCheckBool] initialized to true as to be activated upon startup of application,
///[_sliderVal] sets the sliders initial value to 6.0 as it ranges from 6-64 integer generation
class MyHomePageState extends State<MyHomePage> {
  PasswordGenerator _generator = new PasswordGenerator();
  bool _letterCheckBool = true;
  bool _numCheckBool = false;
  bool _symCheckBool = false;
  double _sliderVal = 6.0;
  final GlobalKey<ScaffoldState> _scaffoldState = new GlobalKey<ScaffoldState>();

  ///call to generate new slider value
  void generate() {
    setState(() {
      _generator.generate(_sliderVal.round());
    });
  }

  ///call to activate letter generation and change [_letterCheckBool] value
  void letterCheck(bool value) {
    setState((){
      _generator.checkLetterGen(value);
      _letterCheckBool = value;
    });
  }

  ///call to activate number generation and change [_numCheckBool] value
  void numCheck(bool value) {
    setState(() {
      _generator.checkNumGen(value);
      _numCheckBool = value;
    });
  }

  ///call to activate symbol generation and change [_symCheckBool] value
  void symCheck(bool value) {
    setState(() {
      _generator.checkSymGen(value);
      _symCheckBool = value;
    });
  }

  ///call to change the sliders diplayed value to [_sliderVal]
  void sliderChange(double value) {
    setState(() {
      _sliderVal = value;     
    });
  }

  ///Builds the homepage widget
  @override
  Widget build(BuildContext context) {
   return new Scaffold(
     key: _scaffoldState,
     appBar: new AppBar(
       title: new Text(widget.title),
       actions: <Widget>[
         new IconButton(
           icon: new Icon(Icons.assignment),
           tooltip: "Copy",
           onPressed: () {
             _scaffoldState.currentState.showSnackBar(
                new SnackBar(
                  content: new Text("Copied to Clipboard"),
                ),
              );
              Clipboard.setData(new ClipboardData(text: _generator.getGeneratedValue()));
           },
         ),
       ],
     ),
     body: new Column(
       mainAxisAlignment: MainAxisAlignment.center,
       crossAxisAlignment: CrossAxisAlignment.stretch,
       mainAxisSize: MainAxisSize.max,
       children: <Widget>[
         new Expanded(
           child: new Center(
             child: new Text(
               _generator.getGeneratedValue(),
               textAlign: TextAlign.center,
               style: new TextStyle(
                 color: Colors.black54,
                 fontSize: 25.0,
               ),
             ),
           ),
         ),
         new Container(
           child: new RaisedButton(
             onPressed: generate,
             child: new Text("Generate"),
             ),
         ),
         new Column(
           children: <Widget>[
             new CheckboxListTile(
               title: new Text("Use letters"),
               value: _letterCheckBool,
               onChanged: (bool value){letterCheck(value);},
             ),
             new CheckboxListTile(
               title: new Text("Use numbers"),
               value: _numCheckBool,
               onChanged: (bool value){numCheck(value);},
             ),
             new CheckboxListTile(
               title: new Text("Use symbols"),
               value: _symCheckBool,
               onChanged: (bool value){symCheck(value);},
             ),
           ],
         ),
        new Row(
          children: <Widget>[
            new Expanded(
              child: new Slider(
                value: _sliderVal,
                onChanged: (double value){sliderChange(value);},
                label: "Number of characters",
                divisions: 64,
                min: 6.0,
                max: 64.0,
              ),
            ),
            new Container(
              width: 50.0,
              child: new Text(
                _sliderVal.round().toString(),
                textAlign: TextAlign.center,
              ),
            )
          ],
        )
       ],
     ),
   );
  }
}
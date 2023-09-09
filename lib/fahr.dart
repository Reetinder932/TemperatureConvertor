import 'package:flutter/material.dart';
import 'package:flutter/services.dart';




class MyHome extends StatefulWidget {
  MyHome({Key? key, required this.title}) : super(key: key);
  final String title;


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHome> {
  TextEditingController _ctrlCelsius = TextEditingController();
  TextEditingController _ctrlfahr = TextEditingController();
  var msgResult = '';

  FahrenheitToCelcius() {
    double? _celsius = double.tryParse(_ctrlCelsius.text);
    double? _fahr = double.tryParse(_ctrlfahr.text);
    if (_fahr == null) {
      setState(() {
        msgResult = 'Value is null. Type the temperature using fahrenheit';
      });
    } else {
      double _celcius1 = (_fahr-32)*5/9;
      var _celcius2=_celcius1.toStringAsFixed(1);
      setState(() {
        msgResult = '$_fahr ºF = $_celcius2 ºC  ';
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      });
    }
  }

  reset() {
    setState(() {
      msgResult = '';
      _ctrlfahr.clear();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  msgResult,
                  textAlign: TextAlign.center,
                ),
                TextField(
                  controller: _ctrlfahr,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,

                  decoration: InputDecoration(
                    labelText: 'Type the temperature in Fahrenheit',
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        FahrenheitToCelcius();
                      },
                      style: ElevatedButton.styleFrom(
                        // color: const Color(0xFF136207),
                      ),
                      child: Text('Convert',
                          style: TextStyle(color: Color(0xFFFFFFFF))),
                    ),
                    SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        reset();
                      },
                      child: Text('Reset'),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
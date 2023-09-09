// import 'dart:ffi';
//
// import 'package:flutter/material.dart';
// class home extends StatefulWidget {
//   const home({super.key});
//
//   @override
//   State<home> createState() => _homeState();
// }
//
// class _homeState extends State<home> {
//   TextEditingController textcontroller=TextEditingController();
//
//   double input1=0.0;
//   double output=0.0;
//   int input2=0;
//
//
//
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: Text("Temperture Convertor"),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             TextField (
//               // controller: textcontroller ,
//               keyboardType: TextInputType.number,
//
//               onChanged: (input2){
//                 try{
//                   input1=double.parse(input2);
//
//                 }catch(e){
//                   input1=0.0;
//                 }
//               },
//               // LevelEventCreate(price: double.parse(textcontroller.text)),
//
//
//               // controller: textcontroller,
//               style: TextStyle(
//                 color: Colors.white,
//
//         ),
//
//                 decoration: InputDecoration(
//                     hintStyle: TextStyle(color: Colors.white,fontSize: 20),
//                     hintText: "Enter Temperature",
//                     border: OutlineInputBorder(
//                     // borderSide: BorderSide.none,
//                     borderRadius: BorderRadius.circular(50)
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 40,
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.white,
//                 shape: BeveledRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(3))
//                 )
//               ),
//                 onPressed: (){
//                   // input2=textcontroller.text as int;
//                   output=(input1-32)*5/9;
//                 }, child: Text("Convert to Celcius")),
//             SizedBox(
//               height: 20,
//             ),
//             ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     shape: BeveledRectangleBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(3))
//                     )
//                 ),
//                 onPressed: (){
//                   output=(input1*9/5)+32;
//
//                   }, child: Text("Convert to Fahrenheit")),
//          Text($output ,style: TextStyle(color: Colors.white),),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:temperatorconvertor/fahr.dart';




class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _ctrlCelsius = TextEditingController();

  var msgResult = '';

  celsiusToFahrenheit() {
    double? _celsius = double.tryParse(_ctrlCelsius.text);

    if (_celsius == null) {
      setState(() {
        msgResult = 'Value is null. Type the temperature using Celsius';
      });
    } else {
      var _fahrenheit = (9 / 5) * _celsius + 32;
      setState(() {
        msgResult = '$_celsius ºC = $_fahrenheit ºF';
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      });
    }
  }

  reset() {
    setState(() {
      msgResult = '';
      // SystemChannels.textInput.invokeMethod('TextInput.hide');
      _ctrlCelsius.clear();
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
                  controller: _ctrlCelsius,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelText: 'Type the temperature in Celsius',
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        celsiusToFahrenheit();
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
                    ),

                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(

                    padding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHome(title: 'Fahrenheit to Celsius',)));
                  }
                  ,
                  child: Text('Convert to Celsius'),
                )
              ],
            ),
          ),
        ));
  }
}
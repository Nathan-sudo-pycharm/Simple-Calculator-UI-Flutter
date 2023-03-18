import 'package:flutter/material.dart';
import 'button.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:line_icons/line_icons.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, // to remove the DEBUG banner from the output console.
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var userques = '';
  var userans = '';
  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    '00',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topRight,
            colors: [
              //sunset Color.fromARGB(255, 135, 36, 36), // black
              // Color.fromARGB(255, 218, 197, 41)
              Color.fromARGB(255, 21, 21, 21), // black
              Color.fromARGB(255, 22, 152, 221)
              // Color.fromARGB(255, 154, 154, 179),
              // Color(0xFF212121), // black
              // Color.fromARGB(255, 49, 49, 49), // grey
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
                child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: EdgeInsets.all(30),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userques,
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userans,
                      style: TextStyle(fontSize: 30, fontFamily: 'Nunito'),
                    ),
                  ),
                ],
              ),
            )),
            Expanded(
              flex: 2,
              child: Container(
                child: Center(
                  child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) //clear button C
                      {
                        return MyButton(
                            ontap: () {
                              setState(
                                () {
                                  userques = '';
                                },
                              );
                            },
                            btext: buttons[index],
                            color: Color.fromARGB(255, 240, 105, 28), // black
                            tcolor // white
                                : Color.fromARGB(255, 19, 19, 19),
                            anscolor: Color.fromARGB(255, 16, 16, 16));
                      } else if (index == 1) //delete button
                      {
                        return MyButton(
                          ontap: () {
                            setState(() {
                              userques =
                                  userques.substring(0, userques.length - 1);
                            });
                          },
                          btext: buttons[index],
                          color: Color.fromARGB(255, 244, 10, 10), // black
                          tcolor // white
                              : Color.fromARGB(255, 37, 36, 36),
                          anscolor: Color(0xFFFAFAFA),
                        );
                      }
                      //Equals to button
                      else if (index == buttons.length - 1) {
                        return MyButton(
                          ontap: () {
                            setState(() {
                              equalpress();
                            });
                          },
                          btext: buttons[index],
                          color: Color.fromARGB(255, 14, 197, 32),
                          tcolor: Color.fromARGB(255, 7, 7, 7),
                          anscolor: Color(0xFFFAFAFA),
                        );
                      } else {
                        return MyButton(
                          ontap: () {
                            setState(() {
                              userques += buttons[
                                  index]; //wht ever the user ques was  will be replaced by button[index]
                            });
                          },
                          btext: buttons[index],
                          color: isOperator(buttons[index])
                              ? Color.fromRGBO(215, 204, 211, 0.988)
                              : Color.fromARGB(255, 49, 49, 49), // black
                          tcolor: isOperator(buttons[index])
                              ? Color.fromARGB(255, 0, 0, 0) // white
                              : Color(0xFFFAFAFA),
                          //  tstyle: Text(', style: TextStyle(fontSize: 10)),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' ||
        x == '-' ||
        x == '+' ||
        x == '*' ||
        //  x == '.' ||
        x == '=' ||
        //  x == 'ANS' ||
        x == 'x' ||
        x == '/' ||
        x == 'Sqrt') {
      return true;
    }
    return false;
  }

  void equalpress() {
    String finalques = userques;
    finalques = finalques.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalques);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userans = eval.toString();
  }
}

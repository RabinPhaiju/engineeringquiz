import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:engineeringquiz/homepage.dart';
import 'package:engineeringquiz/resultpage.dart';

// ignore: must_be_immutable
class GetJson extends StatelessWidget {
  final langName;
  final image;
  GetJson({Key key, this.langName, this.image}) : super(key: key);
  String assetToLoad;

  setAsset() {
    assetToLoad = "assets/$langName.json";
  }

  @override
  Widget build(BuildContext context) {
    setAsset();
    return FutureBuilder(
      future:
      DefaultAssetBundle.of(context).loadString(assetToLoad, cache: true),
      builder: (context, snapshot) {
        List myData = json.decode(snapshot.data.toString());
        if (myData == null) {
          return Scaffold(
            body: Center(
              child: Text("Loading",),
            ),
          );
        } else {
          return QuizPage(myData: myData,appName:langName);
        }
      },
    );
  }
}

class QuizPage extends StatefulWidget {
  final myData;
  final appName;

  QuizPage({Key key, @required this.myData,this.appName}) : super(key: key);
  @override
  _QuizPageState createState() => _QuizPageState(myData,appName);
}

class _QuizPageState extends State<QuizPage> {
  var myData;
  String appName;
  _QuizPageState(this.myData, this.appName);

  Color colorToShow = Colors.indigoAccent;
  Color right = Colors.green;
  Color wrong = Colors.red;
  int marks = 0;
  int i = 1;
  bool pressed=false;
  int timer = 20;
  String showTimer = "20";
  var randomArray;

  Map<String, Color> btnColor = {
    "a": Colors.indigoAccent,
    "b": Colors.indigoAccent,
    "c": Colors.indigoAccent,
    "d": Colors.indigoAccent,
  };
  bool cancelTimer = false;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void startTimer() async {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer t) {
      setState(() {
        if (timer < 1) {
          t.cancel();
          if(pressed) {
            nextQuestion();
          }
        } else if (cancelTimer == true) {
          t.cancel();
        } else {
          timer = timer - 1;
        }
        showTimer = timer.toString();
      });
    });
  }

  void nextQuestion() {
    pressed=false;
    cancelTimer = false;
    timer = 20;
    setState(() {
      if (i<myData[0].length) {
          i++;
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ResultPage(marks: marks,total:myData[0].length),
        ));
      }
      btnColor["a"] = Colors.indigoAccent;
      btnColor["b"] = Colors.indigoAccent;
      btnColor["c"] = Colors.indigoAccent;
      btnColor["d"] = Colors.indigoAccent;
    });
    startTimer();

  }

  void checkAnswer(String k) {
    if (myData[2][i.toString()] == myData[1][i.toString()][k]) {
      marks = marks + 1;
      colorToShow = right;
    } else {
      colorToShow = wrong;
    }
    setState(() {
      btnColor[k] = colorToShow;
      if(colorToShow==wrong){
        if(myData[2][i.toString()]==myData[1][i.toString()]['a']){
          btnColor['a']=right;
        }else if(myData[2][i.toString()]==myData[1][i.toString()]['b']){
          btnColor['b']=right;
        }else if(myData[2][i.toString()]==myData[1][i.toString()]['c']){
          btnColor['c']=right;
        }else if(myData[2][i.toString()]==myData[1][i.toString()]['d']){
          btnColor['d']=right;
        }
      }
      cancelTimer = true;
      pressed=true;
    });

    // changed timer duration to 1 second
    Timer(Duration(milliseconds: 1500), nextQuestion);
  }

  Widget choiceButton(String k) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: MaterialButton(
        onPressed: () => pressed?null:checkAnswer(k),
        child: Text(myData[1][i.toString()][k], style: TextStyle(color: Colors.white, fontFamily: "Quando", fontSize: 20.0,), maxLines: 1,),
        color: btnColor[k],
        splashColor: Colors.indigo[700],
        highlightColor: Colors.indigo[700],
        minWidth: 220.0,
        height: 55.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return WillPopScope(
      onWillPop: ()async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(appName+" "+i.toString()+' ('+ myData[0].length.toString()+")",style: TextStyle(fontFamily: 'Quando',fontWeight: FontWeight.bold,fontSize: 20),),
          actions: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
            IconButton(icon:Icon(Icons.cancel),onPressed:(){Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage(),));
            },)
          ],
        ),
          body: Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.center,
                  child: Text(myData[0][i.toString()], style: TextStyle(fontSize: 18.0, fontFamily: "Quando",)),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      choiceButton('a'),
                      choiceButton('b'),
                      choiceButton('c'),
                      choiceButton('d'),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Center(
                    child: Text(showTimer, style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w700, fontFamily: 'Times New Roman',)),
                  ),
                ),
              ),
            ],
          ),


      ),
    );
  }
}

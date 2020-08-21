import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:engineeringquiz/homepage.dart';
import 'package:engineeringquiz/resultpage.dart';

// ignore: must_be_immutable
class GetJsonNew extends StatelessWidget {
  final langName;
  final image;
  GetJsonNew({Key key, this.langName, this.image}) : super(key: key);
  String assetToLoad;

  setAsset(){
    assetToLoad = "assets/${langName.split(' ').join('').replaceAll('\n','')}.json";
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
          return WillPopScope(
            onWillPop: ()async => false,
            child: Scaffold(
              appBar: AppBar(
                title: Text(langName,style: TextStyle(fontFamily: 'Quando',fontWeight: FontWeight.bold,fontSize: 16),),
                actions: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  IconButton(icon:Icon(Icons.cancel),onPressed:(){Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage(),));
                  },)
                ],
              ),
              body: Center(
                child: Container(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          );
        } else {
          return QuizPage(myData: myData,appName:langName,title:image);
        }
      },
    );
  }
}

class QuizPage extends StatefulWidget {
  final myData;
  final appName;
  final title;

  QuizPage({Key key, @required this.myData,this.appName, this.title}) : super(key: key);
  @override
  _QuizPageState createState() => _QuizPageState(myData,appName,title);
}

class _QuizPageState extends State<QuizPage> {
  final myData;
  final appName;
  final title;
  _QuizPageState(this.myData, this.appName, this.title);

  Color colorToShow = Colors.indigoAccent;
  Color right = Colors.green;
  Color wrong = Colors.red;
  int marks = 0;
  int i = 0;
  bool pressed=false;
  int timer = 30;
  String showTimer = "30";
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
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t) {
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
    timer = 30;
    setState(() {
      if (i<myData.length-1) {
        i++;
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ResultPage(marks: marks,total:myData.length),
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
    if (myData[i]['answer'] == myData[i][k]) {
      marks = marks + 1;
      colorToShow = right;
    } else {
      colorToShow = wrong;
    }
    setState(() {
      btnColor[k] = colorToShow;
      if(colorToShow==wrong){
        if(myData[i]['answer']==myData[i]['a']){
          btnColor['a']=right;
        }else if(myData[i]['answer']==myData[i]['b']){
          btnColor['b']=right;
        }else if(myData[i]['answer']==myData[i]['c']){
          btnColor['c']=right;
        }else if(myData[i]['answer']==myData[i]['d']){
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
        vertical: 5.0,
        horizontal: 10.0,
      ),
      child: MaterialButton(

        onPressed: () => pressed?null:checkAnswer(k),

        child: Text(myData[i][k], style: TextStyle(color: Colors.white, fontFamily: "Quando", fontSize: 16.0,)),
        color: btnColor[k],
        splashColor: Colors.indigo[700],
        highlightColor: Colors.indigo[700],
        minWidth: 220.0,
        height: 45.0,
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
          title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
              child: Text(appName+'['+ myData.length.toString()+"]",style: TextStyle(fontFamily: 'Quando',fontWeight: FontWeight.bold,fontSize: 16),)),
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
                flex: title=='images/CProgramming.png'?50:40,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/pattern.png"), fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop)),
                    ),
                    padding: EdgeInsets.only(left: 20,right: 20),
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                        child:myData[i]['question'].contains('.png')?
                        Column(
                          children: <Widget>[
                            Image(image:AssetImage('files/'+myData[i]['question'].split('.png')[0]+'.png',),height: 150),
                            Text((i+1).toString()+'. '+myData[i]['question'].split('.png')[1]),
                          ],
                        ):
                        myData[i]['question'].contains('.jpg')?
                        Column(
                          children: <Widget>[
                            Image(image:AssetImage('files/'+myData[i]['question'].split('.jpg')[0]+'.jpg'),height: 150,),
                            Text((i+1).toString()+'. '+myData[i]['question'].split('.jpg')[1]),
                          ],
                        ):
                        myData[i]['question'].contains('.gif')?
                            Column(
                              children: <Widget>[
                                Image(image:AssetImage('files/'+myData[i]['question'].split('.gif')[0]+'.gif'),height: 150,),
                                Text((i+1).toString()+'. '+myData[i]['question'].split('.gif')[1]),
                              ],
                            ) :
                        Text(
                            (i+1).toString()+". "+myData[i]['question'],
                            style: TextStyle(fontSize: title=='images/CProgramming.png'?14:16.0,fontWeight: FontWeight.bold ,fontFamily: "Quando",)
                        )
                    ),
                  ),
              ),
              Expanded(
                flex: title=='images/CProgramming.png'?45:50,
                child: Container(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(height: 5,),
                        if(myData[i]['a']!='')
                          choiceButton('a'),

                        if(myData[i]['b']!='')
                          choiceButton('b'),

                        if(myData[i]['c']!='')
                          choiceButton('c'),

                        if(myData[i]['d']!='')
                          choiceButton('d'),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: title=='images/CProgramming.png'?5:10,
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Center(
                    child: Text(showTimer, style: TextStyle(fontSize: title=='images/CProgramming.png'?20:30.0, fontWeight: FontWeight.bold, fontFamily: 'Times New Roman',)),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}

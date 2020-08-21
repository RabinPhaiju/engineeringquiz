import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:engineeringquiz/pages/about.dart';
import 'package:engineeringquiz/pages/childpage.dart';
import 'package:engineeringquiz/pages/list.dart';
import 'datasource.dart';
import 'newquizpage.dart';
class Constants {
//  static const String Settings = 'Settings';
  static const String About = 'About';

  static const List<String> choices = <String>[ About];
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Widget customCard(String langName){
    var langName1 = langName.split(' ').join('');

    String image = 'images/${langName1.replaceAll('\n','')}'+'.png';

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 10.0,
      ),
      child: InkWell(
        onTap: (){Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => GetJsonNew(langName:langName,image:image),));},
        child: Material(
          color: primaryColor,
          elevation: 10.0,
          borderRadius: BorderRadius.circular(25.0),
          child: Container(
            child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(width: 10,),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0,),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(100.0),
                    child: Container(
                      // changing from 200 to 150 as to look better
                      height: 50.0,
                      width: 50.0,
                      child: ClipOval(
                        child: Image(fit: BoxFit.cover, image: AssetImage(image,),),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Center(
                  child: Text(langName, style: TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: "Quando", fontWeight: FontWeight.w600,),),
                ),
                SizedBox(width: 5,),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget newCustomCard(String langName,List list){
    var langName1 = langName.split(' ').join('');
    String image = 'images/${langName1.replaceAll('\n','')}'+'.png';

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 10.0,
      ),
      child: InkWell(
        onTap: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ChildPage(title:langName,list:list),));
          },
        child: Material(
          color: primaryColor,
          elevation: 10.0,
          borderRadius: BorderRadius.circular(25.0),
          child: Container(
            child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(width: 10,),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0,),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(100.0),
                    child: Container(
                      // changing from 200 to 150 as to look better
                      height: 50.0,
                      width: 50.0,
                      child: ClipOval(
                        child: Image(fit: BoxFit.cover, image: AssetImage(image),),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Center(
                  child: Text(langName, style: TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: "Quando", fontWeight: FontWeight.w700,),),
                ),
                SizedBox(width: 5,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown, DeviceOrientation.portraitUp
    ]);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon:Icon(Theme.of(context).brightness==Brightness.light?Icons.lightbulb_outline:Icons.highlight),onPressed:(){
            DynamicTheme.of(context).setBrightness(Theme.of(context).brightness==Brightness.light?Brightness.dark:Brightness.light);
          },),
          PopupMenuButton<String>(
            onSelected: (value) {
              if(value=='About'){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>About()));
              }
            },
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice) {
                return PopupMenuItem<String>(
                  child: Text(choice),
                  value: choice,
                );
              }).toList();
            },
          )
        ],
        title: Text(
          "Engineering Quiz",
          style: TextStyle(
            fontFamily: "Quando",
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 5,),
          newCustomCard('Basic Electronics',basicElectronics),
          newCustomCard('C Programming',cProgramming),
//          newCustomCard('C++ Programming',cppProgramming),
          customCard('Chemistry'),
          newCustomCard('Computer Science',computerScience),
//          newCustomCard('Database',database),
          newCustomCard('Digital Electronics',digitalElectronics),
          newCustomCard('Electrical',electrical),
//          newCustomCard('Electronics and\n Communications',electronicsAndCommunication),
          newCustomCard('Electronics Device and\n Circuit Theory',electronicsDeviceAndCircuitTheory),
          newCustomCard("General Science",generalScience),
//          newCustomCard('Java',java),
//          newCustomCard('Networking',networking),
          customCard('Physics'),
          SizedBox(height: 20,),
        ],
      ),
      //drawer: Drawer(),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:engineeringquiz/homepage.dart';
import 'package:engineeringquiz/pages/search.dart';
import '../datasource.dart';
import '../newquizpage.dart';

class ChildPage extends StatefulWidget {
  final title;
  final list;

  const ChildPage({Key key, this.title,this.list}) : super(key: key);
  @override
  _ChildPageState createState() => _ChildPageState(this.title,this.list);
}

class _ChildPageState extends State<ChildPage> {
  final title;
  final list;
  _ChildPageState(this.title,this.list);

  Widget customCard(String langName){

    String image= 'images/${title.split(' ').join('').replaceAll('\n','')}.png';

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 5.0,
      ),
      child: InkWell(
        onTap: (){Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => GetJsonNew(langName:langName,image:image),));},
        child: Material(
          color: primaryColor,
          elevation: 10.0,
          borderRadius: BorderRadius.circular(25.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(width: 5,),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0,),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(100.0),
                      child: Container(
                        // changing from 200 to 150 as to look better
                        height: 40.0,
                        width: 40.0,
                        child: ClipOval(
                          child: Image(fit: BoxFit.cover, image: AssetImage(image),),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5,),
                  Center(
                    child: Text(langName, style: TextStyle(fontSize: 15.0, color: Colors.white, fontFamily: "Quando", fontWeight: FontWeight.w700,),),
                  ),
                  SizedBox(width: 5,),
                ],
              ),
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
    return WillPopScope(
      onWillPop: (){
        return Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomePage()));
      },
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search),onPressed: (){
              showSearch(context: context, delegate: Search(list,'images/${title.split(' ').join('').replaceAll('\n','')}.png',title));
            },)
          ],
          title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
              child: Text(title+' ['+list.length.toString()+']',style: TextStyle(fontFamily: "Quando",),)),
          leading:
                IconButton(icon: Icon(Icons.arrow_back),
                onPressed: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomePage()));
                },)
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(height: 5,),
              for(var e in list)
                customCard(e.toString()),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
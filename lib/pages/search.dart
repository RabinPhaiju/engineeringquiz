import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:engineeringquiz/homepage.dart';
import '../datasource.dart';
import '../newquizpage.dart';

class Search extends SearchDelegate{

  final List list;
  final String image;
  final String title;

  Search(this.list, this.image, this.title);

@override
ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: primaryColor,
      brightness: DynamicTheme.of(context).brightness,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear),onPressed: (){
        query='';
      },)
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage()),
              (Route<dynamic> route) => false);
    },);
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestionList = query.isEmpty?
    list:list.where((element)=>element.toString().toLowerCase().startsWith(query)).toList();

    return ListView.builder(itemCount: suggestionList.length ,itemBuilder: (context,index){
      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 5.0,
        ),
        child: InkWell(
          onTap: (){
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => GetJsonNew(langName:suggestionList[index],image:image)),
                    (Route<dynamic> route) => false);
          },
          child: Material(
            color: primaryColor,
            elevation: 10.0,
            borderRadius: BorderRadius.circular(25.0),
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
                    child: Text(suggestionList[index], style: TextStyle(fontSize: 15.0, color: Colors.white, fontFamily: "Quando", fontWeight: FontWeight.w700,),),
                  ),
                  SizedBox(width: 5,),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty?
    list:list.where((element)=>element.toString().toLowerCase().startsWith(query)).toList();
    
    return ListView.builder(itemCount: suggestionList.length ,itemBuilder: (context,index){
      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 5.0,
        ),
        child: InkWell(
          onTap: (){
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => GetJsonNew(langName:suggestionList[index],image:image)),
                    (Route<dynamic> route) => false);
            },
          child: Material(
            color: primaryColor,
            elevation: 10.0,
            borderRadius: BorderRadius.circular(25.0),
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
                    child: Text(suggestionList[index], style: TextStyle(fontSize: 15.0, color: Colors.white, fontFamily: "Quando", fontWeight: FontWeight.w700,),),
                  ),
                  SizedBox(width: 5,),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

}
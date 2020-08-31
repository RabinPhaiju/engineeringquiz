import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,DeviceOrientation.portraitUp
    ]);
    return Scaffold(
      appBar: AppBar(title: Text("About Engineering Quiz"),),
//      backgroundColor: Colors.black12,
      body: Container(
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: SingleChildScrollView(

            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20,horizontal: 100),
                  child: Image.network('https://pbs.twimg.com/profile_images/1201698553149550592/2-Q2Du8O_400x400.jpg',width: 150),
                ),
                Text('Rabin Phaiju',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19),),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){
                    launch('https://github.com/rabinphaiju');
                  },
                  child:  Text('Github',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue,fontSize: 15),),
                ),
                Text('Engineering Quiz app contains 5433 Multiple Choice Questions.',
                  style: TextStyle(fontSize: 18),),
                SizedBox(height: 10,),
                Text('Learn, spend some free time with it.\n'
                    'Quiz based in multiple choice question.\n'
                    'Utilize your free time in learning.',
                  style: TextStyle(fontSize: 18),),
                SizedBox(height: 10,),

                SizedBox(height: 10,),

              ],
            ),
          )
      ),
    );
  }
}

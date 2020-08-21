import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:engineeringquiz/splash.dart';
import 'datasource.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      data: (brightness){
        return ThemeData(
          primaryColor: primaryColor,
          fontFamily: 'Quando',
          brightness: brightness==Brightness.light?Brightness.light:Brightness.dark,
          scaffoldBackgroundColor: brightness==Brightness.dark?Colors.grey[900]:Colors.grey[200],
        );
      },
      themedWidgetBuilder: (context,theme){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Engineering Quiz",
          theme: theme,
          home: splashscreen(),
        );
      },

    );

  }
}
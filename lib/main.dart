import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}



class App extends StatelessWidget 
{
  const App({Key? key}):super(key:key);

  @override 
  Widget build(BuildContext context){
    return MaterialApp(   
      title: "Flutter Utils",
      debugShowCheckModeBanner : false,
      home : Scaffold(   
        appBar :AppBar(title : Text("Title")),
        body : Center( child : 
          
          Text("Hello World"))
      )
    );
  }
  
}
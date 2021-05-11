import 'package:flutter/material.dart';
import 'package:flutter_shared_prefs/ui/user_profile.dart';

void main()=>runApp(App());

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserProfile(),
    );
  }

}
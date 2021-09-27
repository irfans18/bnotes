// ignore_for_file: prefer_const_constructors

import 'package:bnotes/helper/drawer_navigation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DNotes - Home"),
      ),
      drawer: DrawerNavigation(),
    );
  }
}

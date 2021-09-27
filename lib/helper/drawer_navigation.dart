// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:bnotes/pages/home_page.dart';
import 'package:bnotes/pages/categories_page.dart';
import 'package:flutter/material.dart';

class DrawerNavigation extends StatefulWidget {
  const DrawerNavigation({ Key? key }) : super(key: key);

  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: Icon(Icons.people, color: Colors.white,),
              //   CircleAvatar(
              //     backgroundImage: 
              //       NetworkImage("https://drive.google.com/file/d/11v0bkBMr3dF42w8N8qyzMGr_lfMca4aq/view?usp=sharing"),),
              accountName: Text("Irfan Shiddiq"), 
              accountEmail: Text("rfn.sdq@rfn.sdq"),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () => { Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage())) },
            ),
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text("Categories"),
              onTap: () => { Navigator.of(context).push(MaterialPageRoute(builder: (context) => CategoriesPage())) },
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:e_shopping/modules/user/register/register.dart';
import 'package:flutter/material.dart';
import 'package:e_shopping/shared/styles/colors.dart';
import 'login.dart';

class Tabs extends StatefulWidget {
  const Tabs({Key? key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          flexibleSpace: Container(
            color: primaryColor,
            width: double.infinity,
            height: 200.0,
          ),
          bottom: const TabBar(
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                color: Colors.white,
                width: 10,
              ),
              insets: EdgeInsets.symmetric(horizontal: 200.0),
            ),
            tabs: [
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 14.0,color: Colors.white),
                  ),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'REGISTER',
                    style: TextStyle(fontSize: 14.0,color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          title:  const Text('.Shopping',style: TextStyle(fontWeight: FontWeight.bold,fontStyle:FontStyle.italic),),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        body: TabBarView(
          children: [
            Login(),
            Signup(),
          ],
        ),
      ),
    );
  }
}

import 'package:dismissible/dismissible_100/dismissible_100.dart';
import 'package:dismissible/dismissible_100/dismissible_110.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grid Template',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: MyGrid(),
    );
  }
}

class MyGrid extends StatelessWidget {
  const MyGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //-------------------------------------------------------
      //1. appbar
      //-------------------------------------------------------
      appBar: AppBar(
        title: const Text("Firebase, FireStore Template"),
        centerTitle: true,
        //elevation: 0.0,

        actions: [
          IconButton(
              onPressed: () {
                debugPrint("click");
              },
              icon: const Icon(Icons.shopping_cart)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.search))
        ],
      ),

      //-------------------------------------------------------
      //2. Drawer menu
      //-------------------------------------------------------
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('images/farmer_loop.png'),
                backgroundColor: Colors.white,
              ),
              accountEmail: Text("farmerkyh@naver.com"),
              accountName: Text("farmer"),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 176, 211, 240),
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(40.0), bottomRight: Radius.circular(40.0))),
            ),
            createLeftOneMenu(context, "dismissible", Dismissible100()),
            createLeftOneMenu(context, "dismissible (slide)", Dismissible110()),
            const Divider(height: 5),
          ],
        ),
      ),

      //-------------------------------------------------------
      //3. body
      //-------------------------------------------------------
      body: const Center(child: Text("Firebase, FireStore Template ????????? \n????????? ?????? ?????????.")),
    );
  }

  //-------------------------------------------------------
  //@class ?????? ?????? ?????? ??????
  //-------------------------------------------------------
  SizedBox createLeftOneMenu(BuildContext context, String menuNm, Widget page) {
    return SizedBox(
      height: 30,
      child: ListTile(
        title: Text(menuNm),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => page));
          //Navigator.pop(context);
          //Route route = MaterialPageRoute(builder: (context) => ListViewStep10());
          //Navigator.pushReplacement(context, route);
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_insta/flutter_insta.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Instagram",
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FlutterInsta flutterInsta;

  TextEditingController usernameController = TextEditingController();

  String username, followers = " ", following, bio, website, profileimage;
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Instagram"),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white10,
            ),
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 7),
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Instagram id",
                        labelText: "Instagram id"),
                    controller: usernameController,
                  ),
                ),
                RaisedButton(
                  child: Text("Print Details"),
                  elevation: 2,
                  onPressed: () async {
                    setState(() {
                      pressed = true;
                    });
                    printDetails(usernameController.text);
                  },
                ),
                pressed
                    ? SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.all(0),
                          //decoration: BoxDecoration(color: Colors.white70,),
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Card(
                            borderOnForeground: true,
                            child: Container(                              
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.white70),
                              margin: EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 10),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.network(
                                      "$profileimage",
                                      width: 150,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10),
                                  ),
                                  Text(
                                    "${username}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "${followers}\nFollowers",
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        "${following}\nFollowing",
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10),
                                  ),
                                  Text(
                                    "${bio}",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10),
                                  ),
                                  Text(
                                    "${website}",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future printDetails(String username) async {
    flutterInsta = FlutterInsta(usernameController.text);
    await flutterInsta.getData();
    setState(() {
      this.username = usernameController.text;
      this.followers = flutterInsta.followers;
      this.following = flutterInsta.following;
      this.website = flutterInsta.website;
      this.bio = flutterInsta.bio;
      this.profileimage = flutterInsta.imgurl;
      print(followers);
    });
  }
}

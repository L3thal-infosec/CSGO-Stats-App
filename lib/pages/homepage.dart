import 'package:csgoapp/players/challaak/challaakpage.dart';
import 'package:csgoapp/players/l3thal/l3thalpage.dart';
import 'package:csgoapp/players/aheesh/aheeshpage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import "package:http/http.dart" as http;
import 'dart:convert';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:csgoapp/models/post.dart';
import 'package:csgoapp/widgets/newscard.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _showInfoDialog() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          
          backgroundColor: Colors.deepOrangeAccent,
          title: const Text('CSGO Stats App', textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20,fontFamily: 'Baloo',color: Colors.black,fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                new Text(' Developed by Karthik', textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontFamily: 'Poppins',color: Colors.black,fontWeight: FontWeight.bold),),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  child: Text(
                    'https://github.com/L3thal-infosec',
                    style: TextStyle(
                      fontSize: 18,fontFamily: 'Poppins',color: Colors.black,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: () =>
                      launch('https://github.com/L3thal-infosec'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('OK',style: TextStyle(color: Colors.black),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  List<Post> posts = List();
  bool isLoaded = false;

  String url =
      "http://api.steampowered.com/ISteamNews/GetNewsForApp/v0002/?appid=730&count=3&maxlength=300&format=json";
  Future<void> _fetchData() async {
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        posts = (data["appnews"]["newsitems"] as List).map((post) {
          return Post.fromJSON(post);
        }).toList();
        setState(() {
          this.isLoaded = true;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('CSGO News',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,fontFamily: 'Baloo',color: Colors.black),),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: _showInfoDialog,
          )
        ],
        backgroundColor: Colors.deepOrangeAccent,
        elevation: 50,
         brightness: Brightness.dark,
      ),
      drawer: new Drawer(
        child: Container(color: Colors.blueGrey,
        child: ListView(
          children: <Widget>[
            ListTile( 
              leading: Icon(MdiIcons.homeExportOutline,color: Colors.lightBlue),
              title:Text('Home',
              style: TextStyle(
                fontSize: 18,
              ),
              ),
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  )
                );
              },        
            ),
            ListTile( 
              leading: Icon(MdiIcons.gamepadCircleOutline,color: Colors.lightBlue),
              title:Text('Karthik',
              style: TextStyle(
                fontSize: 17.5,
              ),
              ),
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => L3thalPage()
                  )
                );
              },        
            ), 
            ListTile( 
              leading: Icon(MdiIcons.gamepadCircleOutline,color: Colors.lightBlue),
              title:Text('Arun',
              style: TextStyle(
                fontSize: 17.5,
              ),
              ),
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => ChallaakPage()
                  )
                );
              },        
            ),
            ListTile( 
              leading: Icon(MdiIcons.gamepadCircleOutline,color: Colors.lightBlue),
              title:Text('Aheesh',
              style: TextStyle(
                fontSize: 17.5,
              ),
              ),
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => AheeshPage()
                  )
                );
              },        
            ),
          ],
        ),
        ),
      ),
      body: RefreshIndicator(
        child: this.isLoaded
            ? ListView.builder(
                itemCount: posts.length,
                padding: EdgeInsets.symmetric(vertical: 20.0),
                itemBuilder: (BuildContext context, int index) {
                  return NewsCard(posts[index]);
                },
               
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
        onRefresh: _fetchData,
      ),
      
    );
  }
}

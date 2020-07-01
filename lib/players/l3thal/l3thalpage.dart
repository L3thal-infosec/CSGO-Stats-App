import 'package:csgoapp/players/aheesh/aheeshpage.dart';
import 'package:csgoapp/players/challaak/challaakpage.dart';
import 'package:csgoapp/players/l3thal/l3thalstats.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:csgoapp/pages/homepage.dart';

void main() => runApp(new MaterialApp(
      home: new L3thalPage(),
  ),
      
    );

class L3thalPage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<L3thalPage> {

  final String url="http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=API_KEY&steamids=76561198383383121&format=json";
  List data;

  @override
  void initState(){
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async{
    var response = await http.get(
        Uri.encodeFull(url),
      headers: {"Accept": "application/json"}

    );

    print(response.body);

    setState(() {
      var toJsonData = json.decode(response.body);
      data = toJsonData['response']['players'];
    });

    return "Success";
}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        actions: <Widget>[
        ],
        backgroundColor: Colors.red,
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
              title:Text('L3thal Demon',
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
              title:Text('Challaak',
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
            )
          ],
        ),
        ),
      ),
      backgroundColor: Colors.black,
        body: new ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index) {
              return new Container(
                  child: new Center(
                      child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
        SizedBox(height: 40.0),
        
                  Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                      border: Border.all(
      color: Colors.red, //                   <--- border color
      width: 5.0,
    ),
                        color: Colors.red,
                        image: DecorationImage(
                            image: NetworkImage(
                                '${data[index]['avatarfull']}'),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(75.0)),
                        boxShadow: [
                          BoxShadow(blurRadius: 7.0, color: Colors.black)
                        ])),
                    SizedBox(height: 40.0),
                Text(
  '${data[index]['personaname']}', textAlign: TextAlign.center,
  style: TextStyle(fontStyle: FontStyle.normal,color: Colors.white70,fontSize: 25,fontFamily: 'Georgia'),
),
                    SizedBox(height: 60.0),
                    Text(
  ' ${data[index]['realname']}', textAlign: TextAlign.center,
  style: TextStyle(fontStyle: FontStyle.normal,color: Colors.red,fontSize: 25,fontFamily: 'Georgia'),
),
                    SizedBox(height: 50.0),
      Text(
  'Currently Playing', textAlign: TextAlign.center,
  style: TextStyle(fontStyle: FontStyle.normal,color: Colors.tealAccent,fontSize: 20,fontFamily: 'Georgia'),
),
                    SizedBox(height: 10.0),
 Text(
  '${data[index]['gameextrainfo']}', textAlign: TextAlign.center,
  style: TextStyle(fontStyle: FontStyle.normal,color: Colors.blueAccent,fontSize: 20,fontFamily: 'Georgia'),
),

                    SizedBox(height: 30.0),
                  RaisedButton(
                  shape: RoundedRectangleBorder(
  borderRadius: new BorderRadius.circular(18.0),
  side: BorderSide(color: Colors.red)
),
              color: Colors.red,
              child: Text('Profile',textAlign: TextAlign.center,
  style: TextStyle(fontStyle: FontStyle.normal,color: Colors.black,fontSize: 25,fontFamily: 'Georgia'),),
              onPressed: _launchUrl2
            ), 
                SizedBox(height: 20.0),
            RaisedButton(
                  shape: RoundedRectangleBorder(
  borderRadius: new BorderRadius.circular(18.0),
  side: BorderSide(color: Colors.red)
),
              color: Colors.red,
              child: Text('Player Stats',textAlign: TextAlign.center,
  style: TextStyle(fontStyle: FontStyle.normal,color: Colors.black,fontSize: 25,fontFamily: 'Georgia'),),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => L3thalStats()
                ),
                
            );
              },
                
              ),
                ],
                      ),
              ),
              );
            }));
  }
}

_launchUrl2() async {
  final String url = "https://steamcommunity.com/profiles/76561198383383121/";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
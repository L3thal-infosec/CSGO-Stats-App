import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(new MaterialApp(
      home: new AheeshStats(),
    ));

class AheeshStats extends StatefulWidget {
  @override
  FourthScreenState createState() => new FourthScreenState();
}

class FourthScreenState extends State<AheeshStats> {

  final String url="http://api.steampowered.com/ISteamUserStats/GetUserStatsForGame/v0002/?appid=730&key=API_KEY&steamid=76561198064494995&format=json";
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
      data = toJsonData['playerstats']['stats'];
    });

    return "Success";
}

  @override
  Widget build(BuildContext context) {
        final deviceWidth = MediaQuery.of(context).size.height;
    return new Scaffold(
         backgroundColor: Colors.black,
        appBar: new AppBar(
          title: new Text("CSGO STATS",
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'RobotoMono',fontSize: 25,color: Colors.black ),
          ),
          centerTitle: true,
        ),
        body: new ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index) {
              return new Container(
                  child: new Center(
                      child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: deviceWidth * 0.5,
                  child: Card(
                    color: Colors.blueAccent,
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
                      child: new Container(
                    child: new Text(" ${data[index]['name'].replaceAll('_', ' ').toUpperCase().replaceFirst(RegExp(r"\.[^]*"), "")}    =    ${data[index]['value']}",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Georgia',fontSize: 15,color: Colors.white ),
                    ),
                    padding: const EdgeInsets.all(20),
                  ),
                  elevation: 5,
    margin: EdgeInsets.all(15),
                ),
                  ),
                ],
              )));
            }));
  }
}

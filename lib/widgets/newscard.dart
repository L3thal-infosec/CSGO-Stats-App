import 'package:flutter/material.dart';
import 'package:csgoapp/models/post.dart';
import 'package:csgoapp/pages/webview.dart';

class NewsCard extends StatefulWidget {
  final Post post;

  NewsCard(this.post);

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Card(
       shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0),
  ),
      elevation: 3,
      color: Colors.red[100],
      child: InkWell(
        onTap: () {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => WebView(widget.post.url, widget.post.title)
            )
          );
        },
        
        child: Column(
          
          children: <Widget>[
             Container(
               
                        height: deviceHeight * 0.3,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            image: DecorationImage(
                                image: AssetImage("assets/images/csgo.jpg"),
                                fit: BoxFit.fill)),
                      ),
                      
                Padding(
                    padding: EdgeInsets.all(8.0),
                    
                    child: Text(
                      widget.post.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1.25,
                          fontSize: deviceHeight * 0.03,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  
                  ),
                  SizedBox(height:40),
          ],
          
        ),

      ),
      
    );
    
  }
  
}

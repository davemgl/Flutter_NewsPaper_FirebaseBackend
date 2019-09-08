import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:async/async.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {

  StreamSubscription<QuerySnapshot> subscription;

  List<DocumentSnapshot>snapshot;

  CollectionReference collectionReference=Firestore.instance.collection("post");

  @override
  void initState() {

    subscription=collectionReference.snapshots().listen((datasnap){

      setState(() {

        snapshot=datasnap.documents;

      });

    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFF222240),

      appBar: new AppBar(
        title: new Text("News Portal"),
        backgroundColor: Color(0xFF222240),
      ),

      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[

            new UserAccountsDrawerHeader(
                accountName: null,
                accountEmail: null,
              decoration: new BoxDecoration(
                color: Color(0xFF222240),
              ),
            ),
            
            new ListTile(
              title: new Text("Item 1",style: TextStyle(fontSize: 20.0),),
              leading: new Icon(Icons.search,size: 20.0,color: Colors.purple,),
            ),


            new ListTile(
              title: new Text("Item 2",style: TextStyle(fontSize: 20.0),),
              leading: new Icon(Icons.present_to_all,size: 20.0,color: Colors.purple,),
            ),


            new ListTile(
              title: new Text("Item 3",style: TextStyle(fontSize: 20.0),),
              leading: new Icon(Icons.face,size: 20.0,color: Colors.purple,),
            ),


          ],
        ),
      ),

      body: new ListView(
        children: <Widget>[

          //First Container start

          new Container(
            height: 190.0,
            margin: EdgeInsets.only(top:10.0,left: 0.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text("Latest Post",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white
                  ),
                  ),
                ),

                new Container(
                  height: 130.0,
                  margin: EdgeInsets.only(top:10.0),
                  child: new ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.length,
                      itemBuilder: (context,index){
                        return Container(
                          width: 300.0,
                          margin: EdgeInsets.only(left: 10.0),
                          color: Color(0xFF272B4A),
                          child: new Row(
                            children: <Widget>[

                              new Expanded(
                                flex: 1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: new Image.network(snapshot[index].data["image"],
                                    height: 130.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              new SizedBox(width: 10.0,),
                              new Expanded(
                                flex: 2,
                                child: new Container(
                                  color: Color(0xFF272B4A),
                                  child: new Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Text(snapshot[index].data["title"],
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 21.0,
                                            color: Colors.white
                                        ),
                                      ),

                                      new SizedBox(height: 10.0,),

                                      new Text(snapshot[index].data["des"],
                                        maxLines: 3,
                                        style: TextStyle(
                                            fontSize: 17.0,
                                            color: Colors.white
                                        ),
                                      ),
                                      new SizedBox(height: 5.0,),

                                      new Container(
                                        child: new Row(
                                          children: <Widget>[

                                            new Icon(Icons.remove_red_eye,
                                              color: Colors.orange,
                                            ),
                                            new SizedBox(width: 5.0,),
                                            new Text("View",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.white
                                              ),
                                            )

                                          ],
                                        ),
                                      )


                                    ],
                                  ),
                                ),
                              ),




                            ],
                          ),

                        );
                      }

                  ),

                )

              ],
            ),
          )

          //First Container end..


        ],
      ),

    );
  }
}


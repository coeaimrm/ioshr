import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class ListPage extends StatefulWidget{
  @override
  _ListPageState createState() => _ListPageState();

}

class _ListPageState  extends State<ListPage>{
    Future _data;
    Future getFeedBacks() async {
      var firestore = Firestore.instance;
      QuerySnapshot qn = await firestore.collection("Emp").getDocuments();
      return qn.documents;
    }
    navigateToDetail(DocumentSnapshot month){

      Navigator.push(context,MaterialPageRoute(builder:(context) => DetailPage(month:month,)));
    }
    void initState() {
      super.initState();
      _data = getFeedBacks();
    }

    @override
     Widget build(BuildContext context){
      return Scaffold(
          appBar: AppBar(
           title: new Text('HR App'),
           ),

        body:

            FutureBuilder(
             future: _data,
             builder:( _, snapshot)
            {
             if (snapshot.connectionState == ConnectionState.waiting) {
             return Center(
              child: Text("Loading..."),
              );
             } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_,index){
                return ListTile(
                 title: Text(snapshot.data[index].data["name"]),
                 onTap:() => navigateToDetail(snapshot.data[index]),
               );

           });

         }
        }),
       );


    }
  }



class DetailPage extends StatefulWidget{
  final DocumentSnapshot month;
  DetailPage({this.month});
  @override
  _DetailPageState createState() => _DetailPageState();

}

class _DetailPageState  extends State<DetailPage>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.month.data["name"]),
      ),

      body:Container(

        child: Card(
          child:ListTile(
            title: Text(widget.month.data["name"]),
            subtitle:Text(widget.month.data["FeedBackType"]),

          ),

        ),

      ),
    );
  }
}
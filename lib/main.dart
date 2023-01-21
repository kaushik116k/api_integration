import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
void main() {
  runApp(
    MaterialApp(
      title: "API INTEGRATION",
      home: myApp(),
    )
  );
}
class myApp extends StatefulWidget{
  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  Map map = {};
  List listResponse = [];
  Future apiCall() async {
    http.Response response = await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
    if(response.statusCode == 200){
      setState(() {
        map = json.decode(response.body);
        listResponse = map['data'];
      });
    }
  }

  @override
  void initState() {
    apiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("API"),),
      body: Center(
        child: ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                  child: Column(
                    children: [
                      Image.network(listResponse[index]['avatar']),
                      Padding(padding: EdgeInsets.all(5),
                        child: Text(listResponse[index]['first_name']),
                      ),
                      Padding(padding: EdgeInsets.all(5),
                        child: Text(listResponse[index]['email']),
                      )
                    ],
                  ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: listResponse.isEmpty ?
                0 : listResponse.length,
        ),
      ),
    );
  }
}
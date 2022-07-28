import 'dart:convert';
import 'package:apilearning/Models/datum.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  Future<AutoGenerate> getDataApi() async {
    final response = await http
        .get(Uri.parse('https://inshorts.deta.dev/news?category=technology'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return AutoGenerate.fromJson(data);
    } else {
      return AutoGenerate.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('News API')),
      ),
      body: Column(children: [
        Expanded(
          child: FutureBuilder<AutoGenerate>(
              future: getDataApi(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      
                      return Card(
                        child: Column(
                          
                          children:[
                            Text(snapshot.data!.data[index].content.toString()),
                            const SizedBox(height: 10),
                           Row(
                            
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:[ 
                              
                            Text(snapshot.data!.data[index].author.toString()),
                            Text(snapshot.data!.data[index].date.toString()),

       ]),
       const SizedBox(height: 10),
       Text(snapshot.data!.data[index].time.toString()),
        ]));
                    },
                  );
                }
                else{
                  return const Center(child: Text("Loading!!.."));
                }
              })),
        )
      ]),
    );
  }
}

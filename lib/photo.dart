import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class Tryapi extends StatefulWidget {
  const Tryapi({Key? key}) : super(key: key);

  @override
  State<Tryapi> createState() => _TryapiState();
}

class _TryapiState extends State<Tryapi> {
  List<Photos> photolist = [];
  Future<List<Photos>> getPhotoApi() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        Photos photos = Photos(
            title: i['title'],
            url: i['url'],
            thumbnailUrl: i['thumbnailUrl'],
            id: i['id']);
        photolist.add(photos);
      }
      return photolist;
    }else{
      return photolist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Practise API'))),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPhotoApi(),
              builder:  (context, AsyncSnapshot<List<Photos>>snapshot) {
              return ListView.builder(
                itemCount: photolist.length,
                itemBuilder: ( context,  index) {
                  return ListTile(
                    leading: CircleAvatar(
                      //backgroundImage: NetworkImage((snapshot.data![index].url.toString())),
                      foregroundImage: NetworkImage((snapshot.data![index].thumbnailUrl.toString()))
                    ),
                    title: Text(snapshot.data![index].title.toString()),
                  );
                },);
              
            
            }
                ),
          )],
      ),
    );
  }
}

class Photos {
  String title, url, thumbnailUrl;
  int id;

  Photos(
      {required this.title,
      required this.url,
      required this.thumbnailUrl,
      required this.id});
}

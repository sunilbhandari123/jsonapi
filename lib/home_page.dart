import 'dart:convert';

import 'package:apilearning/Models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<PostsModel> postlist = [];

  Future<List<PostsModel>> getPostApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        postlist.add(PostsModel.fromJson(i));
      }
      return postlist;
    } else {
      return postlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child:Text('Learning API')),
        ),
        body: Column(
          children: [
              Expanded(
              child: FutureBuilder(
                  future: getPostApi(),
                  builder: (context, snapshot){
                    if (!snapshot.hasData) {
                      return const Text('Loading');
                    }else{
                      return ListView.builder(
                        itemCount: postlist.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(

                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children:[
                                const Text('Title:',style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(postlist[index].title.toString()),
                                const Text('Discription:',style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(postlist[index].body.toString()),
                                ]),
                            )) ;
                        },
                      );
                    }
                  }
                  ),
            )
          ],
        ));
  }
}

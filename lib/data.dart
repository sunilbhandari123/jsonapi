import 'dart:convert';

import 'package:flutter/material.dart';
import 'Models/model.dart';
import 'package:http/http.dart' as http;

class Data extends StatefulWidget {
  const Data({Key? key}) : super(key: key);

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  List<Root> datalist = [];
  Future<List<Root>> getDataApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        datalist.add(Root.fromJson(i));
      }
      return datalist;
    } else {
      return datalist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Continuing API')),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getDataApi(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: Text('Loading!!!'));
                } else {
                  return ListView.builder(
                    itemCount: datalist.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Rew(title: 'ID:', value: snapshot.data[index].id.toString()),
                                Rew(title: 'Name:', value: snapshot.data[index].name.toString()),
                                Rew(title: 'UserName:', value: snapshot.data[index].username.toString()),
                                Rew(title: 'Email:', value: snapshot.data[index].email.toString()),
                                Rew(title: 'Address:', value: snapshot.data[index].address.city.toString()),
                                Rew(title: 'Longitude:', value: snapshot.data[index].address.geo.lng.toString())
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}


// ignore: must_be_immutable
class Rew extends StatelessWidget {
  String title, value;
  Rew({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                  Text(title,style: const TextStyle(fontSize: 15,fontWeight:FontWeight.bold,)),
                  Text(value,style: const TextStyle(fontSize: 15,fontWeight:FontWeight.bold,))]);
                  
  }
}

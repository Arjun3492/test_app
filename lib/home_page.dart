import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url = "https://jsonplaceholder.typicode.com/photos";
  bool loading = true;
  var data;
  @override
  void initState() {
    super.initState();
  }

  fetchData() async {
    setState(() {});
    var res = await http.get(Uri.parse(url));
    data = jsonDecode(res.body);
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TestApp"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fetchData();
        },
        child: Icon(Icons.refresh),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            DrawerHeader(
              child: Text("This is my Test app with basic api call"),
              decoration: BoxDecoration(color: Colors.cyan),
            ),
          ],
        ),
      ),
      body: Center(
        child: (data == null)
            ? Text(
                "Click the floatingActionButton below",
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            : ((loading)
                ? CircularProgressIndicator()
                :
                //  Icon(Icons.add_business)
                ListView.builder(itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(data[index]["title"]),
                        subtitle: Text("ID:  ${data[index]["id"]}"),
                        leading: Image.network(data[index]["url"]),
                      ),
                    );
                  })),
      ),
    );
  }
}

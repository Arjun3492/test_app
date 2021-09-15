import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url = "https://jsonplaceholder.typicode.com/photos";
  var data;
  @override
  void initState() {
    super.initState();
    fetchData();
    setState(() {});
  }

  fetchData() async {
    var res = await http.get(Uri.parse(url));
    data = jsonDecode(res.body);
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TestApp"),
      ),
      floatingActionButton: FloatingActionButton(
        // onPressed: fetchData(),
        onPressed: () {},
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
          child: (data != null)
              ? ListView.builder(itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(data[index]["title"]),
                    subtitle: Text("ID:  ${data[index]["id"]}"),
                    leading: Image.network(data[index]["url"]),
                  );
                })
              : CircularProgressIndicator()),
    );
  }
}

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.blueGrey,
          accentColor: Colors.orange),
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List todos = [];
  String input = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Todo"),
      ),
      body: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(todos[index]),
              child: Card(
                elevation: 8,
                margin: EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  title: Text(todos[index]),
                ),
              ),
              onDismissed: (DismissDirection direction) {
                if (direction == DismissDirection.startToEnd) {
                  print("Add to favourite");
                } else {
                  print("Remove item");
                }

                setState(() {
                  todos.removeAt(index);
                });
              },
              confirmDismiss: (DismissDirection direction) async {
                return await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Confirm"),
                      content: const Text(
                          "Are you sure you wish to delete this item?"),
                      actions: <Widget>[
                        FlatButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text("DELETE")),
                        FlatButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text("CANCEL"),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Add Todo List"),
                  content: TextField(
                    onChanged: (String value) {
                      input = value;
                    },
                  ),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          setState(() {
                            todos.add(input);
                          });
                        },
                        child: Text("Add"))
                  ],
                );
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() => runApp(new MaterialApp(
      home: new Home(),
    ));

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HomeState();
}

class HomeState extends State<Home> {
  List<String> items = [
    "Apple",
    "Bananas",
    "Milk",
    "Water",
  ];
  TextEditingController controller = new TextEditingController();
  String filter;
  Icon actionIcon = new Icon(Icons.search);
  Widget appBarTitle = new Text("AppBar Title");

  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _search(){
    setState(() {
      if ( this.actionIcon.icon == Icons.search){
        this.actionIcon = new Icon(Icons.close);
        this.appBarTitle = new TextField(
          controller: controller,
          style: new TextStyle(color: Colors.white,),
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search,color: Colors.white),
              hintText: "Search...",
              hintStyle: new TextStyle(color: Colors.white)
          ),
        );}
      else {
        this.actionIcon = new Icon(Icons.search);
        this.appBarTitle = new Text("AppBar Title");
      }
    });
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: appBarTitle,
        actions: <Widget>[
          new IconButton(
              icon: actionIcon,
              onPressed: _search,
          ),
        ],
      ),
      body: new Column(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.only(top: 20.0),
          ),
          new Expanded(
              child: new ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return filter == null || filter == ""
                  ? new ListTile(title: new Text(items[index]))
                  : items[index].toLowerCase().contains(filter.toLowerCase())
                      ? new ListTile(title: new Text(items[index]))
                      : new ListTile();
            },
          ))
        ],
      ),
    );
  }
}

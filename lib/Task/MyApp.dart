import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool selectingmode = false;

  List<Language> paints = <Language>[
    Language(1, 'Flutter', Colors.red),
    Language(2, 'Android', Colors.blue),
    Language(3, 'PHP', Colors.green),
    Language(4, 'Java', Colors.lime),
    Language(5, 'C', Colors.indigo),
    Language(6, 'C++', Colors.yellow)
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: selectingmode
              ? IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                selectingmode = false;
                paints.forEach((p) => p.selected = false);
              });
            },
          )
              : null,
          title: Text("Selectable ListView Example"),
        ),
        body:
        ListView(
          children: List.generate(paints.length, (index) {
            return ListTile(
              onLongPress: () {
                setState(() {
                  selectingmode = true;
                });
              },
              onTap: () {
                setState(() {
                  if (selectingmode) {
                    paints[index].selected = !paints[index].selected;
                    log(paints[index].id.toString() + paints[index].selected.toString());
                  }
                });
              },
              selected: paints[index].selected,
              leading: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {},
                child: Container(
                  width: 48,
                  height: 48,
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundColor: paints[index].colorpicture,
                  ),
                ),
              ),
              title: Text('ID: ' + paints[index].id.toString()),
              subtitle: Text(paints[index].title),
              trailing: (selectingmode)
                  ? ((paints[index].selected)
                  ? Icon(Icons.check_box)
                  : Icon(Icons.check_box_outline_blank))
                  : null,
            );
          }),
        ),
      ),
    );
  }
}

class Language {
  final int id;
  final String title;
  final Color colorpicture;
  bool selected = false;

  Language(this.id, this.title, this.colorpicture);
}
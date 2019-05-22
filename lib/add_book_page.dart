import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'book_post_body.dart';

class AddBookPage extends StatefulWidget {
  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Add Book Details"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Book Name"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: yearController,
              decoration: InputDecoration(labelText: "Book Publication Year"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
              onPressed: () {
                _uploadDetails(nameController.text.toString(),
                    yearController.text.toString());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Upload",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  void _uploadDetails(String name, String year) async {
    String baseUrl = "https://api.buttercms.com/v2/posts";
    String collection = "books";

    // TODO: ENTER WRITE TOKEN HERE
    // THIS IS SEPARATE FROM NORMAL API KEY TO READ DATA
    String authToken = "";

    Response r = await post(
      baseUrl,
      headers: {'Authorization': authToken, 'Content-Type': 'application/json'},
      body: bookPostBodyToJson(
        BookPostBody(
          key: collection,
          status: "published",
          fields: [Field(field1Key: name, field2Key: year)],
        ),
      ),
    );

    _scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text(r.statusCode.toString())));
  }
}

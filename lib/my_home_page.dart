import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'add_book_page.dart';
import 'book_data.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BookData bookData;

  @override
  void initState() {
    super.initState();
    _getBooks().then((data) {
      setState(() {
        bookData = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ButterCMS Flutter Demo"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddBookPage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: _getBooks,
        child: bookData == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemBuilder: (context, position) {
                  return ListTile(
                    leading: Icon(Icons.book),
                    title: Text(bookData.data.books[position].bookName),
                  );
                },
                itemCount: bookData.data.books.length,
              ),
      ),
    );
  }
}

Future<BookData> _getBooks() async {
  String baseUrl = "https://api.buttercms.com/v2/content/?keys=";
  String collection = "books";

  //TODO: ENTER API KEY HERE
  //KEY retrieved from console
  String authToken = "";

  if (authToken == "") {
    print("EMPTY API KEY. Please paste API key from ButterCMS console.");
  }

  Response response =
      await get(baseUrl + collection + "&auth_token=" + authToken);
  return bookDataFromJson(response.body);
}

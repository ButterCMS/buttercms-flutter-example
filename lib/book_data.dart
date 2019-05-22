// To parse this JSON data, do
//
//     final bookData = bookDataFromJson(jsonString);

import 'dart:convert';

BookData bookDataFromJson(String str) => BookData.fromJson(json.decode(str));

String bookDataToJson(BookData data) => json.encode(data.toJson());

class BookData {
  Data data;

  BookData({
    this.data,
  });

  factory BookData.fromJson(Map<String, dynamic> json) => new BookData(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  List<Book> books;

  Data({
    this.books,
  });

  factory Data.fromJson(Map<String, dynamic> json) => new Data(
    books: new List<Book>.from(json["books"].map((x) => Book.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "books": new List<dynamic>.from(books.map((x) => x.toJson())),
  };
}

class Book {
  String bookName;
  String yearOfPublication;

  Book({
    this.bookName,
    this.yearOfPublication,
  });

  factory Book.fromJson(Map<String, dynamic> json) => new Book(
    bookName: json["book_name"],
    yearOfPublication: json["year_of_publication"],
  );

  Map<String, dynamic> toJson() => {
    "book_name": bookName,
    "year_of_publication": yearOfPublication,
  };
}

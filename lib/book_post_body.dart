// To parse this JSON data, do
//
//     final bookPostBody = bookPostBodyFromJson(jsonString);

import 'dart:convert';

BookPostBody bookPostBodyFromJson(String str) => BookPostBody.fromJson(json.decode(str));

String bookPostBodyToJson(BookPostBody data) => json.encode(data.toJson());

class BookPostBody {
  String key;
  String status;
  List<Field> fields;

  BookPostBody({
    this.key,
    this.status,
    this.fields,
  });

  factory BookPostBody.fromJson(Map<String, dynamic> json) => new BookPostBody(
    key: json["key"],
    status: json["status"],
    fields: new List<Field>.from(json["fields"].map((x) => Field.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "status": status,
    "fields": new List<dynamic>.from(fields.map((x) => x.toJson())),
  };
}

class Field {
  String field1Key;
  String field2Key;

  Field({
    this.field1Key,
    this.field2Key,
  });

  factory Field.fromJson(Map<String, dynamic> json) => new Field(
    field1Key: json["field1_key"],
    field2Key: json["field2_key"],
  );

  Map<String, dynamic> toJson() => {
    "field1_key": field1Key,
    "field2_key": field2Key,
  };
}


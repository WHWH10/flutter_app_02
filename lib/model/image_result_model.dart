// To parse this JSON data, do
//
//     final imageResultModel = imageResultModelFromJson(jsonString);

import 'dart:convert';

ImageResultModel imageResultModelFromJson(String str) => ImageResultModel.fromJson(json.decode(str));

String imageResultModelToJson(ImageResultModel data) => json.encode(data.toJson());

class ImageResultModel {
  ImageResultModel({
    this.lastBuildDate,
    this.total,
    this.start,
    this.display,
    this.items,
  });

  String lastBuildDate;
  int total;
  int start;
  int display;
  List<Item> items;

  factory ImageResultModel.fromJson(Map<String, dynamic> json) => ImageResultModel(
    lastBuildDate: json["lastBuildDate"],
    total: json["total"],
    start: json["start"],
    display: json["display"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "lastBuildDate": lastBuildDate,
    "total": total,
    "start": start,
    "display": display,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  Item({
    this.title,
    this.link,
    this.thumbnail,
    this.sizeheight,
    this.sizewidth,
  });

  String title;
  String link;
  String thumbnail;
  String sizeheight;
  String sizewidth;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    title: json["title"],
    link: json["link"],
    thumbnail: json["thumbnail"],
    sizeheight: json["sizeheight"],
    sizewidth: json["sizewidth"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "link": link,
    "thumbnail": thumbnail,
    "sizeheight": sizeheight,
    "sizewidth": sizewidth,
  };
}

// To parse this JSON data, do
//
//     final errorResultModel = errorResultModelFromJson(jsonString);

import 'dart:convert';

ErrorResultModel errorResultModelFromJson(String str) => ErrorResultModel.fromJson(json.decode(str));

String errorResultModelToJson(ErrorResultModel data) => json.encode(data.toJson());

class ErrorResultModel {
  ErrorResultModel({
    this.errorMessage,
    this.errorCode,
  });

  String errorMessage;
  String errorCode;

  factory ErrorResultModel.fromJson(Map<String, dynamic> json) => ErrorResultModel(
    errorMessage: json["errorMessage"],
    errorCode: json["errorCode"],
  );

  Map<String, dynamic> toJson() => {
    "errorMessage": errorMessage,
    "errorCode": errorCode,
  };
}

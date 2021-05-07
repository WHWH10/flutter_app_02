import 'dart:convert';

import 'package:flutter_app_02/model/image_result_model.dart';
import 'package:flutter_app_02/utils/constant.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Map<String, String> headers = {
    'X-Naver-Client-Id': headerNaver,
    'X-Naver-Client-Secret': secretNaver,
  };

  Future searchImage(String query) async {
    final response = await http.get(Uri.parse('$searchImageUrl?query=$query'),
        headers: headers);
    print('result data --- ${response.body.contains('errorCode')}');
    if (response.body.contains('errorCode')) {
      switch ('errorCode') {
        case 'SE01':
          print('잘못된 쿼리요청입니다.');
          break;
        default:
          print('실패쓰');
      }
    } else {
      print('Result -- ${ImageResultModel.fromJson(json.decode(response.body)).items[0].title}');
      return ImageResultModel.fromJson(json.decode(response.body));
    }
  }
}

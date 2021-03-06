import 'package:flutter/material.dart';
import 'package:flutter_app_02/model/image_result_model.dart';
import 'package:flutter_app_02/utils/api_service.dart';
import 'package:flutter_app_02/utils/constant.dart';

class MenuSearch extends StatefulWidget {
  final String search;

  const MenuSearch({Key key, this.search}) : super(key: key);

  @override
  _MenuSearchState createState() => _MenuSearchState();
}

class _MenuSearchState extends State<MenuSearch> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiService().searchImage(widget.search);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: mainColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: black),
          iconSize: 20.0,
          onPressed: () {
            _goBack(context);
          },
        ),
      ),
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              color: mainColor,
            )
          ],
        ),
      ),
    );
  }

  _goBack(BuildContext context) {
    Navigator.pop(context);
  }
}

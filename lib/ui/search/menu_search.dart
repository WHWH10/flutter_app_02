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
  var imageResult;
  List<Item> imageResultList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchImage();
  }

  void searchImage() async {
    imageResult = await ApiService().searchImage(widget.search);
    imageResultList = imageResult.items;
    print(imageResultList);
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
              width: double.infinity,
              color: mainColor,
              child: FutureBuilder(
                future: ApiService().searchImage(widget.search),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  switch(snapshot.connectionState) {
                    case ConnectionState.done:
                      // ignore: missing_return
                      return Text('${snapshot.data.items[0].title}');
                    case ConnectionState.waiting:
                      return CircularProgressIndicator();
                    case ConnectionState.none:
                      return Text('nothing');
                  }
                  return null;
                },
              ),
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

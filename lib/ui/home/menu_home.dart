import 'package:flutter/material.dart';
import 'package:flutter_app_02/model/category_model.dart';
import 'package:flutter_app_02/model/latest_item_model.dart';
import 'package:flutter_app_02/utils/constant.dart';
import 'package:flutter_app_02/utils/popular_card.dart';
import 'package:hive/hive.dart';

class MenuHome extends StatefulWidget {
  @override
  _MenuHomeState createState() => _MenuHomeState();
}

class _MenuHomeState extends State<MenuHome> {
  TextEditingController _searchController = TextEditingController();
  FocusNode _searchNode = FocusNode();
  List<CategoryModel> categoryModelList = [];

  Box<LatestItemModel> _latestIemBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < categoryNameList.length; i++) {
      categoryModelList.add(CategoryModel(
          name: categoryNameList[i],
          icon: categoryIconList[i],
          isSelected: false));
    }
    _latestIemBox = Hive.box('latestItem');
    print('_------ ${_latestIemBox.length}');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController?.dispose();
    _searchNode?.dispose();
    _latestIemBox.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        title: Text(
          'Pick the Menu',
          style: TextStyle(color: deepBlueColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(
                Icons.message,
                color: mainColor,
              ),
              onPressed: _showNotice),
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: mainColor,
            ),
            onPressed: _latestItem,
          ),
          IconButton(
              icon: Icon(
                Icons.account_circle_rounded,
                color: mainColor,
              ),
              onPressed: null)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _top(),
            _search(),
            _category(),
            _popularTitle(),
            _popular(),
            _offerTitle(),
            _offer(),
          ],
        ),
      ),
    );
  }

  Widget _top() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 10),
      child: Container(
        child: Text(
          'Welcome!',
          style: TextStyle(
              color: deepBlueColor, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }

  Widget _search() {
    return Padding(
      padding: EdgeInsets.only(top: 20, left: 30),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: lightGrey,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Icon(
                Icons.search,
                color: black,
              ),
            ),
            Expanded(
                child: TextFormField(
              controller: _searchController,
              focusNode: _searchNode,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "Search.."),
              cursorColor: deepBlueColor,
              onFieldSubmitted: (value) {
                // _searchNode.dispose();
                _searchMenu(value);
              },
            ))
          ],
        ),
      ),
    );
  }

  Widget _category() {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        height: 60,
        // color: Constant.deepBlueColor,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(categoryNameList.length, (index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    categoryModelList.forEach((element) {
                      element.isSelected = false;
                    });
                    categoryModelList[index].isSelected = true;
                  });
                },
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: categoryModelList[index].isSelected
                            ? mainColor
                            : lightGrey),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 13,
                            backgroundColor: Colors.transparent,
                            child: Image.asset(
                              categoryModelList[index].icon,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(categoryModelList[index].name,
                              style: TextStyle(
                                  color: deepBlueColor, fontSize: 12)),
                        )
                      ],
                    )),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _popularTitle() {
    return Padding(
        padding: const EdgeInsets.only(top: 20, left: 10),
        child: Row(
          children: [
            Text(
              'Most Popular',
              style: TextStyle(
                  color: deepBlueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 3),
              child: Image.asset(
                'assets/icon/category/sparkles.png',
                width: 30,
                height: 30,
              ),
            )
          ],
        ));
  }

  Widget _popular() {
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: Container(
          // color: Constant.deepBlueColor,
          height: 250,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(5, (index) {
              return PopularCard(
                  imageUrl: popularImageUrl[index], name: popularName[index]);
            }),
          )),
    );
  }

  //https://apps.timwhitlock.info/emoji/tables/unicode
  Widget _offerTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 10),
      child: Text(
        'Our Special Offer \u{1f60e}',
        style: TextStyle(
            color: deepBlueColor, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

  Widget _offer() {
    return Container(
      margin: EdgeInsets.all(10),
      height: 120,
      width: MediaQuery.of(context).size.width,
      // color: Constant.deepBlueColor,
      child: Image.network(
        'https://www.jeffbullas.com/wp-content/uploads/2020/10/Banner-Designs-Inspiration-Starbucks-Draft.jpg',
        fit: BoxFit.contain,
      ),
    );
  }

  void _showNotice() {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: mainColor,
          title: Text(
            '공지사항',
            textAlign: TextAlign.center,
          ),
          titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          content: Text('오후 12:00 ~ 13:00 시스템 점검으로 인하여 앱을 이용하실 수 없습니다.'),
          contentTextStyle: TextStyle(fontSize: 15, height: 2),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('확인', style: TextStyle(fontWeight: FontWeight.bold, color: black)),
              style: ElevatedButton.styleFrom(
                primary: white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                )
              ),
            )
          ],
        );
      },
    );
  }

  void _searchMenu(String value) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => RmSearch(result: value)),
    // );
  }

  void _latestItem() {
    if(_latestIemBox.length == 0) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: mainColor,
            title: Text(
              '최근 본 아이템',
              textAlign: TextAlign.center,
            ),
            titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            content: Text('아직 본게 없어요'),
            contentTextStyle: TextStyle(fontSize: 15, height: 2),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('확인', style: TextStyle(fontWeight: FontWeight.bold, color: black)),
                style: ElevatedButton.styleFrom(
                    primary: white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    )
                ),
              )
            ],
          );
        },
      );
    } else {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Text('아이템 나와랏 !!'),
          );
        }
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app_02/model/category_model.dart';

import 'constant.dart';

class CustomChipStyle extends StatefulWidget {
  final String selectMenu;
  final int index;

  const CustomChipStyle({Key key, this.selectMenu, this.index})
      : super(key: key);

  @override
  _CustomChipStyleState createState() => _CustomChipStyleState();
}

class _CustomChipStyleState extends State<CustomChipStyle> {
  bool _menuSelected = false;
  List<CategoryModel> categoryList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i=0;i<categoryNameList.length;i++) {
      categoryList.add(CategoryModel(
        name: categoryNameList[i], icon: categoryIconList[i], isSelected: false
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          print('click!');
          setState(() {
            _menuSelected = !_menuSelected;
          });
        },
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: _menuSelected ? mainColor : lightGrey),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 13,
                    backgroundColor: Colors.transparent,
                    child: Image.asset(
                      categoryNameList[widget.index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(widget.selectMenu,
                      style: TextStyle(color: deepBlueColor, fontSize: 12)),
                )
              ],
            )),
      ),
    );
  }
}

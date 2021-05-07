import 'package:flutter/material.dart';
import 'package:flutter_app_02/model/latest_item_model.dart';
import 'package:flutter_app_02/utils/constant.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:page_view_indicators/page_view_indicators.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MenuPopularDetail extends StatefulWidget {
  final String tag, name;

  const MenuPopularDetail({Key key, this.tag, this.name}) : super(key: key);

  @override
  _MenuPopularDetailState createState() => _MenuPopularDetailState();
}

class _MenuPopularDetailState extends State<MenuPopularDetail> {
  bool _isLiked = false;
  String likeKey = '';
  Box likeBox;
  YoutubePlayerController _youtubePlayerController;
  PageController _pageController;
  ValueNotifier<int> _currentPageNotifier;

  Box<LatestItemModel> _latestIemBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    likeKey = widget.name;
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: 'bOejScVoH6c',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );
    _pageController = PageController(
      initialPage: 0,
    );
    _currentPageNotifier = ValueNotifier<int>(0);
    _addLatestItemBox();
    // likeBox = Hive.box('likeFood');
  }

  _goBack(BuildContext context) {
    Navigator.pop(context);
  }

  void _likeButton() {
    setState(() {
      _isLiked = !_isLiked;
    });
  }

  _addLatestItemBox() {
    _latestIemBox = Hive.box('latestItem');
    _latestIemBox.containsKey(widget.tag)
    ? null
    : _latestIemBox.put(
        widget.tag, LatestItemModel(name: widget.name, imageUrl: widget.tag));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: midGrey,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: black),
          iconSize: 20.0,
          onPressed: () {
            _goBack(context);
          },
        ),
        actions: [
          IconButton(
              icon: _isLiked
                  ? Icon(Icons.favorite)
                  : Icon(Icons.favorite_outline),
              onPressed: _likeButton,
              color: _isLiked ? mainColor : black)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40),
                    bottomLeft: Radius.circular(40),
                  ),
                  color: midGrey,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Text('eunji'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 13,
                          backgroundColor: Colors.transparent,
                          child: Image.asset(
                            categoryIconList[2],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            '분식',
                            style: TextStyle(
                                color: deepBlueColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Hero(
                          tag: widget.tag,
                          child: Image.network(
                            widget.tag,
                            width: 200,
                            height: 200,
                          ),
                        ),
                      ),
                    )
                  ],
                )),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 160, vertical: 15),
              child: Divider(
                thickness: 8,
                color: mainColor,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 10),
                child: Center(
                  child: Text(
                    '떡볶이',
                    style: TextStyle(
                        color: deepBlueColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Text(
                  definition,
                  style: TextStyle(fontSize: 14, height: 2, color: black),
                  textAlign: TextAlign.justify,
                )),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Container(
                height: 200,
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        controller: PageController(
                          initialPage: 0,
                        ),
                        onPageChanged: (int index) {
                          _currentPageNotifier.value = index;
                        },
                        itemCount: popularImageUrl.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Image.network(popularImageUrl[index]);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 5),
                      child: CirclePageIndicator(
                        itemCount: popularImageUrl.length,
                        currentPageNotifier: _currentPageNotifier,
                      ),
                    )
                  ],
                ),
              ),
            )
            // Padding(
            //   padding: EdgeInsets.all(10),
            //   child: YoutubePlayer(
            //     controller: _youtubePlayerController,
            //     showVideoProgressIndicator: true,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

import 'package:hive/hive.dart';

part 'latest_item_model.g.dart';

@HiveType(typeId: 0)
class LatestItemModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String imageUrl;

  LatestItemModel({this.name, this.imageUrl});
}

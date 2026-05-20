import 'package:hive/hive.dart';

part 'favorite.g.dart';

@HiveType(typeId: 0)
class Favorite extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String imageUrl;

  @HiveField(3)
  double rating;

  Favorite({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.rating,
  });
}
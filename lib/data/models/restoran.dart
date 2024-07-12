import 'package:yandex_mapkit/yandex_mapkit.dart';

class Restoran {
  String restoranName;
  String addresName;
  Point addresPoint;
  String imgUrl;
  int number;
  double rating;

  Restoran({
    required this.restoranName,
    required this.addresName,
    required this.addresPoint,
    required this.imgUrl,
    required this.number,
    required this.rating,
  });
}

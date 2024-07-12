import 'dart:math';

import 'package:dars_55_home/blocs/restoran_state.dart';
import 'package:dars_55_home/data/models/restoran.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class RestoranCupit extends Cubit<RestoranState> {
  RestoranCupit() : super(InitialRestoran());
  List<Restoran> _restorans = [];

  void addRestoran(Restoran restoran) {
    emit(LoadingRestorans());
    _restorans.add(restoran);
    emit(LoadedRestorans(_restorans));
  }

  void removeRestoran(Restoran restoran) {
    emit(LoadingRestorans());
    _restorans.removeWhere((value) =>
        value.number == restoran.number &&
        restoran.addresPoint == restoran.addresPoint &&
        value.restoranName == restoran.restoranName);
    if (_restorans.length == 0) {
      emit(InitialRestoran());
    } else {
      emit(LoadedRestorans(_restorans));
    }
  }

  void editRestoran(int number, Restoran restoran) {
    emit(LoadingRestorans());
    int index = _restorans.indexWhere((value) => value.number == number);
    _restorans[index].restoranName = restoran.restoranName;
    _restorans[index].imgUrl = restoran.imgUrl;
    _restorans[index].number = restoran.number;
    _restorans[index].rating = restoran.rating;
    emit(LoadedRestorans(_restorans));
  }

  List<Restoran> get getDistanceRestorans {
    List<Restoran> distancesRestorans = [];
    Point myCurrentLocation = Point(
      latitude: 41.2856806,
      longitude: 69.9034646,
    );
    if (_restorans.length != 0) {
      for(int i = 0;i < _restorans.length;i++){
        double lat1 = myCurrentLocation.latitude;
        double lot1 = myCurrentLocation.longitude;
        double lat2 = _restorans[0].addresPoint.latitude;
        double lot2 = _restorans[0].addresPoint.longitude;
        double distanceInMeters = Geolocator.distanceBetween(lat1, lot1, lat2, lot2);
        if(distanceInMeters <= 60000){
          distancesRestorans.add(_restorans[i]);
        }
      }
    }
    // print(myCurrentLocation)
    return distancesRestorans;
  }
}

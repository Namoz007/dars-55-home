
import 'package:dars_55_home/data/models/restoran.dart';

sealed class RestoranState{}

final class InitialRestoran extends RestoranState{}

final class ErrosRestauran extends RestoranState{}

final class LoadingRestorans extends RestoranState{}

final class LoadedRestorans extends RestoranState{
  List<Restoran> restorans = [];

  LoadedRestorans(this.restorans);
}
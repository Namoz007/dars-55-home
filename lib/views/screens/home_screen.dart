import 'package:dars_55_home/blocs/restoran_cupit.dart';
import 'package:dars_55_home/services/yandex_map_services.dart';
import 'package:dars_55_home/views/widgets/custom_drawer.dart';
import 'package:dars_55_home/views/widgets/dialog_for_restoran.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late YandexMapController mapController;
  List<MapObject>? polylines;

  Point myCurrentLocation = const Point(
    latitude: 41.2856806,
    longitude: 69.9034646,
  );

  Point najotTalim = const Point(
    latitude: 41.2856806,
    longitude: 69.2034646,
  );

  void onMapCreated(YandexMapController controller) {
    mapController = controller;
    mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: najotTalim,
          zoom: 20,
        ),
      ),
    );
    setState(() {});
  }

  void onCameraPositionChanged(
      CameraPosition position,
      CameraUpdateReason reason,
      bool finished,
      ) async {
    myCurrentLocation = position.target;

    if (finished) {
      polylines =
      await YandexMapService.getDirection(najotTalim, myCurrentLocation);
    }
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    final cupit = context.read<RestoranCupit>();
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text("Restorans"),
        actions: [
          IconButton(
            onPressed: () async {
              final res = await mapController.getUserCameraPosition();
              mapController.moveCamera(
                CameraUpdate.zoomOut(),
              );
            },
            icon: Icon(Icons.remove_circle),
          ),
          IconButton(
            onPressed: () {
              mapController.moveCamera(
                CameraUpdate.zoomIn(),
              );
            },
            icon: Icon(Icons.add_circle),
          ),
        ],
      ),
      body: Stack(
        children: [
          YandexMap(
            onMapCreated: onMapCreated,
            onCameraPositionChanged: onCameraPositionChanged,
            mapType: MapType.map,
            mapObjects: [
              PlacemarkMapObject(
                mapId: const MapObjectId("najotTalim"),
                point: najotTalim,
                icon: PlacemarkIcon.single(
                  PlacemarkIconStyle(
                    image: BitmapDescriptor.fromAssetImage(
                      "assets/route_start.png",
                    ),
                  ),
                ),
              ),
              PlacemarkMapObject(
                mapId: const MapObjectId("myCurrentLocation"),
                point: myCurrentLocation ?? najotTalim,
                icon: PlacemarkIcon.single(
                  PlacemarkIconStyle(
                    image: BitmapDescriptor.fromAssetImage(
                      "assets/place.png",
                    ),
                  ),
                ),
              ),
              if(cupit.getDistanceRestorans.length != 0)
                for(int i = 0;i < cupit.getDistanceRestorans.length;i++)
                  PlacemarkMapObject(
                    mapId: MapObjectId("${cupit.getDistanceRestorans[i].restoranName}"),
                    point: cupit.getDistanceRestorans[i].addresPoint,
                    icon: PlacemarkIcon.single(
                      PlacemarkIconStyle(
                        image: BitmapDescriptor.fromAssetImage(
                          "assets/route_start.png",
                        ),
                      ),
                    ),
                  ),
            ],
          ),

        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await showDialog(context: context, builder: (context) => DialogForRestoran(point: myCurrentLocation,));
          setState(() {
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

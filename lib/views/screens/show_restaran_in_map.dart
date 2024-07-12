import 'package:dars_55_home/data/models/restoran.dart';
import 'package:dars_55_home/services/yandex_map_services.dart';
import 'package:dars_55_home/views/widgets/show_restoran_about.dart';
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';


class ShowRestoranInMap extends StatefulWidget {
  Restoran restoran;
  ShowRestoranInMap({super.key,required this.restoran});

  @override
  State<ShowRestoranInMap> createState() => _ShowRestoranInMapState();
}

class _ShowRestoranInMapState extends State<ShowRestoranInMap> {
  late YandexMapController mapController;
  List<MapObject>? polylines;
  bool isLoading = false;
  bool showRestoranAbout = false;
  Point myCurrentLocation = const Point(
    latitude: 41.2856806,
    longitude: 69.2034646,
  );

  Point restoran = Point(
    latitude: 41.2856806,
    longitude: 69.2034646,
  );

  void initState(){
    super.initState();
    restoran = widget.restoran.addresPoint;
  }



  void onMapCreated(YandexMapController controller) {
    mapController = controller;
    mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: restoran,
          zoom: 20,
        ),
      ),
    );
    setState(() {});
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.restoran.restoranName}"),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
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
      body: isLoading ? Center(child: CircularProgressIndicator(color: Colors.red,),) : Stack(
        children: [
          YandexMap(
            onMapCreated: onMapCreated,
            mapType: MapType.map,
            mapObjects: [
              PlacemarkMapObject(
                onTap: (value,sna){
                  setState(() {
                    showRestoranAbout = !showRestoranAbout;
                  });
                },
                mapId: MapObjectId("${widget.restoran.restoranName}"),
                point: restoran,
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
                point: myCurrentLocation,
                icon: PlacemarkIcon.single(
                  PlacemarkIconStyle(
                    image: BitmapDescriptor.fromAssetImage(
                      "assets/place.png",
                    ),
                  ),
                ),
              ),

              ...?polylines,

            ],
          ),

          showRestoranAbout ? Align(
            alignment: Alignment.bottomCenter,
            child: ShowRestoranAbout(restoran: widget.restoran,),
          ) : SizedBox()

        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          setState(() {
            isLoading = true;
          });
          polylines = [];
          polylines = await YandexMapService.getDirection(myCurrentLocation, widget.restoran.addresPoint);
          print("aslkfdkasjfds $polylines");
          setState(() {
            isLoading = false;
          });
        },
        child: Text("Go",style: TextStyle(fontSize: 18,color: Colors.red),),
      ),
    );
  }
}

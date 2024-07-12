import 'package:dars_55_home/blocs/restoran_cupit.dart';
import 'package:dars_55_home/blocs/restoran_state.dart';
import 'package:dars_55_home/data/models/restoran.dart';
import 'package:dars_55_home/views/screens/show_restaran_in_map.dart';
import 'package:dars_55_home/views/widgets/custom_drawer.dart';
import 'package:dars_55_home/views/widgets/dialog_for_restoran.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowRestorans extends StatefulWidget {
  bool isAdmin;
  ShowRestorans({super.key,this.isAdmin = false});

  @override
  State<ShowRestorans> createState() => _ShowRestoransState();
}

class _ShowRestoransState extends State<ShowRestorans> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restorans"),
      ),
      drawer: CustomDrawer(),
      body: BlocBuilder<RestoranCupit,RestoranState>(
        builder: (context,state){
          if(state is InitialRestoran)
            return const Center(child: Text("Hozircha hech qanaqa restoran mavjud emas"),);

          if(state is ErrosRestauran)
            return const Center(child: Text("Restoranlarni olishda xatolik yuzga keldi"),);

          if(state is LoadingRestorans)
            return const Center(child: CircularProgressIndicator(color: Colors.red,),);

          List<Restoran> restorans = (state as LoadedRestorans).restorans;
          return ListView.builder(
            itemCount: restorans.length,
            itemBuilder: (context,index){
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShowRestoranInMap(restoran: restorans[index],)));
                },
                child: Container(
                  width: double.infinity,
                  height: 150,
                  margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey),
                      image: DecorationImage(
                          image: NetworkImage("${restorans[index].imgUrl}"),fit: BoxFit.cover
                      )
                  ),
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.isAdmin ? Column(
                        children: [
                          Row(
                            children: [
                              IconButton(onPressed: (){
                                showDialog(context: context, builder: (context) => DialogForRestoran(point: restorans[index].addresPoint,isAdmin: true,phoneNumber: restorans[index].number,));
                              }, icon: Icon(Icons.edit,color: Colors.amber,),),
                              IconButton(onPressed: (){
                                context.read<RestoranCupit>().removeRestoran(restorans[index]);
                              }, icon: Icon(Icons.delete,color: Colors.red,),),
                            ],
                          )
                        ],
                      ) : SizedBox(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${restorans[index].restoranName}",style: TextStyle(fontSize: 18,color: Colors.white),),
                          Text("${restorans[index].addresName}",style: TextStyle(fontSize: 18,color: Colors.white),),
                          Row(
                            children: [
                              Text("${restorans[index].rating}",style: TextStyle(fontSize: 18,color: Colors.amber),),Icon(Icons.star,color: Colors.amber,)
                            ],
                          )
                        ],
                      ),

                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

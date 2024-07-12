import 'package:dars_55_home/data/models/restoran.dart';
import 'package:flutter/material.dart';

class ShowRestoranAbout extends StatefulWidget {
  Restoran restoran;
  ShowRestoranAbout({super.key,required this.restoran});

  @override
  State<ShowRestoranAbout> createState() => _ShowRestoranAboutState();
}

class _ShowRestoranAboutState extends State<ShowRestoranAbout> {
  @override
  Widget build(BuildContext context) {
    print("flkasjfdlkasdf");
    return AnimatedContainer(
      duration: Duration(seconds: 5),
      height: 150,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 50),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.red
      ),
      child: Row(
        children: [
          Container(
            width: 180,
            height: 150,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("${widget.restoran.imgUrl}"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),topLeft: Radius.circular(25))
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("${widget.restoran.restoranName}",style: TextStyle(fontSize: 18,color: Colors.white),),
              Row(
                children: [
                  Icon(Icons.place,color: Colors.white,),
                  Text("${widget.restoran.addresName}",style: TextStyle(fontSize: 18,color: Colors.white),)
                ],
              ),
              Row(
                children: [
                  Icon(Icons.phone,color: Colors.white,),
                  Text(" ${widget.restoran.number}",style: TextStyle(fontSize: 18,color: Colors.white),)
                ],
              ),
              Row(
                children: [
                  Icon(Icons.star,color: Colors.white,),
                  Text("${widget.restoran.rating}",style: TextStyle(fontSize: 18,color: Colors.white),)
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

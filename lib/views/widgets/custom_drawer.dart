import 'package:dars_55_home/views/screens/home_screen.dart';
import 'package:dars_55_home/views/screens/show_restorans.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(height: 20,),
          InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            child: ListTile(
              title: Text("Add Restoran"),
              trailing: Icon(Icons.arrow_right),
            ),
          ),
          SizedBox(height: 20,),

          InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ShowRestorans()));
            },
            child: ListTile(
              title: Text("Show Restorans"),
              trailing: Icon(Icons.arrow_right),
            ),
          ),

          SizedBox(height: 20,),

          InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ShowRestorans(isAdmin: true,)));
            },
            child: ListTile(
              title: Text("Admin panel"),
              trailing: Icon(Icons.arrow_right),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:dars_55_home/blocs/restoran_cupit.dart';
import 'package:dars_55_home/data/models/restoran.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class DialogForRestoran extends StatefulWidget {
  Point point;
  bool isAdmin;
  int phoneNumber;
  DialogForRestoran({super.key, required this.point, this.isAdmin = false,this.phoneNumber = 0});

  @override
  State<DialogForRestoran> createState() => _DialogForRestoranState();
}

class _DialogForRestoranState extends State<DialogForRestoran> {
  final _formKey = GlobalKey<FormState>();
  final restoranName = TextEditingController();
  String restoranAdress = '';
  final restoranImgUrl = TextEditingController();
  final restoranPhoneNumber = TextEditingController();
  double rating = 0.0;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.isAdmin ? Text("Edit restoran") : Text("Add Restoran"),
      content: isLoading
          ? CircularProgressIndicator(
        color: Colors.red,
      )
          : Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Restoran nomi bosh bolmasligi kerak";
                  }
                },
                controller: restoranName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  hintText: widget.isAdmin ? "New name" : "Restoran name",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Restoran surati bosh bolmasligi kerak";
                  }

                  if (value.endsWith(".jpeg") ||
                      value.endsWith(".jpg") ||
                      value.endsWith(".png")) {
                    return null;
                  }
                  return 'Restoran surati no togri format kiritidingiz. Restoran formati jpeg, jpg yoki png formatda bolishi kerak';
                },
                controller: restoranImgUrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  hintText: widget.isAdmin ? "New img url" :  "Restoran img url",),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Restoran telefon raqami bosh bolmasligi kerak";
                  }

                  try {
                    int.parse(value);
                    return null;
                  } catch (e) {
                    return "Restoran telefon raqami no togri formatda kiritdingiz.";
                  }
                },
                controller: restoranPhoneNumber,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  hintText: widget.isAdmin ? "New phone number" : "Restoran phone number",
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (double i = 1; i <= 5; i++)
                    InkWell(
                      onTap: () {
                        setState(() {
                          rating = i;
                        });
                      },
                      child: Icon(
                        Icons.star,
                        color: rating >= i ? Colors.amber : Colors.black,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Bekor qilish")),
        ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  isLoading = true;
                });
                final search = await YandexSearch.searchByPoint(
                    point: widget.point, searchOptions: SearchOptions());
                SearchSessionResult session = await search.$2;
                SearchItem addres = session.items![0];
                if(widget.isAdmin){
                  context.read<RestoranCupit>().editRestoran(widget.phoneNumber, Restoran(restoranName: restoranName.text, addresName: addres.name, addresPoint: widget.point, imgUrl: restoranImgUrl.text, number: int.parse(restoranPhoneNumber.text), rating: rating));
                }else{
                  context.read<RestoranCupit>().addRestoran(Restoran(
                      restoranName: restoranName.text,
                      addresName: addres.name,
                      addresPoint: widget.point,
                      imgUrl: restoranImgUrl.text,
                      number: int.parse(restoranPhoneNumber.text),
                      rating: rating));
                }
                setState(() {
                  isLoading = false;
                });
                Navigator.pop(context);
              }
            },
            child: Text("Saqlash"))
      ],
    );
  }
}

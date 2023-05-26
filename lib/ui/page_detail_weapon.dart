import 'package:flutter/material.dart';
import 'package:preresponsi/model/detail_weapon_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../base/api_data_source.dart';

class PageDetailWeapon extends StatefulWidget {
  final name;
  const PageDetailWeapon({Key? key, required this.name}) : super(key: key);

  @override
  State<PageDetailWeapon> createState() => _PageDetailWeaponState();
}

class _PageDetailWeaponState extends State<PageDetailWeapon> {

  _lastSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('last_seen', widget.name);
    prefs.setString('type', 'weapons');
  }

  @override
  void initState(){
    super.initState();
    _lastSeen();
  }

  // capitalized the first letter in a word / sentence
  String capitalized(){
    var strName = widget.name;
    var result = strName[0].toUpperCase();
    bool cap = true;
    for (int i = 1; i < strName.length; i++) {
      if (strName[i - 1] == " " && cap == true) {
        result = result + strName[i].toUpperCase();
      } else {
        result = result + strName[i];
        cap = false;
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
                title: Text("Detail " + capitalized())
            ),
            body: SingleChildScrollView(
                child: _buildDetailCharaBody(widget.name)
            )
        )
    );
  }
}

Widget _buildDetailCharaBody(name){
  return Container(
    child: FutureBuilder(
      future: ApiDataSource.instance.loadDetailWeapon(name),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasError){
          return _buildErrorSection();
        }
        if(snapshot.hasData){
          DetailWeaponModel detailWeaponModel = DetailWeaponModel.fromJson(snapshot.data);
          return _buildSuccessSection(context, detailWeaponModel);
        }
        return _buildLoadingSection();
      },
    ),
  );
}

Widget _buildErrorSection(){
  return Container(
    child: Text("Error Occured"),
  );
}

Widget _buildLoadingSection(){
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator()
      ],
    ),
  );
}

Widget _buildSuccessSection(BuildContext context, DetailWeaponModel data){
  return Container(
      child: Column(
        children: [
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(data.name!,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.0
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(data.rarity!, (index) =>
                          Icon(Icons.star,
                              color: Colors.white
                          )
                      )
                  ),
                  Text(data.type!,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0
                      )
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(data.passiveName!,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0
                    )
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(data.passiveDesc!,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      )
  );
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:preresponsi/base/api_data_source.dart';
import 'package:preresponsi/ui/page_detail_character.dart';
import 'package:preresponsi/ui/page_detail_weapon.dart';

class PageListWeapon extends StatefulWidget {
  const PageListWeapon({Key? key}) : super(key: key);

  @override
  State<PageListWeapon> createState() => _PageListWeaponState();
}

class _PageListWeaponState extends State<PageListWeapon> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('List Weapon'),
          ),
          body: Container(
            child: FutureBuilder<List<dynamic>>(
              future: ApiDataSource.instance.loadWeapon(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
                if(snapshot.hasError){
                  return _buildErrorSection();
                }
                if(snapshot.hasData){
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index){
                        return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => PageDetailWeapon(name: snapshot.data[index]))
                              );
                            },
                            child: Card(
                              child: Row(
                                children: [
                                  Container(
                                    //padding: EdgeInsets.all(8.0),
                                    width: 100,
                                    child: Image.network("https://api.genshin.dev/weapons/" + snapshot.data[index] + "/icon",
                                        fit: BoxFit.cover
                                    ),
                                  ),
                                  SizedBox(width: 20.0),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(snapshot.data[index].toUpperCase()),
                                    ],
                                  )
                                ],
                              ),
                            )
                        );
                      }
                  );
                  //print(snapshot.data);
                }
                return _buildLoadingSection();
              },
            ),
          ),
        )
    );
  }
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
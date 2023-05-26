import 'package:flutter/material.dart';
import 'package:preresponsi/model/detail_char_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../base/api_data_source.dart';

class PageDetailCharacter extends StatefulWidget {
  final name;
  const PageDetailCharacter({Key? key, required this.name}) : super(key: key);

  @override
  State<PageDetailCharacter> createState() => _PageDetailCharacterState();
}

class _PageDetailCharacterState extends State<PageDetailCharacter> {

  _lastSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('last_seen', widget.name);
    prefs.setString('type', 'characters');
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
      future: ApiDataSource.instance.loadDetailChara(name),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasError){
          return _buildErrorSection();
        }
        if(snapshot.hasData){
          DetailCharModel detailCharModel = DetailCharModel.fromJson(snapshot.data);
          return _buildSuccessSection(context, detailCharModel);
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

Widget _buildSuccessSection(BuildContext context, DetailCharModel data){
  return Container(
    child: Column(
      children: [
        Container(
          child: Image.network("https://api.genshin.dev/characters/" + data.name!.toLowerCase() + "/gacha-splash")
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network("https://api.genshin.dev/nations/" + data.nation!.toLowerCase() + "/icon",
              width: 70.0,
            ),
            Image.network("https://api.genshin.dev/elements/" + data.vision!.toLowerCase() + "/icon"),
            Text(data.name!,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.0
              )
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // star generator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(data.rarity!, (index) =>
                      Icon(Icons.star,
                          color: Colors.white
                      )
                  )
                ),
                Text(data.affiliation!,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0
                    )
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(data.description!,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0
              ),
              textAlign: TextAlign.justify,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 14.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                      child: Image.network("https://api.genshin.dev/characters/" + data.name!.toLowerCase() + "/talent-na",
                          width: 80.0
                      )
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                      flex: 2,
                      child: Container(
                        child: Text(data.skillTalents![0].description.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.0
                          ),
                        )
                      )
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Container(
                      child: Image.network("https://api.genshin.dev/characters/" + data.name!.toLowerCase() + "/talent-burst",
                          width: 80.0
                      )
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                      flex: 2,
                      child: Container(
                          child: Text(data.skillTalents![1].description.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.0
                            ),
                          )
                      )
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Container(
                      child: Image.network("https://api.genshin.dev/characters/" + data.name!.toLowerCase() + "/talent-skill",
                          width: 80.0
                      )
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                      flex: 2,
                      child: Container(
                          child: Text(data.skillTalents![2].description.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.0
                            ),
                          )
                      )
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Container(
                      child: Image.network("https://api.genshin.dev/characters/" + data.name!.toLowerCase() + "/talent-passive-0",
                          width: 80.0
                      )
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                      flex: 2,
                      child: Container(
                          child: Text(data.passiveTalents![0].description.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.0
                            ),
                          )
                      )
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Container(
                      child: Image.network("https://api.genshin.dev/characters/" + data.name!.toLowerCase() + "/talent-passive-1",
                          width: 80.0
                      )
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                      flex: 2,
                      child: Container(
                          child: Text(data.passiveTalents![1].description.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.0
                            ),
                          )
                      )
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Container(
                      child: Image.network("https://api.genshin.dev/characters/" + data.name!.toLowerCase() + "/talent-passive-2",
                          width: 80.0
                      )
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                      flex: 2,
                      child: Container(
                          child: Text(data.passiveTalents![2].description.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.0
                            ),
                          )
                      )
                  ),
                ],
              ),
            ],
          )
        )
        // Container(
        //   padding: EdgeInsets.symmetric(vertical: 14.0),
        //   child: Column(
        //     children: [
        //       Row(
        //         children: [
        //           Image.network("https://api.genshin.dev/characters/" + data.name!.toLowerCase() + "/talent-na",
        //             width: 80.0
        //           ),
        //           SizedBox(width: 6.0),
        //           Text(data.skillTalents![0].description.toString(),
        //             style: TextStyle(
        //               color: Colors.white,
        //               fontSize: 12.0
        //             ),
        //           )
        //         ],
        //       ),
        //       Row(
        //         children: [
        //           Image.network("https://api.genshin.dev/characters/" + data.name!.toLowerCase() + "/talent-burst",
        //               width: 80.0
        //           ),
        //           SizedBox(width: 6.0),
        //           Text(data.skillTalents![1].description.toString(),
        //             style: TextStyle(
        //                 color: Colors.white,
        //                 fontSize: 12.0
        //             )
        //           )
        //         ],
        //       ),
        //       Row(
        //         children: [
        //           Image.network("https://api.genshin.dev/characters/" + data.name!.toLowerCase() + "/talent-skill",
        //               width: 80.0
        //           ),
        //           SizedBox(width: 6.0),
        //           Text(data.skillTalents![1].description.toString(),
        //             style: TextStyle(
        //                 color: Colors.white,
        //                 fontSize: 12.0
        //             ),
        //           )
        //         ],
        //       ),
        //       Row(
        //         children: [
        //           Image.network("https://api.genshin.dev/characters/" + data.name!.toLowerCase() + "/talent-passive-0",
        //               width: 80.0
        //           ),
        //           SizedBox(width: 6.0),
        //           Text(data.passiveTalents![0].description.toString(),
        //             style: TextStyle(
        //                 color: Colors.white,
        //                 fontSize: 12.0
        //             ),
        //           )
        //         ],
        //       ),
        //       Row(
        //         children: [
        //           Image.network("https://api.genshin.dev/characters/" + data.name!.toLowerCase() + "/talent-passive-1",
        //               width: 80.0
        //           ),
        //           SizedBox(width: 6.0),
        //           Text(data.passiveTalents![1].description.toString(),
        //             style: TextStyle(
        //                 color: Colors.white,
        //                 fontSize: 12.0
        //             ),
        //           )
        //         ],
        //       ),
        //       Row(
        //         children: [
        //           Image.network("https://api.genshin.dev/characters/" + data.name!.toLowerCase() + "/talent-passive-2",
        //               width: 80.0
        //           ),
        //           SizedBox(width: 6.0),
        //           Text(data.passiveTalents![2].description.toString(),
        //             style: TextStyle(
        //                 color: Colors.white,
        //                 fontSize: 12.0
        //             ),
        //           )
        //         ],
        //       )
        //     ],
        //   ),
        // )
      ],
    )
  );
}
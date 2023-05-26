import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:preresponsi/base/api_data_source.dart';
import 'package:preresponsi/ui/page_detail_character.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageListCharacter extends StatefulWidget {
  const PageListCharacter({Key? key}) : super(key: key);

  @override
  State<PageListCharacter> createState() => _PageListCharacterState();
}

class _PageListCharacterState extends State<PageListCharacter> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('List Character'),
          ),
          body: Container(
            child: FutureBuilder<List<dynamic>>(
              future: ApiDataSource.instance.loadChara(),
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PageDetailCharacter(name: snapshot.data[index]))
                            );
                          },
                          child: Card(
                            child: Row(
                              children: [
                                Container(
                                  //padding: EdgeInsets.all(8.0),
                                  width: 100,
                                  child: Image.network("https://api.genshin.dev/characters/" + snapshot.data[index] + "/icon",
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

// Widget _buildSuccessSection(data){
//   return ListView.builder(
//     itemCount: data.length, // ! means data tidak null, ? means data bisa null
//     itemBuilder: (context, index){
//       return _buildItemUsers(data[index]); //hanya memanggil array asosiatif dalam data
//     },
//   );
// }

// Widget _buildItemUsers(charaData){
//   return InkWell(
//     onTap: (){
//       //Navigator.push(context, MaterialPageRoute(builder: (context) => ));
//     },
//     child: Card(
//       child: Row(
//         children: [
//           Container(
//             width: 100,
//             child: Image.network(charaData.name),
//           ),
//           SizedBox(width: 20.0),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//             ],
//           )
//         ],
//       ),
//     ),
//   );
// }


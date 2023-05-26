import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:preresponsi/ui/page_detail_character.dart';
import 'package:preresponsi/ui/page_detail_weapon.dart';
import 'package:preresponsi/ui/page_list_character.dart';
import 'package:preresponsi/ui/page_list_weapon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _lastSeen;
  String? _type;

  _getLastSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _lastSeen = prefs.getString('last_seen');
      _type = prefs.getString('type');
    });
  }

  @override
  void initState(){
    super.initState();
    _lastSeen = "";
    _type = "";
    _getLastSeen();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://4.bp.blogspot.com/-iz7Z_jLPL6E/XQ8eHVZTlnI/AAAAAAAAHtA/rDn9sYH174ovD4rbxsC8RSBeanFvfy75QCKgBGAs/w1440-h2560-c/genshin-impact-characters-uhdpaper.com-4K-2.jpg'),
                fit: BoxFit.cover,
                //opacity: 1.0
                colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken)
              )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset('assets/logo-genshin.png', width: 350.0),
                if(_lastSeen != null && _lastSeen != "")
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                    child: Card(
                      child: ListTile(
                        onTap: () async {
                          if (_type == "weapons") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PageDetailWeapon(name: _lastSeen!),
                                )
                            );
                          }else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PageDetailCharacter(name: _lastSeen!),
                                )
                            );
                          }
                        },
                        leading: Image.network('https://api.genshin.dev/${_type}/${_lastSeen!.toLowerCase()}/icon'),
                        title: Text(_lastSeen.toString().toUpperCase()),
                      ),
                    ),
                  ),
                Container(
                  child: Column(
                    children: [
                      ElevatedButton(
                          onPressed: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => PageListCharacter())
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(150.0, 10.0)
                          ),
                          child: Text('Karakter')
                      ),
                      ElevatedButton(
                          onPressed: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => PageListWeapon())
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(150.0, 10.0)
                          ),
                          child: Text('Weapon')
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}

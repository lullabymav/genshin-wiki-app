import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:preresponsi/ui/page_list_character.dart';
import 'package:preresponsi/ui/page_list_weapon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  addSF() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 100.0),
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/logo-genshin.png'),
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

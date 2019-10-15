import 'package:caminantapp/profile.dart';
import 'package:caminantapp/request.dart';
import 'package:caminantapp/settings.dart';
import 'package:caminantapp/storage.dart';
import 'package:flutter/material.dart';
import 'globals.dart';

class Home extends StatefulWidget {
  
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>{

  final List<String> titles = [
    'Perfil',
    'Configuración'
  ];

  final List<Widget> pages = [
    Profile(),
    Settings()
  ];

  final List<IconData> icons = [
    Icons.person,
    Icons.settings
  ];

  _request() async {
    Map<String, dynamic> body = {
      'query': """
        query feed {
          getMyUser {
            username
            email
            avatar
          }
        }
      """,
    };
    print("Peticion");
    Map<String, dynamic> res = await postAuth(body);
    return res;
  }

  Widget _drawerTile(BuildContext context, String title, IconData icon, Widget page) {
    return Material(
      child: InkWell(
        splashColor: Colors.orange,
        child: ListTile(
          title: Text(title),
          leading: Icon(icon),
        ),
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => page
            )
          );
        },
      ),
    );
  }

  Widget _drawerHeader() {
    return DrawerHeader(
      padding: EdgeInsets.all(0),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/default_bg.jpg'),
                fit: BoxFit.cover,
              )
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset.center,
                end: FractionalOffset.bottomCenter,
                colors: [Colors.transparent, Colors.black]
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: Colors.white, width: 1),
                      image: DecorationImage(
                        image: ( user.containsKey('avatar') && user['avatar'] != null ?
                          NetworkImage(user['avatar']) :
                          AssetImage('assets/images/user.png')
                        ),
                        fit: BoxFit.cover,
                      )
                    ),
                  )
                ),
                Text(user['username'], style: TextStyle(fontSize: 24, color: Colors.white)),
                Text(user['email'], style: TextStyle(fontSize: 12, color: Colors.white)),
              ],
            )
          )
        ],
      )
    );
  }

  Widget _drawer(BuildContext context) {
    return Drawer(
      child: ListView.builder(
        itemCount: pages.length+2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _drawerHeader();
          } else if (index == pages.length + 1) {
            return Material(
              child: InkWell(
                splashColor: Colors.orange,
                child: ListTile(
                  title: Text('Cerrar Sesion'),
                  leading: Icon(Icons.exit_to_app),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, 'login');
                  removeToken();
                },
              ),
            );
          }
          return _drawerTile(context, titles[index - 1], icons[index - 1], pages[index - 1]);
        },
      ),
    );
  }

  Widget _createCard(String title) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 150,
            color: Colors.black38,
          ),
          ListTile(
            contentPadding: EdgeInsets.only(
              top: 16, left: 16, right: 16
            ),
            //leading: Icon(Icons.album),
            title: Text(title),
            subtitle: Text('Lorem ipsum, dolor sit amet consectetur adipisicing elit. Nihil quidem reiciendis, omnis sint at non sunt porro, rem est dolorem. '),
          ),
          ButtonTheme.bar( // make buttons use the appropriate styles for cards
            child: ButtonBar(
              children: <Widget>[ 
                FlatButton(
                  child: const Text('VER MAS'),
                  onPressed: () { /* ... */ },
                ),
              ],
            ),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric( horizontal: 8, vertical: 8),
    );
  }

  Widget _feed() {
    return ListView.builder(
      itemBuilder: (context, index) => _createCard("Evento ${index+1}"),
      itemCount: 20,
    );
  }

  BottomNavigationBarItem _createNavItem(String title, IconData icon) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      activeIcon: Icon(icon),
      title: Text(title),
    );
  }

  Widget _bottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        _createNavItem('Lista', Icons.list),
        _createNavItem('Mapa', Icons.map),
      ],
      currentIndex: currentFilter,
      onTap: (index) {
        setState(() {
          currentFilter = index;
        });
      }
    );
  }

  Widget _body(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    if (snapshot.hasData) {
      Map<String, dynamic> res = snapshot.data['data']['getMyUser'];
      user['username'] = res['username'];
      user['email'] = res['email'];
      user['avatar'] = res['avatar'];
      return _feed();
    } else if (snapshot.hasError) {
      print(snapshot);
      return Center(child: Text('Error', style: TextStyle(fontSize: 24)));
    } 
    return Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) => _body(context, snapshot),
        future: _request(),
      ),
      drawer: _drawer(context),
      bottomNavigationBar: _bottomNav()
    );
  }
}
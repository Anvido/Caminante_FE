import 'package:caminantapp/profile.dart';
import 'package:caminantapp/settings.dart';
import 'package:caminantapp/storage.dart';
import 'package:flutter/material.dart';
import 'globals.dart';

class Home extends StatelessWidget {

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

  Widget _drawer(BuildContext context) {
    return Drawer(
      child: ListView.builder(
        itemCount: pages.length+2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return DrawerHeader(
              child: Text('Nombre de perfil'),
              decoration: BoxDecoration(
                color: Colors.black38,
              ),
            );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Feed(),
      drawer: _drawer(context),
      bottomNavigationBar: BottomNavBar()
    );
  }
}

class Feed extends StatefulWidget {
  @override
  State<Feed> createState() => FeedState();
}

class FeedState extends State<Feed> {

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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => _createCard("Evento ${index+1}"),
      itemCount: 20,
    );
  }
}

class BottomNavBar extends StatefulWidget {

  @override
  State<BottomNavBar> createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {

  var current = 0;
  final List<String> itemTitles = [
    'Transporte',
    'Deportes',
    'Comida'
  ];
  final List<IconData> itemIcons = [
    Icons.directions_car,
    Icons.favorite,
    Icons.fastfood
  ];

  BottomNavigationBarItem _createNavItem(String title, IconData icon) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      activeIcon: Icon(icon),
      title: Text(title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        _createNavItem('Todos', Icons.star),
        _createNavItem('Transporte', Icons.directions_car),
        _createNavItem('Deportes', Icons.directions_bike),
        _createNavItem('Comida', Icons.fastfood),
      ],
      currentIndex: currentFilter,
      onTap: (index) {
        setState(() {
          currentFilter = index;
        });
      }
    );
  }

}
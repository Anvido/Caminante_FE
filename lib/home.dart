import 'package:caminantapp/profile.dart';
import 'package:caminantapp/settings.dart';
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
        itemCount: pages.length+1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.black38,
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

  Widget _createCard() {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            leading: Icon(Icons.album),
            title: Text('The Enchanted Nightingale'),
            subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
          ),
          ButtonTheme.bar( // make buttons use the appropriate styles for cards
            child: ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('BUY TICKETS'),
                  onPressed: () { /* ... */ },
                ),
                FlatButton(
                  child: const Text('LISTEN'),
                  onPressed: () { /* ... */ },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => _createCard(),
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
      items: <BottomNavigationBarItem>[
        /*BottomNavigationBarItem(
          icon: Icon(Icons.star),
          activeIcon: Icon(Icons.star),
          title: Text('Todos'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star),
          activeIcon: Icon(Icons.star),
          title: Text('Todos'),
        ),*/
        //_createNavItem('Todos', Icons.star),
        _createNavItem('Transporte', Icons.directions_car),
        _createNavItem('Deportes', Icons.fast_forward),
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
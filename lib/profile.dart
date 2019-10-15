import 'package:flutter/material.dart';
import 'globals.dart';

class Profile extends StatefulWidget {

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final String title = "Perfil";
  int followee = 0;
  int followers = 0;
  String image;

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

  Widget _profileHeader() {
    return Stack(
      children: <Widget>[
        Container(
          height: 175,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/default_bg.jpg'),
              fit: BoxFit.cover,
            )
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 125, left: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Container(
                  width: 92,
                  height: 92,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    image: DecorationImage(
                      image: ( user.containsKey('avatar') && user['avatar'] != null ?
                        NetworkImage(user['avatar']) :
                        AssetImage('assets/images/user.png')
                      ),
                      fit: BoxFit.cover,
                    )
                  )  
                )
              ),
              Text(user['username'], style: TextStyle(fontSize: 24, color: Colors.black)),
              Text(user['email'], style: TextStyle(fontSize: 16, color: Colors.grey)),
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('$followee',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(' Siguiendo', style: TextStyle(fontSize: 16)),
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text('$followers',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    Text(' Seguidores', style: TextStyle(fontSize: 16)),
                  ],
                )
              )
            ],
          )
        )
      ],
    );
  }

  Widget _body(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: EdgeInsets.only(bottom: 32),
                child: _profileHeader(),
              )
            )
          );
        }
        return _createCard("Evento ${index+1}");
      },
      itemCount: 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil"),
      ),
      body: _body(context),
    );
  }
}
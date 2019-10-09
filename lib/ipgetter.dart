import 'package:caminantapp/request.dart';
import 'package:flutter/material.dart';

class IpGetter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IpForm()
    );
  }
}

class IpForm extends StatefulWidget {
  @override
  State<IpForm> createState() => IpFormState(); 
}

class IpFormState extends State<IpForm> {

  var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              bottom: 32
            ),
            child: Text("Ingresar IP",
              style: TextStyle(
                fontSize: 32
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 32
            ),
            child: TextFormField(
              validator: (val) {
                if (val.split(".").length < 4) {
                  return "Dirección no valida";
                }
                return null;
              },
              controller: controller,
              onEditingComplete: () {
                print(controller.text);
                saveIp(controller.text).then(
                  (res) {
                    getHttp('/connect').then(
                      (res){
                        Navigator.of(context).pushReplacementNamed('verify');
                      }
                    ).catchError(
                      (err) {
                        print(err);
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text('El servidor no esta en esa IP')
                          )
                        );
                      }
                    );
                  }
                );
              },
            ),
          )
        ]
      )
    );    
  }
}
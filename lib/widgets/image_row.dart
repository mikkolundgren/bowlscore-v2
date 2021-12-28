import 'package:flutter/material.dart';
import '../model/app_model.dart';
import '../services/service_locator.dart';

class ImageRowWidget extends StatefulWidget {

  _ImageRowWidgetState createState() => _ImageRowWidgetState();
}

class _ImageRowWidgetState extends State<ImageRowWidget> {
  @override
  initState() {
    //getIt<AppModel>().addListener(update);
    super.initState();
  }

  //update() => setState(() => {});

  @override
  Widget build(BuildContext context) {
    var appModel = locator<AppModel>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Ink(
          decoration: ShapeDecoration(
            color: appModel.bowler == 'Aku' ? Colors.blue : Colors.white,
            shape: Border.all(),
          ),
          child: IconButton(
            icon: Image.asset('assets/aku.jpg'),
            iconSize: 60.0,
            onPressed: () {
              appModel.setBowler('Aku');
              //_fetchScores('Aku', 1);
            },
          ),
        ),
        Ink(
          decoration: ShapeDecoration(
            color: appModel.bowler == 'Mikko' ? Colors.blue : Colors.white,
            shape: Border.all(),
          ),
          child: IconButton(
            icon: Image.asset('assets/mikko.jpg'),
            iconSize: 60.0,
            onPressed: () {
              appModel.setBowler('Mikko');
              //_fetchScores('Mikko', 2);
            },
          ),
        ),
        Ink(
          decoration: ShapeDecoration(
            color: appModel.bowler == 'Olli' ? Colors.blue : Colors.white,
            shape: Border.all(),
          ),
          child: IconButton(
            icon: Image.asset('assets/olli.jpg'),
            iconSize: 60.0,
            onPressed: () {
              appModel.setBowler('Olli');
              //_fetchScores('Olli', 3);
            },
          ),
        )
      ],
    );
  }

  int _imagePressed = 0;

  int get imagePressed => _imagePressed;
}

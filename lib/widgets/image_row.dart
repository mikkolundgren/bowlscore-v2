import 'package:flutter/material.dart';
import '../model/app_model.dart';
import '../services/service_locator.dart';

class ImageRowWidget extends StatefulWidget {
  const ImageRowWidget({Key? key}) : super(key: key);

  @override
  _ImageRowWidgetState createState() => _ImageRowWidgetState();
}

class _ImageRowWidgetState extends State<ImageRowWidget> {
  String _activeBowler = 'Aku';

  @override
  initState() {
    //getIt<AppModel>().addListener(update);
    super.initState();
  }

  _highlitePic(String bowler) {
    setState(() {
      _activeBowler = bowler;
    });
  }

  @override
  Widget build(BuildContext context) {
    var appModel = locator<AppModel>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Ink(
          decoration: ShapeDecoration(
            color: _activeBowler == 'Aku' ? Colors.blue : Colors.white,
            shape: Border.all(),
          ),
          child: IconButton(
            icon: Image.asset('assets/aku.jpg'),
            iconSize: 60.0,
            onPressed: () {
              appModel.setBowler('Aku');
              _highlitePic('Aku');
              //_fetchScores('Aku', 1);
            },
          ),
        ),
        Ink(
          decoration: ShapeDecoration(
            color: _activeBowler == 'Mikko' ? Colors.blue : Colors.white,
            shape: Border.all(),
          ),
          child: IconButton(
            icon: Image.asset('assets/mikko.jpg'),
            iconSize: 60.0,
            onPressed: () {
              appModel.setBowler('Mikko');
              _highlitePic('Mikko');
              //_fetchScores('Mikko', 2);
            },
          ),
        ),
        Ink(
          decoration: ShapeDecoration(
            color: _activeBowler == 'Olli' ? Colors.blue : Colors.white,
            shape: Border.all(),
          ),
          child: IconButton(
            icon: Image.asset('assets/olli.jpg'),
            iconSize: 60.0,
            onPressed: () {
              _highlitePic('Olli');
              appModel.setBowler('Olli');
              //_fetchScores('Olli', 3);
            },
          ),
        )
      ],
    );
  }

  final int _imagePressed = 0;

  int get imagePressed => _imagePressed;
}

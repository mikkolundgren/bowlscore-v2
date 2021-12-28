// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../widgets/bowlbar.dart';
import '../services/backend.dart';
import '../widgets/image_row.dart';
import '../services/service_locator.dart';
import '../model/app_model.dart';

class ListScores extends StatefulWidget {
  const ListScores({Key? key}) : super(key: key);

  @override
  _ListScoresState createState() => _ListScoresState();
}

class _ListScoresState extends State<ListScores> {
  String _currentBowler = 'Aku';

  @override
  initState() {
    locator<AppModel>().addListener(update);
    super.initState();
  }

  update() {
    if (!mounted) {
      return;
    }
    setState(() {
      _currentBowler = locator<AppModel>().bowler;
      if (kDebugMode) {
        print('currentBowler $_currentBowler');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BowlBar(title: "Scores"),
      body: Container(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 40.0),
            ),
            const ImageRowWidget(),
            _scoreListFuture(),
          ],
        ),
      ),
    );
  }

  Widget _scoreListFuture() {
    return FutureBuilder(
        future: listScores(_currentBowler),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          return scoreList(snapshot.data);
        });
  }

  Widget scoreList(data) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: data.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, i) {
          return _buildRow(data[i]);
        },
      ),
    );
  }

  Widget _buildRow(Score score) {
    return ListTile(
      title: Text("${score.date}    ${score.score}"),
    );
  }
}

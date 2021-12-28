import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/bowlbar.dart';
import 'dart:math';

import '../services/firebase_service.dart' as fb;

class FBListScores extends StatefulWidget {
  const FBListScores({Key? key}) : super(key: key);

  @override
  _FBListScoresState createState() => _FBListScoresState();
}

class _FBListScoresState extends State<FBListScores> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BowlBar(title: "Scores"),
      body: Container(
        padding: const EdgeInsets.all(40.0),
        child: _scores(),
      ),
    );
  }

  StreamBuilder<QuerySnapshot> _scores() {
    return StreamBuilder<QuerySnapshot>(
      stream: fb.getScores(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          default:
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                return _scoreRow(document);
              }).toList(),
            );
        }
      },
    );
  }

  Widget _heading(DocumentSnapshot document) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(document['date']),
          Text(document['serie'].toString()),
        ],
      ),
    );
  }

  Widget _score(DocumentSnapshot document) {
    List<int> scores = [
      document['akuScore'],
      document['mikkoScore'],
      document['olliScore']
    ];
    var highest = scores.reduce(max);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: <Widget>[
            const Text('Aku'),
            Text(
              document['akuScore'].toString(),
              style: TextStyle(
                color: document['akuScore'] == highest
                    ? Colors.green
                    : Colors.black,
              ),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            const Text('Mikko'),
            Text(
              document['mikkoScore'].toString(),
              style: TextStyle(
                color: document['mikkoScore'] == highest
                    ? Colors.green
                    : Colors.black,
              ),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            const Text('Olli'),
            Text(
              document['olliScore'].toString(),
              style: TextStyle(
                color: document['olliScore'] == highest
                    ? Colors.green
                    : Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _scoreRow(DocumentSnapshot document) {
    return Card(
      child: Column(
        children: <Widget>[
          _heading(document),
          const Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          _score(document),
        ],
      ),
    );
  }
}

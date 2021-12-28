import '../services/league_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../widgets/bowlbar.dart';
import '../domain/league.dart';

class LeaguePage extends StatefulWidget {

  _LeaguePageState createState() => _LeaguePageState();
}

class _LeaguePageState extends State<LeaguePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BowlBar(title: "League"),
      body: Container(
        child: Column(
          children: <Widget>[
            Text("Hall of Shame"),
            _leagueFuture(),
          ],
        ),
      ),
    );
  }

  FutureBuilder<League> _leagueFuture() {
    return FutureBuilder<League>(
        future: calculateLeague(),
        builder: (BuildContext context, AsyncSnapshot<League> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return _progress();
            case ConnectionState.done:
              return _leagueGrid(snapshot.data!);
          }
        
        });
  }

  Widget _progress() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _headingText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _text(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 20.0),
    );
  }

  Widget _leagueGrid(League _league) {
    return Container(
      padding: const EdgeInsets.only(top: 20.0),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: <TableRow>[
          TableRow(
            decoration: BoxDecoration(
              color: Color.fromRGBO(245, 243, 237, 1),
            ),
            children: <Widget>[
              _headingText("Name"),
              _headingText("Series"),
              _headingText("Totals"),
              _headingText("DaysBest"),
              _headingText("POINTS"),
            ],
          ),
          TableRow(
            children: <Widget>[
              _text("Aku"),
              _text(_league.akuSeries.toString()),
              _text(_league.akuTotal.toString()),
              _text(_league.akuBestOfDay.toString()),
              _text(_league.akuPoints.toString()),
            ],
          ),
          TableRow(
            children: <Widget>[
              _text("Mikko"),
              _text(_league.mikkoSeries.toString()),
              _text(_league.mikkoTotal.toString()),
              _text(_league.mikkoBestOfDay.toString()),
              _text(_league.mikkoPoints.toString()),
            ],
          ),
          TableRow(
            children: <Widget>[
              _text("Olli"),
              _text(_league.olliSeries.toString()),
              _text(_league.olliTotal.toString()),
              _text(_league.olliBestOfDay.toString()),
              _text(_league.olliPoints.toString()),
            ],
          ),
        ],
      ),
    );
  }
}

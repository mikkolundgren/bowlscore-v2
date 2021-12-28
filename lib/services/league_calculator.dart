import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_service.dart';
import '../domain/scores.dart';
import '../domain/league.dart';

Future<League> calculateLeague(
    [bool fullteam = true]) async {
  QuerySnapshot result = await getScoresForLeague();

  League league = League();

  List<Scores> dayScores = [];
  List<DocumentSnapshot> docs = result.docs;

  List<DocumentSnapshot> filtered = [];
  for (DocumentSnapshot d in docs) {
    Scores s = _parseScores(d);
    if (fullteam) {
      if ((s.aku > 0 && s.mikko > 0 && s.olli > 0) == true) {
        filtered.add(d);
      }
    }
  }

  String currentDate = filtered[0].get('date');
  for (DocumentSnapshot d in filtered) {
    Scores s = _parseScores(d);

    _serieBest(league, s);

    if (currentDate == d['date']) {
      dayScores.add(s);
    } else {
      _dayPoints(league, dayScores);
      dayScores.clear();
      currentDate = d['date'];
      dayScores.add(s);
    }
  }
  _dayPoints(league, dayScores);
  return league;
}

Scores _parseScores(DocumentSnapshot d) {
  return Scores(
      aku: d['akuScore'], mikko: d['mikkoScore'], olli: d['olliScore']);
}

void _serieBest(League league, Scores s) {
  if (s.aku >= s.mikko && s.aku >= s.olli) {
    league.akuSeries++;
  }
  if (s.mikko >= s.aku && s.mikko >= s.olli) {
    league.mikkoSeries++;
  }
  if (s.olli >= s.aku && s.olli >= s.mikko) {
    league.olliSeries++;
  }
}

void _dayPoints(League l, List<Scores> dayScores) {
  int akuTotal = 0;
  int olliTotal = 0;
  int mikkoTotal = 0;
  int akuBest = 0;
  int mikkoBest = 0;
  int olliBest = 0;
  for (Scores s in dayScores) {
    akuTotal += s.aku;
    mikkoTotal += s.mikko;
    olliTotal += s.olli;
    if (s.aku >= akuBest) akuBest = s.aku;
    if (s.mikko >= mikkoBest) mikkoBest = s.mikko;
    if (s.olli >= olliBest) olliBest = s.olli;
  }
  if (akuTotal >= mikkoTotal && akuTotal >= olliTotal) l.akuTotal++;
  if (mikkoTotal >= akuTotal && mikkoTotal >= olliTotal) l.mikkoTotal++;
  if (olliTotal >= akuTotal && olliTotal >= mikkoTotal) l.olliTotal++;
  if (akuBest >= mikkoBest && akuBest >= olliBest) l.akuBestOfDay++;
  if (mikkoBest >= akuBest && mikkoBest >= olliBest) l.mikkoBestOfDay++;
  if (olliBest >= akuBest && olliBest >= mikkoBest) l.olliBestOfDay++;
}

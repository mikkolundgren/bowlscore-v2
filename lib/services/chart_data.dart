import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'firebase_service.dart';
import '../domain/scores.dart';

class Averages {
  List<Average> akuAvgs;
  List<Average> mikkoAvgs;
  List<Average> olliAvgs;
  Averages(this.akuAvgs, this.mikkoAvgs, this.olliAvgs);
}

class Average {
  final DateTime date;
  final double avg;
  Average(this.date, this.avg);
}

Future<Averages> calculateAverages() async {
  QuerySnapshot result = await getScoresFuture();

  List<DocumentSnapshot> docs = result.docs;
  String currentDate = docs[0].get('date');
  int aku = 0;
  int mikko = 0;
  int olli = 0;

  List<Average> akuAvgs = [];
  List<Average> mikkoAvgs = [];
  List<Average> olliAvgs = [];

  var i = 0;
  DateFormat format = DateFormat("dd.MM.yyyy");
  var parsedDate = format.parse(currentDate);
  for (DocumentSnapshot d in docs) {
    Scores s = _parseScores(d);
    if (currentDate == d['date']) {
      aku += s.aku;
      mikko += s.mikko;
      olli += s.olli;
      i++;
    } else {
      if (aku > 0) akuAvgs.add(Average(parsedDate, (aku / i)));
      if (mikko > 0) mikkoAvgs.add(Average(parsedDate, (mikko / i)));
      if (olli > 0) olliAvgs.add(Average(parsedDate, (olli / i)));
      currentDate = d['date'];
      parsedDate = format.parse(currentDate);
      i = 0;
      aku = 0;
      mikko = 0;
      olli = 0;
    }
  }
  //handle the last one
  if (aku > 0) akuAvgs.add(Average(parsedDate, (aku / i)));
  if (mikko > 0) mikkoAvgs.add(Average(parsedDate, (mikko / i)));
  if (olli > 0) olliAvgs.add(Average(parsedDate, (olli / i)));
  return Averages(akuAvgs, mikkoAvgs, olliAvgs);
}

Scores _parseScores(DocumentSnapshot d) {
  return Scores(
      aku: d['akuScore'], mikko: d['mikkoScore'], olli: d['olliScore']);
}

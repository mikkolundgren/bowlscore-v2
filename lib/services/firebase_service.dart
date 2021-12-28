import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../secret/creds.dart' as creds;

void signIn() {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  _auth
      .signInWithEmailAndPassword(email: creds.email, password: creds.password)
      .then((result) {
    if (result.user != null) {
      if (kDebugMode) {
        print('logged in $result.user');
      }
    }
  });
}

Future<QuerySnapshot> getScoresFuture({startDate}) {
  if (startDate == null) {
    return FirebaseFirestore.instance
        .collection('scores')
        .orderBy('timestamp', descending: true)
        .get();
  } else {
    return FirebaseFirestore.instance
        .collection('scores')
        .where('timestamp', isGreaterThanOrEqualTo: startDate)
        .orderBy('timestamp', descending: true)
        .get();
  }
}

Future<QuerySnapshot> getScoresForLeague() {
  return FirebaseFirestore.instance
      .collection('scores')
      .orderBy('timestamp', descending: true)
      .get();
  /*
      .then((result) {
    print("fetched $result.documents.length documents for league.");
    return result.documents;
  }).catchError((error) {
    print("error fetching documents for league $error");
  });
  return new List<DocumentSnapshot>();
  */
}

Stream<QuerySnapshot> getScores() {
  return FirebaseFirestore.instance
      .collection('scores')
      .orderBy('timestamp', descending: true)
      .snapshots();
}

Stream<QuerySnapshot> getPayers() {
  return FirebaseFirestore.instance
      .collection('payers')
      .orderBy('timestamp', descending: true)
      .snapshots();
}

void addScore(akuScore, mikkoScore, olliScore, serie) {
  // todo validate values

  var now = DateTime.now();
  var formatter = DateFormat('dd.MM.yyyy');

  FirebaseFirestore.instance.collection('scores').add({
    'akuScore': akuScore,
    'mikkoScore': mikkoScore,
    'olliScore': olliScore,
    'serie': serie,
    'date': formatter.format(now),
    'timestamp': now
  });
}

void addPayer(name, date) {
  var now = DateTime.now();
  FirebaseFirestore.instance
      .collection('payers')
      .add({'name': name, 'date': date, 'timestamp': now}).catchError((err) {
    throw err;
  });
}

void deletePayer(String id) {
  FirebaseFirestore.instance.collection('payers').doc(id).delete();
}

class Payer {
  final Timestamp date;
  final String name;
  final DocumentReference reference;
  Payer({required this.date, required this.name, required this.reference});
  Payer.fromMap(Map<String, dynamic> map, {required this.reference})
      : date = map['date'],
        name = map['name'];

/*
  Payer.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
      */
}

class Serie {
  int akuScore;
  int mikkoScore;
  int olliScore;
  int serie;
  Timestamp date;
  Serie(
      {required this.akuScore,
      required this.mikkoScore,
      required this.olliScore,
      required this.serie,
      required this.date});
  factory Serie.fromMap(Map<String, dynamic> map) {
    return Serie(
        akuScore: map['akuScore'],
        mikkoScore: map['mikkoScore'],
        olliScore: map['olliScore'],
        serie: map['serie'],
        date: map['date']);
  }
}

class Score {
  final Timestamp date;
  final List<Serie>? series;

  final DocumentReference reference;

  Score({required this.date, required this.series, required this.reference});

  Score.fromMap(Map<String, dynamic> map, {required this.reference})
      : date = map['date'],
        series = map['series'] != null ? List<Serie>.from(map['series']) : null;

/*
  Score.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
      */

  @override
  String toString() => "Record<$date>";

  Map<String, dynamic> toJson() => {'date': date, 'series': series};
}

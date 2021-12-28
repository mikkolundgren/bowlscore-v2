import 'package:flutter/material.dart';
import './addPayers.dart';
import '../widgets/bowlbar.dart';
import './addScore.dart';
import './fb_list_scores.dart';
import './listPayers.dart';
import './league_page.dart';
import './chartPage.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BowlBar(
        title: "Bowlscore",
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
          child: GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.all(3.0),
            children: <Widget>[
              _makeDashboard("Payers", Icons.attach_money, "showPayers"),
              _makeDashboard("Add payer", Icons.euro_symbol, "addPayer"),
              _makeDashboard("Scores", Icons.list, "scores"),
              _makeDashboard("Add scores", Icons.add, "addScore"),
              _makeDashboard("League", Icons.local_bar, "league"),
              _makeDashboard("Charts", Icons.equalizer, "charts"),
            ],
          )),
    );
  }

  Card _makeDashboard(String title, IconData icon, String action) {
    return Card(
      elevation: 1.0,
      margin: const EdgeInsets.all(3.0),
      child: Container(
        decoration: const BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
        child: InkWell(
          onTap: () {
            _showPage(action);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              const SizedBox(
                height: 50.0,
              ),
              Center(
                child: Icon(
                  icon,
                  size: 40.0,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Center(
                  child: Text(title,
                      style: const TextStyle(fontSize: 18.0, color: Colors.black))),
            ],
          ),
        ),
      ),
    );
  }

  _showPage(String action) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          switch (action) {
            case "showPayers":
              return const ListPayers();
            case "addPayer":
              return const AddPayerForm();
            case "addScore":
              return const AddScoreForm();
            case "scores":
              return const FBListScores();
            case "league":
              return const LeaguePage();
            case "charts":
              return const ChartPage();
            default:
              return const PayersPage();
          }
        },
      ),
    );
  }
}

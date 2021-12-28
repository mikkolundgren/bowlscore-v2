// ignore_for_file: file_names

import '../services/chart_data.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../widgets/bowlbar.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BowlBar(title: "Averages"),
      body: Container(
        padding: const EdgeInsets.all(40.0),
        child: Container(
          child: _buildChart(),
        ),
      ),
    );
  }

  Widget _buildChart() {
    return FutureBuilder(
        future: _createData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );

            case ConnectionState.done:
              return const Center();
            /*  
              return charts.TimeSeriesChart(
                null,
                animate: true,
              );
              */

          }
        });
    /*
    return new charts.TimeSeriesChart(
      _createData(),
      animate: false,
    );
    */
  }

  Future<List<charts.Series<Average, DateTime>>> _createData() async {
    var averages = await calculateAverages();
    return [
      charts.Series<Average, DateTime>(
          data: averages.akuAvgs,
          id: 'Aku',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (Average avg, _) => avg.date,
          measureFn: (Average avg, _) => avg.avg),
      charts.Series<Average, DateTime>(
          data: averages.mikkoAvgs,
          id: 'Mikko',
          colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
          domainFn: (Average avg, _) => avg.date,
          measureFn: (Average avg, _) => avg.avg),
      charts.Series<Average, DateTime>(
          data: averages.olliAvgs,
          id: 'Olli',
          colorFn: (_, __) => charts.MaterialPalette.black,
          domainFn: (Average avg, _) => avg.date,
          measureFn: (Average avg, _) => avg.avg),
    ];
  }
}

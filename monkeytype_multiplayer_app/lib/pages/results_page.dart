import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:monkeytype_multiplayer_app/controllers/cpmController.dart';
import 'package:monkeytype_multiplayer_app/layout/myFooter.dart';
import 'package:monkeytype_multiplayer_app/layout/myHeader.dart';
import 'package:monkeytype_multiplayer_app/pages/home_page.dart';

class ResultsPage extends StatefulWidget {
  // final double cpm;
  final Cpmcontroller cpmController;
  const ResultsPage({super.key, required this.cpmController});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  List<FlSpot> getValues() {
    List<FlSpot> ans = [];

    for (var value in widget.cpmController.cpmReg) {
      double cpmaux = ((value[1] / 5) * 100).round() / 100;
      double timeaux = (value[0] * 100).round() / 100;
      ans.add(FlSpot(timeaux, cpmaux));
    }

    return ans;
  }

  List<FlSpot> getWrongs() {
    List<FlSpot> ans = [];

    for (var value in widget.cpmController.cpmReg) {
      if (value[2] > 0) {
        final aux = widget.cpmController;
        double maxwpm = aux.maxcpm / 5;
        double timeaux = (value[0] * 100).round() / 100;
        ans.add(FlSpot(timeaux, (value[2] * maxwpm / aux.maxwrongs)));
      }
    }

    return ans;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.cpmController.clearController();
  }

  @override
  Widget build(BuildContext context) {
    final mytheme = Theme.of(context).colorScheme;
    final wpm = widget.cpmController.cpm.value / 5;
    final acc = widget.cpmController.acc;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Myheader(),

          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width * .8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 180,
                        child: _testPercentageResults(mytheme, wpm, acc),
                      ),

                      Expanded(child: _resultsChart(mytheme)),
                    ],
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      child: Text('go back to another test you slow ass mf'),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Myfooter(),
        ],
      ),
    );
  }

  Container _resultsChart(ColorScheme mytheme) {
    return Container(
      height: 220,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          minY: 0,
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: 1,
                minIncluded: true,
                maxIncluded: true,
                getTitlesWidget: (value, met) {
                  return Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      value.toString(),
                      style: TextStyle(color: mytheme.primary),
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(right: 10),
                    child: Text(
                      value.toString(),
                      style: TextStyle(color: mytheme.primary),
                    ),
                  );
                },
                reservedSize: 50,
                minIncluded: true,
                maxIncluded: false,
              ),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          lineBarsData: [
            LineChartBarData(
              belowBarData: BarAreaData(show: true, color: Color(0xff2C2E31)),
              spots: getValues(),
              isCurved: true,
              color: mytheme.secondary,
            ),
            LineChartBarData(
              spots: getWrongs(),
              isCurved: false,
              color: Colors.red,
              barWidth: 0,
            ),
          ],
        ),
      ),
    );
  }

  Column _testPercentageResults(ColorScheme mytheme, double wpm, double acc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'WPM',
          style: TextStyle(fontSize: 20, color: mytheme.primary),
          textHeightBehavior: TextHeightBehavior(
            applyHeightToFirstAscent: false,
            applyHeightToLastDescent: false,
          ),
        ),
        Text(
          wpm.toInt().toString(),
          style: TextStyle(fontSize: 70, color: mytheme.secondary),
          textHeightBehavior: TextHeightBehavior(
            applyHeightToFirstAscent: false,
            applyHeightToLastDescent: false,
          ),
        ),
        Text(
          'ACC',
          style: TextStyle(fontSize: 20, color: mytheme.primary),
          textHeightBehavior: TextHeightBehavior(
            applyHeightToFirstAscent: false,
            applyHeightToLastDescent: false,
          ),
        ),
        Text(
          // "100%",
          acc.toInt().toString() + "%",
          style: TextStyle(fontSize: 70, color: mytheme.secondary),
          textHeightBehavior: TextHeightBehavior(
            applyHeightToFirstAscent: false,
            applyHeightToLastDescent: false,
          ),
        ),
      ],
    );
  }
}

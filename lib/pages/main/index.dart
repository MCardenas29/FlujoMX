// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainIndex extends StatelessWidget {
  static const String route = '/index';
  const MainIndex({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Container(
          padding: EdgeInsets.all(10),
          child: Stack(children: [
            _BillInfoCard(),
            Positioned(right: 0, top: 0, bottom: 0, child: _StopcockValve()),
          ])),
      Container(
          padding: EdgeInsets.all(5), height: 200, child: _FeeRangeChart()),
    ]);
  }
}

class _StopcockValve extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: EdgeInsets.all(4),
            child: SvgPicture.asset('assets/pipe.svg'),
          ),
          SvgPicture.asset('assets/crank.svg'),
        ],
      ),
    );
  }
}

class _BillInfoCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BillInfoCardState();
}

class _BillInfoCardState extends State {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card.outlined(
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Icon(Icons.water_drop_outlined, size: 14),
            SizedBox(width: 4),
            Text("120 m³", style: theme.textTheme.labelLarge)
          ]),
          Text("\$ 1,200.00 MXN",
              style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold, fontSize: 20, height: 1.4)),
          Text("Excedente",
              style: theme.textTheme.labelMedium?.copyWith(height: 1.2)),
          Text("Tarifa: Domestica A",
              style: theme.textTheme.labelMedium?.copyWith(height: 1.2)),
          // Text(),
        ]),
      ),
    );
  }
}

class _FeeRangeChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FeeRangeChartState();
}

class _FeeRangeChartState extends State {
  BarChartGroupData createBar(int x, double y) {
    return BarChartGroupData(x: 1, barRods: [
      BarChartRodData(
          width: 30,
          toY: 10,
          color: Colors.red,
          borderRadius: BorderRadius.zero),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        maxY: 20,
        groupsSpace: 10,
        alignment: BarChartAlignment.center,
        barGroups: [
          createBar(0, 10),
          createBar(1, 10),
          createBar(2, 10),
        ],
        borderData: FlBorderData(show: false),
        gridData: FlGridData(
            drawVerticalLine: false,
            getDrawingHorizontalLine: (double y) =>
                FlLine(strokeWidth: 0.2, dashArray: [10, 5])),
        titlesData: FlTitlesData(
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
      ),
    );
  }
}

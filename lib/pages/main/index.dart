// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:FlujoMX/provider/fee.dart';
import 'package:FlujoMX/provider/mqtt.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:FlujoMX/entity/fee.dart';
import 'package:FlujoMX/enums.dart';

class MainIndex extends ConsumerWidget {
  static const String route = '/index';
  const MainIndex({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usage = ref.watch(usageProvider);
    final cost = ref.watch(costProvider);
    final fee = ref.watch(currentFeeProvider);

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Container(
          padding: EdgeInsets.all(10),
          child: Stack(children: [
            _BillInfoCard(
                usage: usage.value ?? 0,
                currentFee: fee ?? Fee.domRural,
                currentRange: fees.entries.first.value.last,
                total: cost.value ?? 0),
            Positioned(right: 0, top: 0, bottom: 0, child: _StopcockValve()),
          ])),
      Container(
          padding: EdgeInsets.all(5), height: 250, child: _FeeRangeChart()),
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
            padding: EdgeInsets.all(2),
            child: SvgPicture.asset('assets/pipe.svg'),
          ),
          SvgPicture.asset('assets/crank.svg'),
        ],
      ),
    );
  }
}

class _BillInfoCard extends StatelessWidget {
  Range currentRange;
  Fee currentFee;
  double usage;
  double total;

  _BillInfoCard({
    required this.usage,
    required this.currentRange,
    required this.currentFee,
    required this.total,
  });

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
            Text("$usage m³", style: theme.textTheme.labelLarge)
          ]),
          Text("\$ ${total.toStringAsFixed(2)} MXN",
              style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold, fontSize: 20, height: 1.4)),
          // Text("Excedente",
          //     style: theme.textTheme.labelMedium?.copyWith(height: 1.2)),
          Text("Tarifa: ${currentFee}",
              style: theme.textTheme.labelMedium?.copyWith(height: 1.2)),
          // Text(),
        ]),
      ),
    );
  }
}

class _FeeRangeChart extends ConsumerWidget {
  static final List<Color> colors = [
    Colors.blueAccent,
    Colors.orangeAccent,
    Colors.purpleAccent,
    Colors.greenAccent,
    Colors.redAccent
  ];

  BarChartGroupData createBar(int x, double y) {
    return BarChartGroupData(x: x, barRods: [
      BarChartRodData(
          width: 40, toY: y, color: colors[x], borderRadius: BorderRadius.zero),
    ]);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var usage = ref.watch(usageProvider).value ?? 0;
    final prices = ref.watch(usageRangeProvider);

    var chartBars = <BarChartGroupData>[];
    if (prices != null) {
      prices.asMap().forEach((index, price) {
        chartBars.add(price.inRange(usage)
            ? createBar(index, price.maxUsage)
            : createBar(index, usage));
        usage -= price.maxUsage;
      });
    }

    return BarChart(
      BarChartData(
        groupsSpace: 10,
        alignment: BarChartAlignment.center,
        barTouchData: BarTouchData(enabled: false),
        barGroups: chartBars,
        borderData: FlBorderData(show: false),
        gridData: FlGridData(
            drawVerticalLine: false,
            getDrawingHorizontalLine: (double y) =>
                FlLine(strokeWidth: 0.2, dashArray: [10, 5])),
        titlesData: FlTitlesData(
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          // bottomTitles: AxisTitles(
          //     sideTitles: SideTitles(
          //         getTitlesWidget: (value, meta) => SideTitleWidget(
          //             child: Text("$value"), axisSide: meta.axisSide)))
        ),
      ),
    );
  }
}

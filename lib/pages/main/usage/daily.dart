import 'package:FlujoMX/provider/mqtt.dart';
import 'package:FlujoMX/repository/flow.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainUsageDaily extends ConsumerWidget {
  static const String route = "/usage/daily";
  const MainUsageDaily({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.read(flowRepositoryProvider);
    ref.watch(mqttFlowProvider);
    final flows = repo.all();

    return FutureBuilder(
        future: flows,
        builder: (ctx, snapshot) {
          var points = snapshot.data!.map((e) {
            return spot(e.timestamp.millisecondsSinceEpoch.toDouble(), e.value);
          }).toList();
          return Column(children: [
            Container(
                padding: EdgeInsets.all(5),
                height: 300,
                child: _FlowChart(snapshot.data!)),
            Column(),
          ]);
        });
  }
}

class _FlowChart extends ConsumerStatefulWidget {
  @override
  _FlowChartState createState() => _FlowChartState();
}

class _FlowChartState extends ConsumerState<_FlowChart> {
  double _offset = DateTime.now().millisecondsSinceEpoch.toDouble();

  FlSpot spot(double x, double y) {
    return FlSpot(x, y);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LineChart(LineChartData(
      lineTouchData: LineTouchData(touchCallback: (ev, response) {
        if (ev is FlPanUpdateEvent) {
          setState(() => _offset += ev.details.delta.dx * 10000);
          print(_offset);
        }
      }),
      minX: _offset - 10000.0,
      maxX: _offset + 10000.0,
      baselineX: _offset,
      lineBarsData: [
        LineChartBarData(
            spots: points, isCurved: false, color: theme.colorScheme.primary),
      ],
      gridData: const FlGridData(
          show: true, drawVerticalLine: true, drawHorizontalLine: true),
      // borderData: FlBorderData(),
      titlesData: const FlTitlesData(
        bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
    ));
  }
}

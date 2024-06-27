import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LeaveBar extends StatefulWidget {
  const LeaveBar({super.key});

  @override
  State<LeaveBar> createState() => _LeaveBarState();
}

class _LeaveBarState extends State<LeaveBar> {
  @override
  Widget build(BuildContext context) {
    List<double> weeklySummary = [
      84.40,
      28.50,
      54.24,
      90.50,
    ];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: SizedBox(
          height: 300,
          child: BarDataChart(weeklySummary: weeklySummary),
        ),
      ),
    );
  }
}

class BarDataChart extends StatefulWidget {
  final List<double> weeklySummary;
  const BarDataChart({super.key, required this.weeklySummary});

  @override
  State<BarDataChart> createState() => _BarDataChartState();
}

class _BarDataChartState extends State<BarDataChart> {
  late BarData myBarData;

  @override
  void initState() {
    super.initState();
    myBarData = BarData(
      sunAmount: widget.weeklySummary[0],
      monAmount: widget.weeklySummary[1],
      tueAmount: widget.weeklySummary[2],
      wedAmount: widget.weeklySummary[3],
    );
    myBarData.initializeBarData();
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        maxY: 100,
        minY: 0,
        gridData: FlGridData(show: true),
        borderData: FlBorderData(show: true),
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getBottomTitles,
            ),
          ),
        ),
        barGroups: myBarData.barData
            .map((data) => BarChartGroupData(
                  x: data.x,
                  barRods: [
                    BarChartRodData(
                      toY: data.y,
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(0),
                      width: 40,
                    )
                  ],
                ))
            .toList(),
      ),
      swapAnimationDuration: Duration(milliseconds: 0),
      swapAnimationCurve: Curves.easeOut,
    );
  }
}

class IndividualBar {
  final int x;
  final double y;

  IndividualBar({
    required this.x,
    required this.y,
  });
}

class BarData {
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;

  BarData({
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
  });

  List<IndividualBar> barData = [];

  void initializeBarData() {
    barData = [
      IndividualBar(x: 0, y: sunAmount),
      IndividualBar(x: 1, y: monAmount),
      IndividualBar(x: 2, y: tueAmount),
      IndividualBar(x: 3, y: wedAmount),
    ];
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.purple,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  switch (value.toInt()) {
    case 0:
      return SideTitleWidget(
          child: const Text('Entitled', style: style), axisSide: meta.axisSide);
    case 1:
      return SideTitleWidget(
          child: const Text('Utilized', style: style), axisSide: meta.axisSide);
    case 2:
      return SideTitleWidget(
          child: const Text('Pending', style: style), axisSide: meta.axisSide);
    case 3:
      return SideTitleWidget(
          child: const Text('Available', style: style),
          axisSide: meta.axisSide);
    default:
      return SideTitleWidget(
          child: const Text('D', style: style), axisSide: meta.axisSide);
  }
}

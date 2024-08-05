import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../styles/app_colors.dart';

class AttendanceData {
  final String month;
  final int attended;
  final int leave;
  final int absent;

  AttendanceData({
    required this.month,
    required this.attended,
    required this.leave,
    required this.absent,
  });
}

class AttendanceBarGraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLegend('Attended', AppColors.background),
                _buildLegend('Leave', Colors.blue),
                _buildLegend('Absent', Colors.purpleAccent),
              ],
            ),
            SizedBox(height: 16),
            AttendanceBarChart(
              data: [
                AttendanceData(month: 'Jan', attended: 20, leave: 5, absent: 3),
                AttendanceData(month: 'Feb', attended: 18, leave: 3, absent: 2),
                AttendanceData(month: 'Mar', attended: 22, leave: 4, absent: 1),
                AttendanceData(month: 'Apr', attended: 25, leave: 6, absent: 0),
                AttendanceData(month: 'May', attended: 23, leave: 5, absent: 2),
                AttendanceData(month: 'Jun', attended: 21, leave: 4, absent: 3),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AttendanceBarChart extends StatelessWidget {
  final List<AttendanceData> data;

  AttendanceBarChart({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: EdgeInsets.all(16.0),
      child: BarChart(
        BarChartData(
          barGroups: _buildBarGroups(),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  const style = TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  );
                  Widget text;
                  switch (value.toInt()) {
                    case 0:
                      text = Text('Jan', style: style);
                      break;
                    case 1:
                      text = Text('Feb', style: style);
                      break;
                    case 2:
                      text = Text('Mar', style: style);
                      break;
                    case 3:
                      text = Text('Apr', style: style);
                      break;
                    case 4:
                      text = Text('May', style: style);
                      break;
                    case 5:
                      text = Text('Jun', style: style);
                      break;
                    default:
                      text = Text('', style: style);
                      break;
                  }
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    space: 4.0, // space between bar and title
                    child: text,
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: true),
          barTouchData: BarTouchData(enabled: false),
        ),
        swapAnimationDuration: Duration(milliseconds: 0),
        swapAnimationCurve: Curves.easeOut,
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    return List.generate(data.length, (index) {
      final attendance = data[index];
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: attendance.attended.toDouble(),
            color: AppColors.background,
          ),
          BarChartRodData(
            toY: attendance.leave.toDouble(),
            color: Colors.blueAccent,
          ),
          BarChartRodData(
            toY: attendance.absent.toDouble(),
            color: Colors.purpleAccent,
          ),
        ],
      );
    });
  }
}

Widget _buildLegend(String label, Color color) {
  return Row(
    children: [
      Container(
        width: 20,
        height: 20,
        color: color,
        margin: EdgeInsets.only(right: 8),
      ),
      Text(label),
    ],
  );
}


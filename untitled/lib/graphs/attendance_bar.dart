import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

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
    return  SizedBox(
      height: 250,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Attendance '),
          ),
          body: Center(
            child: AttendanceBarChart(
              data: [
                AttendanceData(month: 'Jan', attended: 20, leave: 5, absent: 3),
                AttendanceData(month: 'Feb', attended: 18, leave: 3, absent: 2),
                AttendanceData(month: 'Mar', attended: 22, leave: 4, absent: 1),
                AttendanceData(month: 'Apr', attended: 25, leave: 6, absent: 0),
                AttendanceData(month: 'May', attended: 23, leave: 5, absent: 2),
                AttendanceData(month: 'Jun', attended: 21, leave: 4, absent: 3),
              ],
            ),
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
    List<charts.Series<AttendanceData, String>> series = [
      charts.Series(
        id: 'Attendance',
        data: data,
        domainFn: (AttendanceData attendance, _) => attendance.month,
        measureFn: (AttendanceData attendance, _) => attendance.attended,
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        labelAccessorFn: (AttendanceData attendance, _) => '${attendance.attended}',
      ),
      charts.Series(
        id: 'Leave',
        data: data,
        domainFn: (AttendanceData attendance, _) => attendance.month,
        measureFn: (AttendanceData attendance, _) => attendance.leave,
        colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
        labelAccessorFn: (AttendanceData attendance, _) => '${attendance.leave}',
      ),
      charts.Series(
        id: 'Absent',
        data: data,
        domainFn: (AttendanceData attendance, _) => attendance.month,
        measureFn: (AttendanceData attendance, _) => attendance.absent,
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        labelAccessorFn: (AttendanceData attendance, _) => '${attendance.absent}',
      ),
    ];

    return Container(
      height: 400,
      padding: EdgeInsets.all(8.0),
      child: charts.BarChart(
        series,
        animate: true,
        vertical: false,
        barGroupingType: charts.BarGroupingType.stacked,
        behaviors: [
          charts.SeriesLegend(),
        ],
      ),
    );
  }
}

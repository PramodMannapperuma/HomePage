import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AttendancePie extends StatelessWidget {
  const AttendancePie({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children:[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('ATTENDANCE'),
                Text('Attended', style: TextStyle(color: Colors.blue),),
                Text('Leaves',style: TextStyle(color: Colors.green),),
                Text('Absent',style: TextStyle(color: Colors.red),),
                Text('Attended'),
              ],
            ),
            PieChart(
            swapAnimationDuration: const Duration(milliseconds: 750),
            swapAnimationCurve: Curves.easeInOut,
            PieChartData(
              sections: [
                PieChartSectionData(
                  value: 200,
                  color: Colors.blue,
                ),
                PieChartSectionData(
                  value: 20,
                  color: Colors.red,
                ),
                PieChartSectionData(
                  value: 20,
                  color: Colors.green,
                ),
              ],
            ),
          ),
  ]
        ),
      ),
    );
  }
}

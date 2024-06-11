class PaySlipData {
  final String month;
  final String year;
  final String basicSalary;
  final String allowances;
  final String deductions;
  final String netPay;
  final String employeeNumber;
  final String deductionDetails;

  PaySlipData({
    required this.month,
    required this.year,
    required this.basicSalary,
    required this.allowances,
    required this.deductions,
    required this.netPay,
    required this.employeeNumber,
    required this.deductionDetails,
  });
}

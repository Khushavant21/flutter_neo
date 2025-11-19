// lib/widgets/admin_report_page.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import '../admin_report/admin_report_styles.dart';
// import '../admin_top_navbar.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class AdminReportPage extends StatefulWidget {
  const AdminReportPage({super.key});

  @override
  State<AdminReportPage> createState() => _AdminReportPageState();
}

class _AdminReportPageState extends State<AdminReportPage> {
  String reportType = "transactions";
  String reportPeriod = "daily";
  DateTime fromDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime toDate = DateTime.now();

  List<ReportData> rawData = [];
  List<ReportData> aggregatedData = [];

  @override
  void initState() {
    super.initState();
    _loadMockData();
  }

  void _loadMockData() {
    rawData = [
      ReportData(
        date: DateTime(2025, 9, 1),
        type: "Deposit",
        count: 12,
        total: 5000,
      ),
      ReportData(
        date: DateTime(2025, 9, 2),
        type: "Withdrawal",
        count: 8,
        total: 3200,
      ),
      ReportData(
        date: DateTime(2025, 9, 3),
        type: "Transfer",
        count: 15,
        total: 7800,
      ),
      ReportData(
        date: DateTime(2025, 9, 4),
        type: "Deposit",
        count: 10,
        total: 4200,
      ),
      ReportData(
        date: DateTime(2025, 9, 8),
        type: "Deposit",
        count: 5,
        total: 2000,
      ),
      ReportData(
        date: DateTime(2025, 9, 15),
        type: "Withdrawal",
        count: 7,
        total: 3100,
      ),
      ReportData(
        date: DateTime(2025, 9, 20),
        type: "Transfer",
        count: 9,
        total: 4500,
      ),
      ReportData(
        date: DateTime(2025, 9, 25),
        type: "Deposit",
        count: 11,
        total: 5200,
      ),
    ];
    _aggregateData();
  }

  void _aggregateData() {
    if (reportPeriod == "daily") {
      setState(() {
        aggregatedData = rawData;
      });
      return;
    }

    Map<String, ReportData> grouped = {};

    for (var data in rawData) {
      String key;
      if (reportPeriod == "weekly") {
        int weekNumber = _getWeekNumber(data.date);
        key = "${data.date.year}-W$weekNumber";
      } else {
        key = "${data.date.year}-${data.date.month.toString().padLeft(2, '0')}";
      }

      if (!grouped.containsKey(key)) {
        grouped[key] = ReportData(
          date: data.date,
          type: key,
          count: 0,
          total: 0,
        );
      }
      grouped[key]!.count += data.count;
      grouped[key]!.total += data.total;
    }

    setState(() {
      aggregatedData = grouped.values.toList();
    });
  }

  int _getWeekNumber(DateTime date) {
    int dayOfYear = int.parse(DateFormat("D").format(date));
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isFromDate ? fromDate : toDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AdminReportStyles.primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isFromDate) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
    }
  }

  void _downloadCSV() {
    List<List<String>> csvData = [
      ['Date', 'Count', 'Total Amount'],
      ...aggregatedData.map(
        (d) => [
          DateFormat('yyyy-MM-dd').format(d.date),
          d.count.toString(),
          d.total.toString(),
        ],
      ),
    ];

    // String csvContent = csvData.map((row) => row.join(',')).join('\n');
    // In a real app, you would save csvContent to a file or trigger download
    // For now, we just show a message

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('CSV export prepared with ${csvData.length - 1} rows'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _downloadPDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Admin Report',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.TableHelper.fromTextArray(
                headers: ['Date', 'Count', 'Total Amount'],
                data: aggregatedData
                    .map(
                      (d) => [
                        DateFormat('yyyy-MM-dd').format(d.date),
                        d.count.toString(),
                        '\$${d.total}',
                      ],
                    )
                    .toList(),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  int get totalTransactions =>
      aggregatedData.fold(0, (sum, d) => sum + d.count);
  double get totalAmount => aggregatedData.fold(0.0, (sum, d) => sum + d.total);
  String get averageAmount {
    if (totalTransactions > 0) {
      return (totalAmount / totalTransactions).toStringAsFixed(2);
    }
    return "0.00";
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isSmallMobile = screenWidth < 480;

    return Scaffold(
      body: Column(
        children: [
          // const TopNavbar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Header
                  Container(
                    width: double.infinity,
                    decoration: AdminReportStyles.headerDecoration,
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmallMobile ? 15 : 19,
                      vertical: isSmallMobile ? 15 : 25,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Admin Reports & Analytics',
                          style:
                              AdminReportStyles.headerTitleStyle(
                                isSmallMobile,
                              ).copyWith(
                                fontSize:
                                    (AdminReportStyles.headerTitleStyle(
                                          isSmallMobile,
                                        ).fontSize ??
                                        24) +
                                    2,
                              ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'View detailed reports and analytics to monitor system performance and user activity.',
                          style:
                              AdminReportStyles.headerSubtitleStyle(
                                isSmallMobile,
                              ).copyWith(
                                fontSize:
                                    (AdminReportStyles.headerSubtitleStyle(
                                          isSmallMobile,
                                        ).fontSize ??
                                        14) -
                                    2,
                              ),
                        ),
                      ],
                    ),
                  ),

                  // Content Container
                  Padding(
                    padding: EdgeInsets.all(isSmallMobile ? 8 : 16),
                    child: Column(
                      children: [
                        // Summary Cards
                        _buildSummaryCards(isMobile, isSmallMobile),
                        SizedBox(height: isSmallMobile ? 15 : 25),

                        // Filters
                        _buildFilters(context, isMobile, isSmallMobile),
                        SizedBox(height: isSmallMobile ? 15 : 25),

                        // Export Buttons
                        _buildExportButtons(isMobile, isSmallMobile),
                        SizedBox(height: isSmallMobile ? 15 : 25),

                        // Charts
                        _buildCharts(isSmallMobile),
                        SizedBox(height: isSmallMobile ? 15 : 25),

                        // Table
                        _buildTable(isSmallMobile),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards(bool isMobile, bool isSmallMobile) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = isSmallMobile ? 1 : (isMobile ? 2 : 3);

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: isSmallMobile ? 10 : 15,
          mainAxisSpacing: isSmallMobile ? 10 : 15,
          childAspectRatio: isSmallMobile ? 4 : 2.5,
          children: [
            _buildCard(
              'Total Transactions',
              totalTransactions.toString(),
              isSmallMobile,
            ),
            _buildCard('Total Amount', '\$$totalAmount', isSmallMobile),
            _buildCard('Average Amount', '\$$averageAmount', isSmallMobile),
          ],
        );
      },
    );
  }

  Widget _buildCard(String title, String value, bool isSmallMobile) {
    return Container(
      decoration: AdminReportStyles.cardDecoration,
      padding: EdgeInsets.all(isSmallMobile ? 12 : 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: AdminReportStyles.cardTitleStyle(isSmallMobile),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(value, style: AdminReportStyles.cardValueStyle(isSmallMobile)),
        ],
      ),
    );
  }

  Widget _buildFilters(
    BuildContext context,
    bool isMobile,
    bool isSmallMobile,
  ) {
    return Container(
      decoration: AdminReportStyles.filterContainerDecoration,
      padding: EdgeInsets.all(isSmallMobile ? 12 : 20),
      child: isMobile
          ? Column(
              children: [
                _buildFilterDropdown(
                  'Report Type',
                  reportType,
                  ['transactions', 'compliance', 'financial'],
                  (value) => setState(() => reportType = value!),
                  isSmallMobile,
                ),
                const SizedBox(height: 10),
                _buildFilterDropdown(
                  'Period',
                  reportPeriod,
                  ['daily', 'weekly', 'monthly'],
                  (value) {
                    setState(() {
                      reportPeriod = value!;
                      _aggregateData();
                    });
                  },
                  isSmallMobile,
                ),
                const SizedBox(height: 10),
                _buildDatePicker(
                  context,
                  'From Date',
                  fromDate,
                  true,
                  isSmallMobile,
                ),
                const SizedBox(height: 10),
                _buildDatePicker(
                  context,
                  'To Date',
                  toDate,
                  false,
                  isSmallMobile,
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: _buildFilterDropdown(
                    'Report Type',
                    reportType,
                    ['transactions', 'compliance', 'financial'],
                    (value) => setState(() => reportType = value!),
                    isSmallMobile,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildFilterDropdown(
                    'Period',
                    reportPeriod,
                    ['daily', 'weekly', 'monthly'],
                    (value) {
                      setState(() {
                        reportPeriod = value!;
                        _aggregateData();
                      });
                    },
                    isSmallMobile,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildDatePicker(
                    context,
                    'From Date',
                    fromDate,
                    true,
                    isSmallMobile,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildDatePicker(
                    context,
                    'To Date',
                    toDate,
                    false,
                    isSmallMobile,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildFilterDropdown(
    String label,
    String value,
    List<String> items,
    Function(String?) onChanged,
    bool isSmallMobile,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AdminReportStyles.filterLabelStyle(isSmallMobile)),
        const SizedBox(height: 6),
        Container(
          decoration: AdminReportStyles.inputDecoration,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              padding: EdgeInsets.symmetric(
                horizontal: isSmallMobile ? 10 : 12,
                vertical: isSmallMobile ? 6 : 8,
              ),
              items: items.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(
                    item[0].toUpperCase() + item.substring(1),
                    style: AdminReportStyles.dropdownItemStyle(isSmallMobile),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
              icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF666666)),
              dropdownColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDatePicker(
    BuildContext context,
    String label,
    DateTime date,
    bool isFromDate,
    bool isSmallMobile,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AdminReportStyles.filterLabelStyle(isSmallMobile)),
        const SizedBox(height: 6),
        InkWell(
          onTap: () => _selectDate(context, isFromDate),
          child: Container(
            decoration: AdminReportStyles.inputDecoration,
            padding: EdgeInsets.symmetric(
              horizontal: isSmallMobile ? 10 : 12,
              vertical: isSmallMobile ? 11 : 13,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('yyyy-MM-dd').format(date),
                  style: AdminReportStyles.dateTextStyle(isSmallMobile),
                ),
                const Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: Color(0xFF666666),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExportButtons(bool isMobile, bool isSmallMobile) {
    return isMobile
        ? Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: _buildExportButton(
                  'Export CSV',
                  _downloadCSV,
                  isSmallMobile,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: _buildExportButton(
                  'Export PDF',
                  _downloadPDF,
                  isSmallMobile,
                ),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: _buildExportButton(
                  'Export CSV',
                  _downloadCSV,
                  isSmallMobile,
                ),
              ),
              const SizedBox(width: 12),
              Flexible(
                child: _buildExportButton(
                  'Export PDF',
                  _downloadPDF,
                  isSmallMobile,
                ),
              ),
            ],
          );
  }

  Widget _buildExportButton(
    String text,
    VoidCallback onPressed,
    bool isSmallMobile,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: AdminReportStyles.exportButtonStyle(isSmallMobile),
      child: Text(text),
    );
  }

  Widget _buildCharts(bool isSmallMobile) {
    return Column(
      children: [
        _buildLineChart(isSmallMobile),
        SizedBox(height: isSmallMobile ? 12 : 20),
        _buildBarChart(isSmallMobile),
      ],
    );
  }

  Widget _buildLineChart(bool isSmallMobile) {
    return Container(
      decoration: AdminReportStyles.chartDecoration,
      padding: EdgeInsets.all(isSmallMobile ? 12 : 20),
      child: Column(
        children: [
          Text(
            'Transaction Count ($reportPeriod)',
            style: AdminReportStyles.chartTitleStyle(isSmallMobile),
          ),
          SizedBox(height: isSmallMobile ? 10 : 15),
          SizedBox(
            height: isSmallMobile ? 250 : 300,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: true),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() >= 0 &&
                            value.toInt() < aggregatedData.length) {
                          return Text(
                            DateFormat(
                              'MM/dd',
                            ).format(aggregatedData[value.toInt()].date),
                            style: const TextStyle(fontSize: 10),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: true),
                lineBarsData: [
                  LineChartBarData(
                    spots: aggregatedData.asMap().entries.map((entry) {
                      return FlSpot(
                        entry.key.toDouble(),
                        entry.value.count.toDouble(),
                      );
                    }).toList(),
                    isCurved: true,
                    color: AdminReportStyles.primaryColor,
                    barWidth: 3,
                    dotData: const FlDotData(show: true),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart(bool isSmallMobile) {
    return Container(
      decoration: AdminReportStyles.chartDecoration,
      padding: EdgeInsets.all(isSmallMobile ? 12 : 20),
      child: Column(
        children: [
          Text(
            'Total Amount ($reportPeriod)',
            style: AdminReportStyles.chartTitleStyle(isSmallMobile),
          ),
          SizedBox(height: isSmallMobile ? 10 : 15),
          SizedBox(
            height: isSmallMobile ? 250 : 300,
            child: BarChart(
              BarChartData(
                gridData: const FlGridData(show: true),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: true, reservedSize: 50),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() >= 0 &&
                            value.toInt() < aggregatedData.length) {
                          return Text(
                            DateFormat(
                              'MM/dd',
                            ).format(aggregatedData[value.toInt()].date),
                            style: const TextStyle(fontSize: 10),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: true),
                barGroups: aggregatedData.asMap().entries.map((entry) {
                  return BarChartGroupData(
                    x: entry.key,
                    barRods: [
                      BarChartRodData(
                        toY: entry.value.total,
                        color: AdminReportStyles.primaryColor,
                        width: 16,
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTable(bool isSmallMobile) {
    return Container(
      decoration: AdminReportStyles.tableCardDecoration,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(isSmallMobile ? 10 : 15),
            decoration: const BoxDecoration(
              color: Color(0xFFFAFAFA),
              border: Border(bottom: BorderSide(color: Color(0xFFE8E8E8))),
            ),
            child: Row(
              children: [
                Text(
                  'Detailed Report Data',
                  style: AdminReportStyles.tableHeaderStyle(isSmallMobile),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(const Color(0xFFF8F9FA)),
              columns: [
                DataColumn(
                  label: Text(
                    'Date',
                    style: AdminReportStyles.tableColumnStyle(isSmallMobile),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Count',
                    style: AdminReportStyles.tableColumnStyle(isSmallMobile),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Total Amount',
                    style: AdminReportStyles.tableColumnStyle(isSmallMobile),
                  ),
                ),
              ],
              rows: aggregatedData.map((data) {
                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        DateFormat('yyyy-MM-dd').format(data.date),
                        style: AdminReportStyles.tableCellStyle(isSmallMobile),
                      ),
                    ),
                    DataCell(
                      Text(
                        data.count.toString(),
                        style: AdminReportStyles.tableCellStyle(isSmallMobile),
                      ),
                    ),
                    DataCell(
                      Text(
                        '\$${data.total}',
                        style: AdminReportStyles.tableCellStyle(isSmallMobile),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class ReportData {
  DateTime date;
  String type;
  int count;
  double total;

  ReportData({
    required this.date,
    required this.type,
    required this.count,
    required this.total,
  });
}

import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class PortfolioReports extends StatefulWidget {
  const PortfolioReports({super.key});

  @override
  State<PortfolioReports> createState() => _PortfolioReportsState();
}

class _PortfolioReportsState extends State<PortfolioReports> {
  List<Map<String, String>> reports = [
    {
      "id": "1",
      "user": "Ram Kumar",
      "product": "Mutual Fund A",
      "invested": "\$5000",
      "returns": "\$200",
      "date": "2025-09-20",
    },
    {
      "id": "2",
      "user": "Sita Sharma",
      "product": "Bond B",
      "invested": "\$3000",
      "returns": "\$150",
      "date": "2025-09-21",
    },
    {
      "id": "3",
      "user": "Amit Singh",
      "product": "Mutual Fund C",
      "invested": "\$7000",
      "returns": "\$350",
      "date": "2025-09-22",
    },
  ];

  String filterUser = "";

  Future<void> exportToCSV() async {
    List<List<dynamic>> csvData = [
      ["User", "Product", "Invested", "Returns", "Date"],
      ...reports.map(
        (r) => [
          r["user"],
          r["product"],
          r["invested"],
          r["returns"],
          r["date"],
        ],
      ),
    ];

    String csv = const ListToCsvConverter().convert(csvData);
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/portfolio_reports.csv");
    await file.writeAsString(csv);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Exported to: ${file.path}"),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    final filteredReports = reports.where((r) {
      return r["user"]!.toLowerCase().contains(filterUser.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        automaticallyImplyLeading: false, // 🔥 BACK BUTTON REMOVED
        title: const Text(
          "Portfolio Reports",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: const Color(0xFF900603),
        centerTitle: true,
        elevation: 4,
        actions: [
          IconButton(
            onPressed: exportToCSV,
            icon: const Icon(Icons.download, color: Colors.white),
            tooltip: "Export CSV",
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),

          child: Column(
            children: [
              // FILTER TEXTFIELD
              TextField(
                decoration: InputDecoration(
                  hintText: "Filter by User",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: (val) => setState(() => filterUser = val),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: isMobile
                    ? _buildMobileView(filteredReports)
                    : _buildDesktopView(filteredReports),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 📱 Mobile: Card Style
  Widget _buildMobileView(List<Map<String, String>> reportList) {
    if (reportList.isEmpty) {
      return const Center(
        child: Text(
          "No Reports Found",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: reportList.length,
      itemBuilder: (context, index) {
        final r = reportList[index];

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5),
            ],
            color: Colors.white,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // USER
              Text(
                r["user"]!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 8),

              // DETAILS ROW 1
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Product: ${r["product"]}"),
                  Text("Date: ${r["date"]}"),
                ],
              ),
              const SizedBox(height: 8),

              // DETAILS ROW 2
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Invested: ${r["invested"]}"),
                  Text("Returns: ${r["returns"]}"),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // 💻 Desktop Table
  Widget _buildDesktopView(List<Map<String, String>> reportList) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: WidgetStateProperty.all(const Color(0xFF900603)),
        headingTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),

        columns: const [
          DataColumn(label: Text("User")),
          DataColumn(label: Text("Product")),
          DataColumn(label: Text("Invested")),
          DataColumn(label: Text("Returns")),
          DataColumn(label: Text("Date")),
        ],

        rows: reportList.map((r) {
          return DataRow(
            cells: [
              DataCell(Text(r["user"]!)),
              DataCell(Text(r["product"]!)),
              DataCell(Text(r["invested"]!)),
              DataCell(Text(r["returns"]!)),
              DataCell(Text(r["date"]!)),
            ],
          );
        }).toList(),
      ),
    );
  }
}

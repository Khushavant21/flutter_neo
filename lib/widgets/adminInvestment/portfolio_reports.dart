import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PortfolioReports extends StatefulWidget {
  final VoidCallback? onBack;

  const PortfolioReports({super.key, this.onBack});

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
    final filteredReports = reports
        .where(
          (r) => r["user"]!.toLowerCase().contains(filterUser.toLowerCase()),
        )
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
        title: const Text("Portfolio Reports"),
        backgroundColor: const Color(0xFF900603),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== Card Container =====
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // ===== Filter + Export Row =====
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Filter by User",
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                          ),
                          onChanged: (val) {
                            setState(() {
                              filterUser = val;
                            });
                          },
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: exportToCSV,
                                icon: const FaIcon(
                                  FontAwesomeIcons.fileCsv,
                                  size: 16,
                                ),
                                label: const Text("Export CSV"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF900603),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  // Placeholder for PDF export
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("PDF export coming soon!"),
                                      backgroundColor: Colors.orange,
                                    ),
                                  );
                                },
                                icon: const FaIcon(
                                  FontAwesomeIcons.filePdf,
                                  size: 16,
                                ),
                                label: const Text("Export PDF"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFDC3545),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // ===== Table Header =====
                    Container(
                      color: const Color(0xFF900603),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 10,
                      ),
                      child: const Row(
                        children: [
                          Expanded(
                            child: Text(
                              "User",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Product",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Invested",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Returns",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Date",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ===== Table Data =====
                    if (filteredReports.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "No reports found.",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    else
                      Column(
                        children: filteredReports
                            .map(
                              (r) => Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey.shade300,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 10,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        r["user"]!,
                                        style: TextStyle(
                                          fontSize: screenWidth < 400 ? 12 : 14,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        r["product"]!,
                                        style: TextStyle(
                                          fontSize: screenWidth < 400 ? 12 : 14,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        r["invested"]!,
                                        style: TextStyle(
                                          fontSize: screenWidth < 400 ? 12 : 14,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        r["returns"]!,
                                        style: TextStyle(
                                          fontSize: screenWidth < 400 ? 12 : 14,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        r["date"]!,
                                        style: TextStyle(
                                          fontSize: screenWidth < 400 ? 12 : 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

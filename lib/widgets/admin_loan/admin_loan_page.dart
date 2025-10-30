// lib/widgets/admin_loan_page.dart
import 'package:flutter/material.dart';
import '../admin_top_navbar.dart';
import '../admin_loan//admin_loan_styles.dart';

class AdminLoanPage extends StatefulWidget {
  const AdminLoanPage({super.key});

  @override
  State<AdminLoanPage> createState() => _AdminLoanPageState();
}

class _AdminLoanPageState extends State<AdminLoanPage> {
  String activeTab = "applications";
  String search = "";
  String statusFilter = "All";
  List<Map<String, dynamic>> loans = [];
  int currentPage = 1;
  List<Map<String, String>>? selectedDocs;
  final int rowsPerPage = 5;

  final List<String> statusOptions = [
    "All",
    "Approved",
    "Rejected",
    "Sanction",
    "Disburse",
    "Reschedule",
    "NPA"
  ];

  @override
  void initState() {
    super.initState();
    _loadLoans();
  }

  void _loadLoans() {
    setState(() {
      loans = [
        {
          "LoanID": "L001",
          "CustomerName": "Alice",
          "LoanType": "Home",
          "Principal": 100000,
          "CreditScore": 750,
          "Status": "Approved",
          "DocumentsVerified": true,
          "EligibilityCheck": "Pass",
          "documents": [
            {"name": "Aadhaar.pdf", "url": "/docs/alice_aadhaar.pdf"},
            {"name": "PAN.pdf", "url": "/docs/alice_pan.pdf"},
          ],
        },
        {
          "LoanID": "L002",
          "CustomerName": "Bob",
          "LoanType": "Car",
          "Principal": 20000,
          "CreditScore": 680,
          "Status": "Sanction",
          "DocumentsVerified": false,
          "EligibilityCheck": "Check",
          "documents": [],
        },
        {
          "LoanID": "L003",
          "CustomerName": "Charlie",
          "LoanType": "Personal",
          "Principal": 15000,
          "CreditScore": 600,
          "Status": "Rejected",
          "DocumentsVerified": true,
          "EligibilityCheck": "Fail",
          "documents": [
            {"name": "SalarySlip.pdf", "url": "/docs/charlie_salary.pdf"}
          ],
        },
      ];
    });
  }

  void handleAction(String loanID, String action) {
    setState(() {
      loans = loans.map((loan) {
        if (loan["LoanID"] == loanID) {
          loan["Status"] = action;
        }
        return loan;
      }).toList();
    });
  }

  List<Map<String, dynamic>> get filteredLoans {
    return loans.where((loan) {
      final q = search.toLowerCase();
      final matchesSearch =
          loan["CustomerName"].toString().toLowerCase().contains(q) ||
              loan["LoanID"].toString().toLowerCase().contains(q);
      final matchesStatus =
          statusFilter == "All" || loan["Status"] == statusFilter;
      return matchesSearch && matchesStatus;
    }).toList();
  }

  int get totalPages => (filteredLoans.length / rowsPerPage).ceil();

  List<Map<String, dynamic>> get paginatedLoans {
    final start = (currentPage - 1) * rowsPerPage;
    final end = start + rowsPerPage;
    return filteredLoans.sublist(
        start, end > filteredLoans.length ? filteredLoans.length : end);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const TopNavbar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildTabs(),
                        const SizedBox(height: 20),
                        _buildFilters(),
                        const SizedBox(height: 20),
                        _buildTable(),
                        const SizedBox(height: 20),
                        _buildPagination(),
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

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      color: LoanStyles.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Loan Management', style: LoanStyles.headerTitle),
          const SizedBox(height: 6),
          Text(
            'Track, manage, and approve all user loan requests efficiently.',
            style: LoanStyles.headerSubtitle,
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Wrap(
      spacing: 12,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: [
        _buildTab("applications", "Loan Applications"),
        _buildTab("accounts", "Loan Accounts"),
      ],
    );
  }

  Widget _buildTab(String tab, String label) {
    final isActive = activeTab == tab;
    return ElevatedButton(
      onPressed: () => setState(() => activeTab = tab),
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? LoanStyles.primaryColor : Colors.grey[300],
        foregroundColor: isActive ? Colors.white : Colors.black87,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        elevation: 0,
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildFilters() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search by Loan ID or Customer...',
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: LoanStyles.primaryColor),
              ),
            ),
            onChanged: (value) {
              setState(() {
                search = value;
                currentPage = 1;
              });
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: DropdownButtonFormField<String>(
            initialValue: statusFilter,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: LoanStyles.primaryColor),
              ),
            ),
            items: statusOptions.map((status) {
              return DropdownMenuItem(
                value: status,
                child: Text(status == "All" ? "All Status" : status),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                statusFilter = value!;
                currentPage = 1;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(const Color(0xFFF7F7F7)),
          dataRowColor: WidgetStateProperty.resolveWith((states) => Colors.transparent),
          columnSpacing: 16,
          columns: _buildColumns(),
          rows: paginatedLoans.isEmpty
              ? [
                  DataRow(
                    color: WidgetStateProperty.all(Colors.transparent),
                    cells: [
                      const DataCell(
                        SizedBox(
                          width: 600,
                          child: Center(
                            child: Text(
                              'No loans found',
                              style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]
              : paginatedLoans.map((loan) => _buildRow(loan)).toList(),
        ),
      ),
    );
  }

  List<DataColumn> _buildColumns() {
    if (activeTab == "applications") {
      return const [
        DataColumn(label: Text('Loan ID', style: TextStyle(fontWeight: FontWeight.w600))),
        DataColumn(label: Text('Customer', style: TextStyle(fontWeight: FontWeight.w600))),
        DataColumn(label: Text('Loan Type', style: TextStyle(fontWeight: FontWeight.w600))),
        DataColumn(label: Text('Principal', style: TextStyle(fontWeight: FontWeight.w600))),
        DataColumn(label: Text('Credit Score', style: TextStyle(fontWeight: FontWeight.w600))),
        DataColumn(label: Text('Documents', style: TextStyle(fontWeight: FontWeight.w600))),
        DataColumn(label: Text('Eligibility', style: TextStyle(fontWeight: FontWeight.w600))),
        DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.w600))),
        DataColumn(label: Text('Actions', style: TextStyle(fontWeight: FontWeight.w600))),
      ];
    } else {
      return const [
        DataColumn(label: Text('Loan ID', style: TextStyle(fontWeight: FontWeight.w600))),
        DataColumn(label: Text('Customer', style: TextStyle(fontWeight: FontWeight.w600))),
        DataColumn(label: Text('Loan Type', style: TextStyle(fontWeight: FontWeight.w600))),
        DataColumn(label: Text('Principal', style: TextStyle(fontWeight: FontWeight.w600))),
        DataColumn(label: Text('Remaining', style: TextStyle(fontWeight: FontWeight.w600))),
        DataColumn(label: Text('EMI', style: TextStyle(fontWeight: FontWeight.w600))),
        DataColumn(label: Text('Tenure', style: TextStyle(fontWeight: FontWeight.w600))),
        DataColumn(label: Text('Repayment', style: TextStyle(fontWeight: FontWeight.w600))),
        DataColumn(label: Text('Default', style: TextStyle(fontWeight: FontWeight.w600))),
        DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.w600))),
        DataColumn(label: Text('Actions', style: TextStyle(fontWeight: FontWeight.w600))),
      ];
    }
  }

  DataRow _buildRow(Map<String, dynamic> loan) {
    if (activeTab == "applications") {
      return DataRow(
        color: WidgetStateProperty.all(Colors.transparent),
        cells: [
          DataCell(Text(loan["LoanID"])),
          DataCell(Text(loan["CustomerName"])),
          DataCell(Text(loan["LoanType"])),
          DataCell(Text(loan["Principal"].toString())),
          DataCell(Text(loan["CreditScore"].toString())),
          DataCell(_buildViewDocs(loan)),
          DataCell(Text(loan["EligibilityCheck"])),
          DataCell(_buildStatus(loan["Status"])),
          DataCell(_buildActions(loan["LoanID"])),
        ],
      );
    } else {
      return DataRow(
        color: WidgetStateProperty.all(Colors.transparent),
        cells: [
          DataCell(Text(loan["LoanID"])),
          DataCell(Text(loan["CustomerName"])),
          DataCell(Text(loan["LoanType"])),
          DataCell(Text(loan["Principal"].toString())),
          DataCell(Text(loan["RemainingBalance"]?.toString() ?? "-")),
          DataCell(Text(loan["EMI"]?.toString() ?? "-")),
          DataCell(Text(loan["Tenure"]?.toString() ?? "-")),
          DataCell(Text(loan["RepaymentSchedule"]?.toString() ?? "-")),
          DataCell(Text(loan["DefaultAlert"] == true ? "Yes" : "No")),
          DataCell(_buildStatus(loan["Status"])),
          DataCell(_buildAccountActions(loan["LoanID"])),
        ],
      );
    }
  }

  Widget _buildViewDocs(Map<String, dynamic> loan) {
    if (loan["DocumentsVerified"] && (loan["documents"] as List).isNotEmpty) {
      return ElevatedButton(
        onPressed: () => _showDocs((loan["documents"] as List).cast<Map<String, String>>()),
        style: ElevatedButton.styleFrom(
          backgroundColor: LoanStyles.primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          elevation: 0,
        ),
        child: const Text('View Docs', style: TextStyle(fontSize: 12)),
      );
    }
    return const Text('No Docs');
  }

  Widget _buildStatus(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: LoanStyles.getStatusColor(status),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: LoanStyles.getStatusTextColor(status),
        ),
      ),
    );
  }

  Widget _buildActions(String loanID) {
    return SizedBox(
      width: 300,
      child: Wrap(
        spacing: 6,
        runSpacing: 6,
        children: ["Approved", "Rejected", "Sanction", "Disburse", "Reschedule", "NPA"]
            .map((action) => ElevatedButton(
                  onPressed: () => handleAction(loanID, action),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LoanStyles.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    elevation: 0,
                    minimumSize: const Size(75, 32),
                  ),
                  child: Text(action, style: const TextStyle(fontSize: 11)),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildAccountActions(String loanID) {
    return SizedBox(
      width: 200,
      child: Wrap(
        spacing: 6,
        runSpacing: 6,
        children: [
          ElevatedButton(
            onPressed: () => handleAction(loanID, "Reschedule"),
            style: ElevatedButton.styleFrom(
              backgroundColor: LoanStyles.primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              elevation: 0,
            ),
            child: const Text("Reschedule", style: TextStyle(fontSize: 11)),
          ),
          ElevatedButton(
            onPressed: () => handleAction(loanID, "NPA"),
            style: ElevatedButton.styleFrom(
              backgroundColor: LoanStyles.primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              elevation: 0,
            ),
            child: const Text("Mark NPA", style: TextStyle(fontSize: 11)),
          ),
        ],
      ),
    );
  }

  Widget _buildPagination() {
    return Wrap(
      spacing: 8,
      alignment: WrapAlignment.end,
      children: [
        ElevatedButton(
          onPressed: currentPage == 1 ? null : () => setState(() => currentPage--),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: LoanStyles.primaryColor,
            side: BorderSide(color: LoanStyles.primaryColor),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            elevation: 0,
          ),
          child: const Text('Prev'),
        ),
        ...List.generate(totalPages, (i) {
          final page = i + 1;
          return ElevatedButton(
            onPressed: () => setState(() => currentPage = page),
            style: ElevatedButton.styleFrom(
              backgroundColor: currentPage == page ? LoanStyles.primaryColor : Colors.white,
              foregroundColor: currentPage == page ? Colors.white : LoanStyles.primaryColor,
              side: BorderSide(color: LoanStyles.primaryColor),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              elevation: 0,
            ),
            child: Text('$page'),
          );
        }),
        ElevatedButton(
          onPressed: currentPage == totalPages ? null : () => setState(() => currentPage++),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: LoanStyles.primaryColor,
            side: BorderSide(color: LoanStyles.primaryColor),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            elevation: 0,
          ),
          child: const Text('Next'),
        ),
      ],
    );
  }

  void _showDocs(List<Map<String, String>> docs) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('User Documents', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              ...docs.map((doc) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        doc["name"]!,
                        style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                      ),
                    ),
                  )),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: LoanStyles.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
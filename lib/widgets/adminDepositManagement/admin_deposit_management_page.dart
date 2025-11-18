import 'package:flutter/material.dart';
import '../adminDepositManagement/admin_deposit_management_styles.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AdminDepositManagement extends StatefulWidget {
  const AdminDepositManagement({super.key});

  @override
  State<AdminDepositManagement> createState() => _AdminDepositManagementState();
}

class _AdminDepositManagementState extends State<AdminDepositManagement> {
  String activeTab = 'applications';
  String notification = '';
  Map<String, dynamic>? modalData;
  Map<String, dynamic>? formatModalData;
  String searchQuery = '';
  String statusFilter = 'All Statuses';

  List<Map<String, dynamic>> applications = [
    {
      'id': 1,
      'user': 'Alice',
      'type': 'FD',
      'amount': 50000,
      'status': 'Pending',
      'startDate': '2025-01-01',
      'dueDate': '2025-12-31',
      'interest': '-',
    },
    {
      'id': 2,
      'user': 'Bob',
      'type': 'RD',
      'amount': 10000,
      'status': 'Pending',
      'startDate': '2025-02-01',
      'dueDate': '2026-02-01',
      'interest': '-',
    },
    {
      'id': 3,
      'user': 'Carol',
      'type': 'FD',
      'amount': 75000,
      'status': 'Approved',
      'startDate': '2025-01-15',
      'dueDate': '2026-01-15',
      'interest': '4500',
    },
    {
      'id': 4,
      'user': 'David',
      'type': 'RD',
      'amount': 20000,
      'status': 'Rejected',
      'startDate': '2025-03-01',
      'dueDate': '2026-03-01',
      'interest': '-',
    },
  ];

  List<Map<String, dynamic>> maturities = [
    {
      'id': 3,
      'user': 'Charlie',
      'type': 'FD',
      'amount': 70000,
      'status': 'Pending',
      'maturityDate': '2025-10-01',
    },
    {
      'id': 4,
      'user': 'Daisy',
      'type': 'RD',
      'amount': 15000,
      'status': 'Pending',
      'maturityDate': '2025-10-05',
    },
    {
      'id': 5,
      'user': 'Edward',
      'type': 'FD',
      'amount': 90000,
      'status': 'Renewed',
      'maturityDate': '2025-11-01',
    },
    {
      'id': 6,
      'user': 'Fiona',
      'type': 'RD',
      'amount': 25000,
      'status': 'Closed',
      'maturityDate': '2025-09-15',
    },
  ];

  List<Map<String, dynamic>> withdrawals = [
    {
      'id': 5,
      'user': 'Eve',
      'type': 'FD',
      'amount': 20000,
      'penalty': 500,
      'status': 'Pending',
    },
    {
      'id': 6,
      'user': 'Frank',
      'type': 'RD',
      'amount': 8000,
      'penalty': 200,
      'status': 'Pending',
    },
    {
      'id': 7,
      'user': 'Grace',
      'type': 'FD',
      'amount': 35000,
      'penalty': 1000,
      'status': 'Approved',
    },
    {
      'id': 8,
      'user': 'Henry',
      'type': 'RD',
      'amount': 12000,
      'penalty': 300,
      'status': 'Rejected',
    },
  ];

  void showMessage(String msg) {
    setState(() {
      notification = msg;
    });
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          notification = '';
        });
      }
    });
  }

  String calculateInterest(int amount, String startDate, String dueDate) {
    final start = DateTime.parse(startDate);
    final end = DateTime.parse(dueDate);
    final years = end.difference(start).inDays / 365;
    return ((amount * 6 * years) / 100).toStringAsFixed(2);
  }

  void handleTabChange(String tab) {
    setState(() {
      activeTab = tab;
      searchQuery = '';
      statusFilter = 'All Statuses';
    });
  }

  void handleModalSave() {
    if (modalData == null) return;
    final row = modalData!['row'];
    final action = modalData!['action'];
    final interest = modalData!['interest'];

    setState(() {
      if (activeTab == 'applications') {
        applications = applications.map((r) {
          if (r['id'] == row['id']) {
            return {...r, 'status': action, 'interest': interest};
          }
          return r;
        }).toList();
      }
      modalData = null;
    });
    showMessage('✅ Request $action');
  }

  void handleMaturityAction(int id, String action) {
    setState(() {
      maturities = maturities.map((r) {
        if (r['id'] == id) {
          return {...r, 'status': action};
        }
        return r;
      }).toList();
    });
    showMessage('✅ Deposit ${action.toLowerCase()}');
  }

  void handleWithdrawalAction(int id, String action) {
    setState(() {
      withdrawals = withdrawals.map((r) {
        if (r['id'] == id) {
          return {...r, 'status': action};
        }
        return r;
      }).toList();
    });
    showMessage('✅ Withdrawal ${action.toLowerCase()}');
  }

  void handleGenerateInstrument(Map<String, dynamic> row) {
    setState(() {
      formatModalData = row;
    });
  }

  void downloadInstrument(Map<String, dynamic> row, String format) {
    final instrumentData = {
      'depositId': row['id'],
      'customerName': row['user'],
      'depositType': row['type'],
      'amount': row['amount'],
      'startDate':
          row['startDate'] ?? DateFormat('yyyy-MM-dd').format(DateTime.now()),
      'dueDate': row['dueDate'] ?? row['maturityDate'] ?? 'N/A',
      'interest': row['interest'] ?? 'N/A',
      'status': row['status'],
      'generatedDate': DateFormat('yyyy-MM-dd').format(DateTime.now()),
    };

    if (format == 'csv') {
      downloadCSV(instrumentData);
    } else if (format == 'pdf') {
      downloadPDF(instrumentData);
    } else if (format == 'excel') {
      downloadExcel(instrumentData);
    }

    showMessage('📥 ${format.toUpperCase()} downloaded for ${row['user']}');
    setState(() {
      formatModalData = null;
    });
  }

  void downloadCSV(Map<String, dynamic> data) {
    final csvContent =
        '''Field,Value
Deposit ID,${data['depositId']}
Customer Name,${data['customerName']}
Deposit Type,${data['depositType']}
Amount,₹${data['amount']}
Start Date,${data['startDate']}
Due Date,${data['dueDate']}
Interest,${data['interest']}
Status,${data['status']}
Generated Date,${data['generatedDate']}''';

    Clipboard.setData(ClipboardData(text: csvContent));
  }

  void downloadPDF(Map<String, dynamic> data) {
    final pdfContent =
        '''
DEPOSIT INSTRUMENT
==================

Deposit ID: ${data['depositId']}
Customer Name: ${data['customerName']}
Deposit Type: ${data['depositType']}
Amount: ₹${data['amount']}
Start Date: ${data['startDate']}
Due Date: ${data['dueDate']}
Interest: ${data['interest']}
Status: ${data['status']}
Generated Date: ${data['generatedDate']}

==================
Bank Management System
    ''';

    Clipboard.setData(ClipboardData(text: pdfContent));
  }

  void downloadExcel(Map<String, dynamic> data) {
    final excelContent =
        '''Deposit ID\t${data['depositId']}
Customer Name\t${data['customerName']}
Deposit Type\t${data['depositType']}
Amount\t₹${data['amount']}
Start Date\t${data['startDate']}
Due Date\t${data['dueDate']}
Interest\t${data['interest']}
Status\t${data['status']}
Generated Date\t${data['generatedDate']}''';

    Clipboard.setData(ClipboardData(text: excelContent));
  }

  List<Map<String, dynamic>> filterRows(List<Map<String, dynamic>> rows) {
    return rows.where((row) {
      final matchesSearch = row['user'].toString().toLowerCase().contains(
        searchQuery.toLowerCase(),
      );
      final matchesStatus =
          statusFilter == 'All Statuses' || row['status'] == statusFilter;
      return matchesSearch && matchesStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Heading Bar
                      Container(
                        width: double.infinity,
                        decoration: DepositStyles.headingBarDecoration,
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 16 : 32,
                          vertical: isMobile ? 16 : 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Deposits Management',
                              style: TextStyle(
                                fontSize: isMobile ? 25 : 35,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Deposit Management with Neo',
                              style: TextStyle(
                                fontSize: isMobile ? 12 : 15,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Container
                      Container(
                        decoration: DepositStyles.containerDecoration,
                        padding: EdgeInsets.all(isMobile ? 16 : 32),
                        child: Column(
                          children: [
                            // Tabs
                            if (isMobile)
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildTab(
                                          'Applications',
                                          'applications',
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: _buildTab(
                                          'Maturities',
                                          'maturities',
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  _buildTab('Withdrawals', 'withdrawals'),
                                ],
                              )
                            else
                              Wrap(
                                spacing: 16,
                                runSpacing: 16,
                                alignment: WrapAlignment.center,
                                children: [
                                  _buildTab('Applications', 'applications'),
                                  _buildTab('Maturities', 'maturities'),
                                  _buildTab('Withdrawals', 'withdrawals'),
                                ],
                              ),
                            const SizedBox(height: 24),

                            // Content
                            if (activeTab == 'applications')
                              _buildApplicationsTable(isMobile),
                            if (activeTab == 'maturities')
                              _buildMaturitiesTable(isMobile),
                            if (activeTab == 'withdrawals')
                              _buildWithdrawalsTable(isMobile),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (modalData != null) _buildApprovalModal(isMobile),
          if (formatModalData != null) _buildFormatModal(isMobile),
        ],
      ),
    );
  }

  Widget _buildTab(String label, String value) {
    final isActive = activeTab == value;
    return GestureDetector(
      onTap: () => handleTabChange(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: DepositStyles.tabDecoration(isActive),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.white : const Color(0xFF900603),
          ),
        ),
      ),
    );
  }

  Widget _buildApplicationsTable(bool isMobile) {
    final filteredData = filterRows(applications);

    return Container(
      decoration: DepositStyles.tableCardDecoration,
      padding: EdgeInsets.all(isMobile ? 16 : 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFF900603), width: 3),
              ),
            ),
            child: Text(
              'Deposit Applications',
              style: TextStyle(
                color: const Color(0xFF900603),
                fontSize: isMobile ? 16 : 24,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 16),

          if (notification.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: DepositStyles.notificationDecoration,
              child: Text(
                notification,
                style: TextStyle(
                  color: const Color(0xFF900603),
                  fontWeight: FontWeight.w600,
                  fontSize: isMobile ? 13 : 15,
                ),
              ),
            ),

          // Filters
          Column(
            children: [
              TextField(
                decoration: DepositStyles.inputDecoration('Search customer...'),
                onChanged: (value) => setState(() => searchQuery = value),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: statusFilter,
                decoration: DepositStyles.inputDecoration(''),
                isExpanded: true,
                items: ['All Statuses', 'Pending', 'Approved', 'Rejected']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (value) => setState(() => statusFilter = value!),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Mobile Cards or Desktop Table
          if (isMobile)
            Column(
              children: filteredData.isEmpty
                  ? [
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: Text('No results found'),
                        ),
                      ),
                    ]
                  : filteredData
                        .map((row) => _buildMobileCard(row, 'application'))
                        .toList(),
            )
          else
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                decoration: DepositStyles.tableDecoration,
                headingRowColor: WidgetStateProperty.all(
                  const Color(0xFF900603),
                ),
                columns: const [
                  DataColumn(
                    label: Text('User', style: DepositStyles.tableHeaderStyle),
                  ),
                  DataColumn(
                    label: Text('Type', style: DepositStyles.tableHeaderStyle),
                  ),
                  DataColumn(
                    label: Text(
                      'Amount',
                      style: DepositStyles.tableHeaderStyle,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Start Date',
                      style: DepositStyles.tableHeaderStyle,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Due Date',
                      style: DepositStyles.tableHeaderStyle,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Status',
                      style: DepositStyles.tableHeaderStyle,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Interest',
                      style: DepositStyles.tableHeaderStyle,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Approve',
                      style: DepositStyles.tableHeaderStyle,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Reject',
                      style: DepositStyles.tableHeaderStyle,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Instrument',
                      style: DepositStyles.tableHeaderStyle,
                    ),
                  ),
                ],
                rows: filteredData.map((row) {
                  return DataRow(
                    cells: [
                      DataCell(Text(row['user'])),
                      DataCell(Text(row['type'])),
                      DataCell(Text('₹${row['amount']}')),
                      DataCell(Text(row['startDate'])),
                      DataCell(Text(row['dueDate'])),
                      DataCell(_buildStatusBadge(row['status'])),
                      DataCell(Text(row['interest'])),
                      DataCell(
                        ElevatedButton(
                          onPressed: () {
                            final interest = calculateInterest(
                              row['amount'],
                              row['startDate'],
                              row['dueDate'],
                            );
                            setState(() {
                              modalData = {
                                'row': row,
                                'action': 'Approved',
                                'interest': interest,
                              };
                            });
                          },
                          style: DepositStyles.approveButtonStyle,
                          child: const Text('Approve'),
                        ),
                      ),
                      DataCell(
                        ElevatedButton(
                          onPressed: () {
                            final interest = calculateInterest(
                              row['amount'],
                              row['startDate'],
                              row['dueDate'],
                            );
                            setState(() {
                              modalData = {
                                'row': row,
                                'action': 'Rejected',
                                'interest': interest,
                              };
                            });
                          },
                          style: DepositStyles.rejectButtonStyle,
                          child: const Text('Reject'),
                        ),
                      ),
                      DataCell(
                        row['status'] == 'Approved'
                            ? ElevatedButton(
                                onPressed: () => handleGenerateInstrument(row),
                                style: DepositStyles.generateButtonStyle,
                                child: const Text('Generate'),
                              )
                            : const SizedBox(),
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

  Widget _buildMaturitiesTable(bool isMobile) {
    final filteredData = filterRows(maturities);

    return Container(
      decoration: DepositStyles.tableCardDecoration,
      padding: EdgeInsets.all(isMobile ? 16 : 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFF900603), width: 3),
              ),
            ),
            child: Text(
              'Maturities',
              style: TextStyle(
                color: const Color(0xFF900603),
                fontSize: isMobile ? 16 : 24,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 16),

          if (notification.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: DepositStyles.notificationDecoration,
              child: Text(
                notification,
                style: TextStyle(
                  color: const Color(0xFF900603),
                  fontWeight: FontWeight.w600,
                  fontSize: isMobile ? 13 : 15,
                ),
              ),
            ),

          // Filters
          Column(
            children: [
              TextField(
                decoration: DepositStyles.inputDecoration('Search customer...'),
                onChanged: (value) => setState(() => searchQuery = value),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: statusFilter,
                decoration: DepositStyles.inputDecoration(''),
                isExpanded: true,
                items: ['All Statuses', 'Pending', 'Renewed', 'Closed']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (value) => setState(() => statusFilter = value!),
              ),
            ],
          ),
          const SizedBox(height: 16),

          if (isMobile)
            Column(
              children: filteredData.isEmpty
                  ? [
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: Text('No results found'),
                        ),
                      ),
                    ]
                  : filteredData
                        .map((row) => _buildMobileCard(row, 'maturity'))
                        .toList(),
            )
          else
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                decoration: DepositStyles.tableDecoration,
                headingRowColor: WidgetStateProperty.all(
                  const Color(0xFF900603),
                ),
                columns: const [
                  DataColumn(
                    label: Text('User', style: DepositStyles.tableHeaderStyle),
                  ),
                  DataColumn(
                    label: Text('Type', style: DepositStyles.tableHeaderStyle),
                  ),
                  DataColumn(
                    label: Text(
                      'Amount',
                      style: DepositStyles.tableHeaderStyle,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Maturity Date',
                      style: DepositStyles.tableHeaderStyle,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Status',
                      style: DepositStyles.tableHeaderStyle,
                    ),
                  ),
                  DataColumn(
                    label: Text('Renew', style: DepositStyles.tableHeaderStyle),
                  ),
                  DataColumn(
                    label: Text('Close', style: DepositStyles.tableHeaderStyle),
                  ),
                  DataColumn(
                    label: Text(
                      'Generate',
                      style: DepositStyles.tableHeaderStyle,
                    ),
                  ),
                ],
                rows: filteredData.map((row) {
                  return DataRow(
                    cells: [
                      DataCell(Text(row['user'])),
                      DataCell(Text(row['type'])),
                      DataCell(Text('₹${row['amount']}')),
                      DataCell(Text(row['maturityDate'])),
                      DataCell(_buildStatusBadge(row['status'])),
                      DataCell(
                        ElevatedButton(
                          onPressed: () =>
                              handleMaturityAction(row['id'], 'Renewed'),
                          style: DepositStyles.renewButtonStyle,
                          child: const Text('Renew'),
                        ),
                      ),
                      DataCell(
                        ElevatedButton(
                          onPressed: () =>
                              handleMaturityAction(row['id'], 'Closed'),
                          style: DepositStyles.closeButtonStyle,
                          child: const Text('Close'),
                        ),
                      ),
                      DataCell(
                        (row['status'] == 'Renewed' ||
                                row['status'] == 'Closed')
                            ? ElevatedButton(
                                onPressed: () => handleGenerateInstrument(row),
                                style: DepositStyles.generateButtonStyle,
                                child: const Text('Generate'),
                              )
                            : const SizedBox(),
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

  Widget _buildWithdrawalsTable(bool isMobile) {
    final filteredData = filterRows(withdrawals);

    return Container(
      decoration: DepositStyles.tableCardDecoration,
      padding: EdgeInsets.all(isMobile ? 16 : 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFF900603), width: 3),
              ),
            ),
            child: Text(
              'Early Withdrawal Requests',
              style: TextStyle(
                color: const Color(0xFF900603),
                fontSize: isMobile ? 16 : 24,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 16),

          if (notification.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: DepositStyles.notificationDecoration,
              child: Text(
                notification,
                style: TextStyle(
                  color: const Color(0xFF900603),
                  fontWeight: FontWeight.w600,
                  fontSize: isMobile ? 13 : 15,
                ),
              ),
            ),

          // Filters
          Column(
            children: [
              TextField(
                decoration: DepositStyles.inputDecoration('Search customer...'),
                onChanged: (value) => setState(() => searchQuery = value),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: statusFilter,
                decoration: DepositStyles.inputDecoration(''),
                isExpanded: true,
                items: ['All Statuses', 'Pending', 'Approved', 'Rejected']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (value) => setState(() => statusFilter = value!),
              ),
            ],
          ),
          const SizedBox(height: 16),

          if (isMobile)
            Column(
              children: filteredData.isEmpty
                  ? [
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: Text('No results found'),
                        ),
                      ),
                    ]
                  : filteredData
                        .map((row) => _buildMobileCard(row, 'withdrawal'))
                        .toList(),
            )
          else
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                decoration: DepositStyles.tableDecoration,
                headingRowColor: WidgetStateProperty.all(
                  const Color(0xFF900603),
                ),
                columns: const [
                  DataColumn(
                    label: Text('User', style: DepositStyles.tableHeaderStyle),
                  ),
                  DataColumn(
                    label: Text('Type', style: DepositStyles.tableHeaderStyle),
                  ),
                  DataColumn(
                    label: Text(
                      'Amount',
                      style: DepositStyles.tableHeaderStyle,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Penalty',
                      style: DepositStyles.tableHeaderStyle,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Status',
                      style: DepositStyles.tableHeaderStyle,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Approve',
                      style: DepositStyles.tableHeaderStyle,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Reject',
                      style: DepositStyles.tableHeaderStyle,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Generate',
                      style: DepositStyles.tableHeaderStyle,
                    ),
                  ),
                ],
                rows: filteredData.map((row) {
                  return DataRow(
                    cells: [
                      DataCell(Text(row['user'])),
                      DataCell(Text(row['type'])),
                      DataCell(Text('₹${row['amount']}')),
                      DataCell(Text('₹${row['penalty']}')),
                      DataCell(_buildStatusBadge(row['status'])),
                      DataCell(
                        ElevatedButton(
                          onPressed: () =>
                              handleWithdrawalAction(row['id'], 'Approved'),
                          style: DepositStyles.approveButtonStyle,
                          child: const Text('Approve'),
                        ),
                      ),
                      DataCell(
                        ElevatedButton(
                          onPressed: () =>
                              handleWithdrawalAction(row['id'], 'Rejected'),
                          style: DepositStyles.rejectButtonStyle,
                          child: const Text('Reject'),
                        ),
                      ),
                      DataCell(
                        row['status'] == 'Approved'
                            ? ElevatedButton(
                                onPressed: () => handleGenerateInstrument(row),
                                style: DepositStyles.generateButtonStyle,
                                child: const Text('Generate'),
                              )
                            : const SizedBox(),
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

  Widget _buildMobileCard(Map<String, dynamic> row, String type) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  row['user'],
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF900603),
                  ),
                ),
                _buildStatusBadge(row['status']),
              ],
            ),
            const SizedBox(height: 10),
            _buildInfoRow('Type', row['type']),
            _buildInfoRow('Amount', '₹${row['amount']}'),
            if (type == 'application') ...[
              _buildInfoRow('Start Date', row['startDate']),
              _buildInfoRow('Due Date', row['dueDate']),
              _buildInfoRow('Interest', row['interest']),
            ],
            if (type == 'maturity')
              _buildInfoRow('Maturity Date', row['maturityDate']),
            if (type == 'withdrawal')
              _buildInfoRow('Penalty', '₹${row['penalty']}'),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (type == 'application') ...[
                  _buildSmallButton(
                    'Approve',
                    const Color.fromARGB(255, 151, 2, 2),
                    () {
                      final interest = calculateInterest(
                        row['amount'],
                        row['startDate'],
                        row['dueDate'],
                      );
                      setState(() {
                        modalData = {
                          'row': row,
                          'action': 'Approved',
                          'interest': interest,
                        };
                      });
                    },
                  ),
                  _buildSmallButton(
                    'Reject',
                    const Color.fromARGB(255, 141, 11, 2),
                    () {
                      final interest = calculateInterest(
                        row['amount'],
                        row['startDate'],
                        row['dueDate'],
                      );
                      setState(() {
                        modalData = {
                          'row': row,
                          'action': 'Rejected',
                          'interest': interest,
                        };
                      });
                    },
                  ),
                  if (row['status'] == 'Approved')
                    _buildSmallButton(
                      'Generate',
                      const Color.fromARGB(255, 32, 133, 1),
                      () {
                        handleGenerateInstrument(row);
                      },
                    ),
                ],
                if (type == 'maturity') ...[
                  _buildSmallButton(
                    'Renew',
                    const Color.fromARGB(255, 153, 2, 2),
                    () {
                      handleMaturityAction(row['id'], 'Renewed');
                    },
                  ),
                  _buildSmallButton(
                    'Close',
                    const Color.fromARGB(255, 154, 2, 2),
                    () {
                      handleMaturityAction(row['id'], 'Closed');
                    },
                  ),
                  if (row['status'] == 'Renewed' || row['status'] == 'Closed')
                    _buildSmallButton(
                      'Generate',
                      const Color.fromARGB(255, 33, 144, 2),
                      () {
                        handleGenerateInstrument(row);
                      },
                    ),
                ],
                if (type == 'withdrawal') ...[
                  _buildSmallButton(
                    'Approve',
                    const Color.fromARGB(255, 152, 1, 1),
                    () {
                      handleWithdrawalAction(row['id'], 'Approved');
                    },
                  ),
                  _buildSmallButton(
                    'Reject',
                    const Color.fromARGB(255, 151, 2, 2),
                    () {
                      handleWithdrawalAction(row['id'], 'Rejected');
                    },
                  ),
                  if (row['status'] == 'Approved')
                    _buildSmallButton(
                      'Generate',
                      const Color.fromARGB(255, 1, 125, 20),
                      () {
                        handleGenerateInstrument(row);
                      },
                    ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallButton(String label, Color color, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        minimumSize: const Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: DepositStyles.statusBadgeDecoration(status),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: DepositStyles.getStatusColor(status),
          fontWeight: FontWeight.w600,
          fontSize: 11,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildApprovalModal(bool isMobile) {
    final row = modalData!['row'];
    final action = modalData!['action'];
    final interest = modalData!['interest'];

    return Positioned.fill(
      child: Container(
        color: Colors.black.withValues(alpha: 0.5),
        child: Center(
          child: Container(
            width: isMobile ? MediaQuery.of(context).size.width * 0.9 : 400,
            decoration: DepositStyles.modalDecoration,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: DepositStyles.modalTopBorder,
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Confirm $action',
                          style: DepositStyles.modalTitleStyle.copyWith(
                            fontSize: isMobile ? 16 : 18,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => setState(() => modalData = null),
                        icon: const Icon(Icons.close, color: Color(0xFF900603)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Are you sure you want to $action this deposit application?',
                        style: DepositStyles.modalTextStyle.copyWith(
                          fontSize: isMobile ? 13 : 15,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'User: ${row['user']}',
                        style: DepositStyles.modalTextStyle.copyWith(
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        'Type: ${row['type']}',
                        style: DepositStyles.modalTextStyle.copyWith(
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        'Amount: ₹${row['amount']}',
                        style: DepositStyles.modalTextStyle.copyWith(
                          fontSize: 13,
                        ),
                      ),
                      if (action == 'Approved')
                        Text(
                          'Interest: ₹$interest',
                          style: DepositStyles.modalTextStyle.copyWith(
                            fontSize: 13,
                          ),
                        ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () => setState(() => modalData = null),
                            style: DepositStyles.modalCancelButtonStyle,
                            child: const Text(
                              'Cancel',
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: handleModalSave,
                            style: action == 'Approved'
                                ? DepositStyles.approveButtonStyle
                                : DepositStyles.rejectButtonStyle,
                            child: Text(
                              action,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormatModal(bool isMobile) {
    final row = formatModalData!;

    return Positioned.fill(
      child: Container(
        color: Colors.black.withValues(alpha: 0.5),
        child: Center(
          child: Container(
            width: isMobile ? MediaQuery.of(context).size.width * 0.9 : 400,
            decoration: DepositStyles.modalDecoration,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: DepositStyles.modalTopBorder,
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Generate Instrument',
                          style: DepositStyles.modalTitleStyle.copyWith(
                            fontSize: isMobile ? 16 : 18,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => setState(() => formatModalData = null),
                        icon: const Icon(Icons.close, color: Color(0xFF900603)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select format for ${row['user']}\'s deposit instrument:',
                        style: DepositStyles.modalTextStyle.copyWith(
                          fontSize: isMobile ? 13 : 15,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          GestureDetector(
                            onTap: () => downloadInstrument(row, 'csv'),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: DepositStyles.formatButtonDecoration,
                              child: Text(
                                'CSV',
                                style: DepositStyles.formatButtonTextStyle
                                    .copyWith(fontSize: 13),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => downloadInstrument(row, 'pdf'),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: DepositStyles.formatButtonDecoration,
                              child: Text(
                                'PDF',
                                style: DepositStyles.formatButtonTextStyle
                                    .copyWith(fontSize: 13),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => downloadInstrument(row, 'excel'),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: DepositStyles.formatButtonDecoration,
                              child: Text(
                                'Excel',
                                style: DepositStyles.formatButtonTextStyle
                                    .copyWith(fontSize: 13),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () =>
                                setState(() => formatModalData = null),
                            style: DepositStyles.modalCancelButtonStyle,
                            child: const Text(
                              'Cancel',
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
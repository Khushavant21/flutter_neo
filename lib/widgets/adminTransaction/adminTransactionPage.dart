import 'package:flutter/material.dart';
import '../adminTransaction/adminTransactionStyles.dart';

class AdminTransactionPage extends StatefulWidget {
  const AdminTransactionPage({super.key});

  @override
  State<AdminTransactionPage> createState() => _AdminTransactionPageState();
}

class _AdminTransactionPageState extends State<AdminTransactionPage> {
  final TextEditingController _searchController = TextEditingController();
  String filterType = "All";
  String activeTab = "all";
  Map<String, dynamic>? selectedTxn;
  
  final List<Map<String, dynamic>> transactions = [
    {
      "id": "TXN1001",
      "date": "2025-09-25 11:00 AM",
      "account": "AC1234567890",
      "customer": "Ravi Kumar",
      "type": "Credit",
      "amount": 20000,
      "status": "Success",
      "channel": "Internet Banking",
      "reference": "REF1001"
    },
    {
      "id": "TXN1002",
      "date": "2025-09-25 11:15 AM",
      "account": "AC2345678901",
      "customer": "Anita Sharma",
      "type": "Transfer",
      "amount": 5000,
      "status": "Pending",
      "channel": "Mobile App",
      "reference": "REF1002"
    },
    {
      "id": "TXN1003",
      "date": "2025-09-25 11:30 AM",
      "account": "AC3456789012",
      "customer": "Amit Verma",
      "type": "Debit",
      "amount": 7000,
      "status": "Failed",
      "reason": "Insufficient Balance",
      "channel": "ATM",
      "reference": "REF1003"
    },
    {
      "id": "TXN1004",
      "date": "2025-09-25 10:45 AM",
      "account": "AC4567890123",
      "customer": "Priya Singh",
      "type": "Credit",
      "amount": 15000,
      "status": "Success",
      "channel": "Branch",
      "reference": "REF1004"
    },
    {
      "id": "TXN1005",
      "date": "2025-09-25 09:30 AM",
      "account": "AC5678901234",
      "customer": "Rajesh Patel",
      "type": "Transfer",
      "amount": 30000,
      "status": "Success",
      "channel": "Internet Banking",
      "reference": "REF1005"
    }
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String formatCurrency(double value) {
    return "₹${value.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    )}";
  }

  List<Map<String, dynamic>> get filteredTransactions {
    return transactions.where((txn) {
      if (activeTab == "pending" && txn["status"] != "Pending") return false;
      if (activeTab == "failed" && txn["status"] != "Failed") return false;
      if (activeTab == "reconciliation" && txn["status"] != "Success") return false;

      final searchLower = _searchController.text.toLowerCase();
      return (filterType == "All" || txn["type"] == filterType) &&
          (txn["customer"].toString().toLowerCase().contains(searchLower) ||
              txn["id"].toString().contains(searchLower) ||
              txn["account"].toString().contains(searchLower));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;
    final horizontalPadding = isMobile ? 0.0 : (isTablet ? 24.0 : 32.0);
    
    return Scaffold(
      backgroundColor: TransactionStyles.backgroundColor,
      body: Column(
        children: [
          // Header Section
          Container(
            width: double.infinity,
            decoration: TransactionStyles.headerDecoration,
            padding: EdgeInsets.all(isMobile ? 16 : (isTablet ? 24 : 32)),
            child: isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Transaction Management',
                        style: TransactionStyles.headerTitleStyle.copyWith(
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Monitor and manage transactions',
                        style: TransactionStyles.headerSubtitleStyle.copyWith(
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: TransactionStyles.statCardDecoration,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.pie_chart, color: Colors.white, size: 16),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${transactions.length}',
                                  style: TransactionStyles.statValueStyle.copyWith(
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  'Total Transactions',
                                  style: TransactionStyles.statLabelStyle.copyWith(
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Transaction Management',
                            style: TransactionStyles.headerTitleStyle,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Monitor, manage, and review all banking transactions efficiently',
                            style: TransactionStyles.headerSubtitleStyle,
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        decoration: TransactionStyles.statCardDecoration,
                        child: Row(
                          children: [
                            const Icon(Icons.pie_chart, color: Colors.white, size: 20),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${transactions.length}',
                                  style: TransactionStyles.statValueStyle,
                                ),
                                Text(
                                  'Total Transactions',
                                  style: TransactionStyles.statLabelStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),

          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 12 : horizontalPadding,
                vertical: isMobile ? 12 : 32,
              ),
              child: Column(
                children: [
                  // Tabs
                  Container(
                    decoration: TransactionStyles.tabsContainerDecoration,
                    padding: const EdgeInsets.all(6),
                    child: isMobile
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  _buildTab('all', 'All'),
                                  _buildTab('pending', 'Pending'),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  _buildTab('failed', 'Failed'),
                                  _buildTab('reconciliation', 'Reconcile'),
                                ],
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              _buildTab('all', 'All Transactions'),
                              _buildTab('pending', 'Pending Transfers'),
                              _buildTab('failed', 'Failed / Rejected'),
                              _buildTab('reconciliation', 'Reconciliation'),
                            ],
                          ),
                  ),
                  const SizedBox(height: 16),

                  // Filters Section
                  Container(
                    decoration: TransactionStyles.filtersDecoration,
                    padding: EdgeInsets.all(isMobile ? 12 : 24),
                    child: Column(
                      children: [
                        TextField(
                          controller: _searchController,
                          decoration: TransactionStyles.searchInputDecoration,
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Transaction Type',
                              style: TransactionStyles.filterLabelStyle,
                            ),
                            const SizedBox(height: 8),
                            Container(
                              decoration: TransactionStyles.dropdownDecoration,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: filterType,
                                  isExpanded: true,
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  items: ['All', 'Credit', 'Debit', 'Transfer']
                                      .map((type) => DropdownMenuItem(
                                            value: type,
                                            child: Text(
                                              type == 'All' ? 'All Transactions' : type,
                                              style: TransactionStyles.dropdownItemStyle,
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      filterType = value!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Table Section - Card View for Mobile
                  Container(
                    decoration: TransactionStyles.tableContainerDecoration,
                    child: Column(
                      children: [
                        // Table Header
                        Padding(
                          padding: EdgeInsets.all(isMobile ? 12 : 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  _getTableTitle(),
                                  style: TransactionStyles.tableHeaderTitleStyle.copyWith(
                                    fontSize: isMobile ? 14 : 20,
                                  ),
                                ),
                              ),
                              if (!isMobile)
                                Row(
                                  children: [
                                    _buildExportButton('Export CSV', Icons.download),
                                    const SizedBox(width: 12),
                                    _buildExportButton('Export PDF', Icons.picture_as_pdf),
                                  ],
                                ),
                            ],
                          ),
                        ),

                        // Mobile Card View
                        if (isMobile)
                          filteredTransactions.isEmpty
                              ? Padding(
                                  padding: const EdgeInsets.all(32),
                                  child: Center(
                                    child: Text(
                                      'No transactions found',
                                      style: TransactionStyles.noDataStyle,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              : ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.all(12),
                                  itemCount: filteredTransactions.length,
                                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                                  itemBuilder: (context, index) {
                                    final txn = filteredTransactions[index];
                                    return _buildMobileCard(txn);
                                  },
                                )
                        else
                          // Desktop Table View
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              constraints: BoxConstraints(
                                minWidth: MediaQuery.of(context).size.width - (horizontalPadding * 2),
                              ),
                              child: DataTable(
                                headingRowColor: WidgetStateProperty.all(
                                  TransactionStyles.tableHeaderColor,
                                ),
                                columns: [
                                  DataColumn(label: Text('Txn ID', style: TransactionStyles.tableHeaderStyle)),
                                  DataColumn(label: Text('Date & Time', style: TransactionStyles.tableHeaderStyle)),
                                  DataColumn(label: Text('Account No', style: TransactionStyles.tableHeaderStyle)),
                                  DataColumn(label: Text('Customer Name', style: TransactionStyles.tableHeaderStyle)),
                                  DataColumn(label: Text('Type', style: TransactionStyles.tableHeaderStyle)),
                                  DataColumn(label: Text('Amount', style: TransactionStyles.tableHeaderStyle)),
                                  DataColumn(label: Text('Status', style: TransactionStyles.tableHeaderStyle)),
                                  if (activeTab == "failed")
                                    DataColumn(label: Text('Failure Reason', style: TransactionStyles.tableHeaderStyle)),
                                  DataColumn(label: Text('Channel', style: TransactionStyles.tableHeaderStyle)),
                                  DataColumn(label: Text('Actions', style: TransactionStyles.tableHeaderStyle)),
                                ],
                                rows: filteredTransactions.map((txn) {
                                  return DataRow(
                                    cells: [
                                      DataCell(Text(txn["id"], style: TransactionStyles.txnIdStyle)),
                                      DataCell(Text(txn["date"], style: TransactionStyles.tableCellStyle)),
                                      DataCell(Text(txn["account"], style: TransactionStyles.accountNoStyle)),
                                      DataCell(Text(txn["customer"], style: TransactionStyles.tableCellStyle)),
                                      DataCell(
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                          decoration: TransactionStyles.getTypeBadgeDecoration(txn["type"]),
                                          child: Text(
                                            txn["type"],
                                            style: TransactionStyles.getTypeBadgeStyle(txn["type"]),
                                          ),
                                        ),
                                      ),
                                      DataCell(Text(
                                        formatCurrency(txn["amount"].toDouble()),
                                        style: TransactionStyles.amountStyle,
                                      )),
                                      DataCell(
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                          decoration: TransactionStyles.getStatusBadgeDecoration(txn["status"]),
                                          child: Text(
                                            txn["status"],
                                            style: TransactionStyles.getStatusBadgeStyle(txn["status"]),
                                          ),
                                        ),
                                      ),
                                      if (activeTab == "failed")
                                        DataCell(Text(
                                          txn["reason"] ?? "—",
                                          style: TransactionStyles.tableCellStyle,
                                        )),
                                      DataCell(Text(txn["channel"], style: TransactionStyles.tableCellStyle)),
                                      DataCell(
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            setState(() {
                                              selectedTxn = txn;
                                            });
                                          },
                                          icon: const Icon(Icons.visibility, size: 16),
                                          label: const Text('View Details'),
                                          style: TransactionStyles.viewButtonStyle,
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Export Section
                  if (isMobile)
                    Container(
                      decoration: TransactionStyles.exportSectionDecoration,
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Export Reports',
                            style: TransactionStyles.exportTitleStyle.copyWith(fontSize: 14),
                          ),
                          const SizedBox(height: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _buildExportFormatButton('Export CSV'),
                              const SizedBox(height: 6),
                              _buildExportFormatButton('Export PDF'),
                              const SizedBox(height: 6),
                              _buildExportFormatButton('Export Excel'),
                            ],
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      // Transaction Details Modal
      bottomSheet: selectedTxn != null ? _buildModal() : null,
    );
  }

  Widget _buildMobileCard(Map<String, dynamic> txn) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedTxn = txn;
          });
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    txn["id"],
                    style: TransactionStyles.txnIdStyle.copyWith(fontSize: 13),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: TransactionStyles.getStatusBadgeDecoration(txn["status"]),
                    child: Text(
                      txn["status"],
                      style: TransactionStyles.getStatusBadgeStyle(txn["status"]).copyWith(fontSize: 11),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                txn["customer"],
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: TransactionStyles.textPrimaryColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                txn["account"],
                style: TransactionStyles.accountNoStyle.copyWith(fontSize: 11),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Amount',
                        style: TransactionStyles.tableCellStyle.copyWith(fontSize: 11),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        formatCurrency(txn["amount"].toDouble()),
                        style: TransactionStyles.amountStyle.copyWith(fontSize: 15),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: TransactionStyles.getTypeBadgeDecoration(txn["type"]),
                        child: Text(
                          txn["type"],
                          style: TransactionStyles.getTypeBadgeStyle(txn["type"]).copyWith(fontSize: 11),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        txn["date"],
                        style: TransactionStyles.tableCellStyle.copyWith(fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
              if (activeTab == "failed" && txn["reason"] != null) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: TransactionStyles.reasonDecoration,
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, size: 14, color: Color(0xFF991B1B)),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          txn["reason"],
                          style: TransactionStyles.reasonTextStyle.copyWith(fontSize: 11),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String key, String label) {
    final isActive = activeTab == key;
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            activeTab = key;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: isActive
              ? TransactionStyles.activeTabDecoration
              : TransactionStyles.inactiveTabDecoration,
          child: Text(
            label,
            style: isActive
                ? TransactionStyles.activeTabTextStyle.copyWith(fontSize: 12)
                : TransactionStyles.inactiveTabTextStyle.copyWith(fontSize: 12),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Widget _buildExportButton(String label, IconData icon) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 14),
      label: Text(label, style: const TextStyle(fontSize: 12)),
      style: TransactionStyles.exportButtonStyle,
    );
  }

  Widget _buildExportFormatButton(String label) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.download, size: 14),
      label: Text(label, style: const TextStyle(fontSize: 12)),
      style: TransactionStyles.exportFormatButtonStyle,
    );
  }

  String _getTableTitle() {
    switch (activeTab) {
      case "all":
        return "All Transactions";
      case "pending":
        return "Pending Transfers";
      case "failed":
        return "Failed / Rejected";
      case "reconciliation":
        return "Reconciliation";
      default:
        return "All Transactions";
    }
  }

  Widget _buildModal() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: TransactionStyles.modalDecoration,
      child: Column(
        children: [
          // Modal Header
          Container(
            padding: EdgeInsets.all(isMobile ? 12 : 24),
            decoration: TransactionStyles.modalHeaderDecoration,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Transaction Details',
                  style: TransactionStyles.modalTitleStyle.copyWith(
                    fontSize: isMobile ? 16 : 20,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      selectedTxn = null;
                    });
                  },
                  icon: const Icon(Icons.close, size: 20),
                ),
              ],
            ),
          ),

          // Modal Body
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(isMobile ? 12 : 24),
              child: Column(
                children: [
                  // Detail Grid
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: isMobile ? 1 : 2,
                    childAspectRatio: isMobile ? 5 : 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: [
                      _buildDetailItem('Transaction ID', selectedTxn!["id"]),
                      _buildDetailItem('Reference No', selectedTxn!["reference"]),
                      _buildDetailItem('Date & Time', selectedTxn!["date"]),
                      _buildDetailItem('Account Number', selectedTxn!["account"]),
                      _buildDetailItem('Customer Name', selectedTxn!["customer"]),
                      _buildDetailItem('Transaction Type', selectedTxn!["type"], isType: true),
                      _buildDetailItem(
                        'Amount',
                        formatCurrency(selectedTxn!["amount"].toDouble()),
                        isAmount: true,
                      ),
                      _buildDetailItem('Status', selectedTxn!["status"], isStatus: true),
                      _buildDetailItem('Channel', selectedTxn!["channel"]),
                    ],
                  ),
                  if (selectedTxn!["reason"] != null) ...[
                    const SizedBox(height: 12),
                    _buildDetailItemFullWidth('Failure Reason', selectedTxn!["reason"], isReason: true),
                  ],
                  const SizedBox(height: 24),

                  // Modal Actions
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildActionButton('Reverse', Colors.red[700]!),
                      _buildActionButton('Refund', Colors.purple[700]!),
                      _buildActionButton('Resolved', Colors.green[700]!),
                      _buildActionButton('Add Note', Colors.orange[700]!),
                      _buildActionButton('Close', Colors.grey[700]!, onPressed: () {
                        setState(() {
                          selectedTxn = null;
                        });
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value,
      {bool isType = false, bool isStatus = false, bool isAmount = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label, style: TransactionStyles.detailLabelStyle.copyWith(fontSize: 11)),
        const SizedBox(height: 4),
        if (isType)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: TransactionStyles.getTypeBadgeDecoration(value),
            child: Text(
              value,
              style: TransactionStyles.getTypeBadgeStyle(value).copyWith(fontSize: 11),
            ),
          )
        else if (isStatus)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: TransactionStyles.getStatusBadgeDecoration(value),
            child: Text(
              value,
              style: TransactionStyles.getStatusBadgeStyle(value).copyWith(fontSize: 11),
            ),
          )
        else if (isAmount)
          Text(value, style: TransactionStyles.detailAmountStyle.copyWith(fontSize: 14))
        else
          Text(value, style: TransactionStyles.detailValueStyle.copyWith(fontSize: 12)),
      ],
    );
  }

  Widget _buildDetailItemFullWidth(String label, String value, {bool isReason = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TransactionStyles.detailLabelStyle.copyWith(fontSize: 11)),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: isReason ? TransactionStyles.reasonDecoration : null,
          child: Text(
            value,
            style: isReason 
                ? TransactionStyles.reasonTextStyle.copyWith(fontSize: 11)
                : TransactionStyles.detailValueStyle.copyWith(fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(String label, Color color, {VoidCallback? onPressed}) {
    return ElevatedButton(
      onPressed: onPressed ?? () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }
}
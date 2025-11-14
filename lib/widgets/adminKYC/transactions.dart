import 'package:flutter/material.dart';

class KYCColors {
  static const Color primary = Color(0xFF900603);
  static const Color background = Color(0xFFF8F8F8);
  static const Color success = Color(0xFF28A745);
  static const Color danger = Color(0xFFDC3545);
  static const Color pending = Color(0xFFFFC107);

  static Color? get textSecondary => null;
}

class KYCStyles {
  static BoxShadow cardShadow = BoxShadow(
    color: Colors.black.withValues(alpha: 0.05),
    blurRadius: 10,
    offset: const Offset(0, 2),
  );
}

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  List<Map<String, dynamic>> transactions = [
    {
      'id': 'T001',
      'user': 'Ram Kumar',
      'type': 'Deposit',
      'amount': 15000,
      'status': 'Completed',
      'date': '2025-09-18',
      'auditLogs': [
        {'id': 1, 'action': 'Created', 'user': 'System', 'date': '2025-09-18 09:30', 'remark': 'Deposit request'},
        {'id': 2, 'action': 'Completed', 'user': 'Admin1', 'date': '2025-09-18 09:45', 'remark': 'Funds credited'},
      ],
      'notes': ['Verified transaction'],
    },
    {
      'id': 'T002',
      'user': 'Sita Sharma',
      'type': 'Withdrawal',
      'amount': 5000,
      'status': 'Pending',
      'date': '2025-09-17',
      'auditLogs': [
        {'id': 1, 'action': 'Created', 'user': 'System', 'date': '2025-09-17 14:10', 'remark': 'Withdrawal request'},
      ],
      'notes': ['Need approval'],
    },
    {
      'id': 'T003',
      'user': 'Amit Verma',
      'type': 'Transfer',
      'amount': 25000,
      'status': 'Flagged',
      'date': '2025-09-16',
      'auditLogs': [
        {'id': 1, 'action': 'Created', 'user': 'System', 'date': '2025-09-16 10:00', 'remark': 'Transfer request'},
        {'id': 2, 'action': 'Flagged', 'user': 'Admin2', 'date': '2025-09-16 10:30', 'remark': 'High amount flagged'},
      ],
      'notes': ['Under compliance review'],
    },
  ];

  String search = '';
  String filter = 'All';
  String sort = 'latest';
  int page = 1;
  List<String> selected = [];
  Map<String, dynamic>? viewingTxn;
  String activeTab = 'info';
  final int itemsPerPage = 5;

  final TextEditingController _noteController = TextEditingController();

  List<Map<String, dynamic>> get filtered {
    var result = transactions.where((t) {
      final matchesSearch = t['user'].toString().toLowerCase().contains(search.toLowerCase()) ||
          t['id'].toString().toLowerCase().contains(search.toLowerCase()) ||
          t['type'].toString().toLowerCase().contains(search.toLowerCase());
      final matchesFilter = filter == 'All' || t['status'] == filter;
      return matchesSearch && matchesFilter;
    }).toList();

    result.sort((a, b) {
      final dateA = DateTime.parse(a['date']);
      final dateB = DateTime.parse(b['date']);
      return sort == 'latest' ? dateB.compareTo(dateA) : dateA.compareTo(dateB);
    });

    return result;
  }

  int get totalPages => (filtered.length / itemsPerPage).ceil();

  List<Map<String, dynamic>> get paginated {
    final start = (page - 1) * itemsPerPage;
    final end = start + itemsPerPage;
    return filtered.sublist(
      start,
      end > filtered.length ? filtered.length : end,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KYCColors.background,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildCardHeader(),
                  const SizedBox(height: 16),
                  _buildControls(),
                  const SizedBox(height: 16),
                  _buildTable(),
                  const SizedBox(height: 16),
                  _buildPagination(),
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
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      decoration: const BoxDecoration(color: KYCColors.primary),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Neo Bank - All Transactions',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Track and manage all user transactions in one place.',
                    style: TextStyle(fontSize: 15, color: Color(0xFFF0F0F0)),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward, color: Colors.white),
              onPressed: () => Navigator.pop(context),
              tooltip: 'Back to KYC Dashboard',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardHeader() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: const [
            Icon(Icons.swap_horiz, size: 28, color: KYCColors.primary),
            SizedBox(width: 12),
            Text(
              'All Transactions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControls() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 768) {
          return Row(
            children: [
              Expanded(child: _buildSearchField()),
              const SizedBox(width: 8),
              Expanded(child: _buildFilterDropdown()),
              const SizedBox(width: 8),
              Expanded(child: _buildSortDropdown()),
              const SizedBox(width: 8),
              _buildBulkButtons(),
            ],
          );
        } else {
          return Column(
            children: [
              _buildSearchField(),
              const SizedBox(height: 8),
              _buildFilterDropdown(),
              const SizedBox(height: 8),
              _buildSortDropdown(),
              const SizedBox(height: 8),
              _buildBulkButtons(),
            ],
          );
        }
      },
    );
  }

  Widget _buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search by ID / User / Type',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      onChanged: (value) {
        setState(() {
          search = value;
          page = 1;
        });
      },
    );
  }

  Widget _buildFilterDropdown() {
    return DropdownButtonFormField<String>(
      initialValue: filter,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      items: ['All', 'Pending', 'Completed', 'Flagged']
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: (value) {
        setState(() {
          filter = value!;
          page = 1;
        });
      },
    );
  }

  Widget _buildSortDropdown() {
    return DropdownButtonFormField<String>(
      initialValue: sort,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      items: [
        const DropdownMenuItem(value: 'latest', child: Text('Latest First')),
        const DropdownMenuItem(value: 'oldest', child: Text('Oldest First')),
      ],
      onChanged: (value) => setState(() => sort = value!),
    );
  }

  Widget _buildBulkButtons() {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () => _bulkAction('Completed'),
          style: ElevatedButton.styleFrom(
            backgroundColor: KYCColors.success,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          child: const Text('Bulk Completed'),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () => _bulkAction('Flagged'),
          style: ElevatedButton.styleFrom(
            backgroundColor: KYCColors.danger,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          child: const Text('Bulk Flagged'),
        ),
      ],
    );
  }

  Widget _buildTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [KYCStyles.cardShadow],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(KYCColors.primary),
          columns: [
            DataColumn(
              label: Checkbox(
                value: selected.length == paginated.length && paginated.isNotEmpty,
                onChanged: (_) => _toggleAll(),
                fillColor: WidgetStateProperty.all(Colors.white),
                checkColor: KYCColors.primary,
              ),
            ),
            const DataColumn(label: Text('Txn ID', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
            const DataColumn(label: Text('User', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
            const DataColumn(label: Text('Type', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
            const DataColumn(label: Text('Amount', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
            const DataColumn(label: Text('Status', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
            const DataColumn(label: Text('Date', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
            const DataColumn(label: Text('Action', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
          ],
          rows: paginated.map((t) {
            return DataRow(cells: [
              DataCell(Checkbox(
                value: selected.contains(t['id']),
                onChanged: (_) => _toggleOne(t['id']),
              )),
              DataCell(Text(t['id'])),
              DataCell(Text(t['user'])),
              DataCell(Text(t['type'])),
              DataCell(Text('₹ ${(t['amount'] as int).toStringAsFixed(0)}')),
              DataCell(Text(
                t['status'],
                style: TextStyle(
                  color: _getStatusColor(t['status']),
                  fontWeight: FontWeight.w600,
                ),
              )),
              DataCell(Text(t['date'])),
              DataCell(
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      viewingTxn = t;
                      activeTab = 'info';
                    });
                    _showModal();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: KYCColors.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  ),
                  child: const Text('View'),
                ),
              ),
            ]);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildPagination() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Page $page of $totalPages'),
        Row(
          children: [
            ElevatedButton(
              onPressed: page == 1 ? null : () => setState(() => page--),
              child: const Text('Prev'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: page == totalPages ? null : () => setState(() => page++),
              child: const Text('Next'),
            ),
          ],
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return KYCColors.success;
      case 'Pending':
        return KYCColors.pending;
      case 'Flagged':
        return KYCColors.danger;
      default:
        return Colors.black;
    }
  }

  void _toggleOne(String id) {
    setState(() {
      if (selected.contains(id)) {
        selected.remove(id);
      } else {
        selected.add(id);
      }
    });
  }

  void _toggleAll() {
    setState(() {
      if (selected.length == paginated.length) {
        selected.clear();
      } else {
        selected = paginated.map((t) => t['id'] as String).toList();
      }
    });
  }

  void _bulkAction(String action) {
    if (selected.isEmpty) return;
    setState(() {
      transactions = transactions.map((t) {
        if (selected.contains(t['id'])) {
          t['status'] = action;
          (t['auditLogs'] as List).add({
            'id': (t['auditLogs'] as List).length + 1,
            'action': action,
            'user': 'Admin',
            'date': DateTime.now().toString(),
            'remark': '$action via bulk',
          });
        }
        return t;
      }).toList();
      selected.clear();
    });
  }

  void _addNote(String id, String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      final txnIndex = transactions.indexWhere((t) => t['id'] == id);
      if (txnIndex != -1) {
        (transactions[txnIndex]['notes'] as List).add(text);
        (transactions[txnIndex]['auditLogs'] as List).add({
          'id': (transactions[txnIndex]['auditLogs'] as List).length + 1,
          'action': 'Note Added',
          'user': 'Admin',
          'date': DateTime.now().toString(),
          'remark': text,
        });
      }
    });
    _noteController.clear();
  }

  void _showModal() {
    if (viewingTxn == null) return;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          constraints: const BoxConstraints(maxWidth: 1000, maxHeight: 700),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: KYCColors.primary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Transaction ${viewingTxn!['id']}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        setState(() => viewingTxn = null);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildModalTabs(),
                      const SizedBox(height: 16),
                      Expanded(child: _buildModalContent()),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() => viewingTxn = null);
                      Navigator.pop(context);
                    },
                    child: const Text('Close'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModalTabs() {
    return Row(
      children: ['info', 'audit', 'notes'].map((tab) {
        final label = tab == 'info' ? 'Info' : tab == 'audit' ? 'Audit Trail' : 'Notes';
        return Expanded(
          child: InkWell(
            onTap: () => setState(() => activeTab = tab),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: activeTab == tab ? KYCColors.primary : const Color(0xFFEEECEC),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                ),
              ),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: activeTab == tab ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildModalContent() {
    switch (activeTab) {
      case 'info':
        return _buildInfoTab();
      case 'audit':
        return _buildAuditTab();
      case 'notes':
        return _buildNotesTab();
      default:
        return Container();
    }
  }

  Widget _buildInfoTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow('User:', viewingTxn!['user']),
          _buildInfoRow('Type:', viewingTxn!['type']),
          _buildInfoRow('Amount:', '₹ ${(viewingTxn!['amount'] as int).toStringAsFixed(0)}'),
          _buildInfoRow('Status:', viewingTxn!['status']),
          _buildInfoRow('Date:', viewingTxn!['date']),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _noteController,
                  decoration: InputDecoration(
                    hintText: 'Add note...',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  _addNote(viewingTxn!['id'], _noteController.text);
                  Navigator.pop(context);
                  _showModal();
                },
                style: ElevatedButton.styleFrom(backgroundColor: KYCColors.primary),
                child: const Text('Add Note'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildAuditTab() {
    final logs = viewingTxn!['auditLogs'] as List;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Date', style: TextStyle(fontWeight: FontWeight.w600))),
          DataColumn(label: Text('Action', style: TextStyle(fontWeight: FontWeight.w600))),
          DataColumn(label: Text('User', style: TextStyle(fontWeight: FontWeight.w600))),
          DataColumn(label: Text('Remark', style: TextStyle(fontWeight: FontWeight.w600))),
        ],
        rows: logs.map((log) {
          return DataRow(cells: [
            DataCell(Text(log['date'])),
            DataCell(Text(log['action'])),
            DataCell(Text(log['user'])),
            DataCell(Text(log['remark'])),
          ]);
        }).toList(),
      ),
    );
  }

  Widget _buildNotesTab() {
    final notes = viewingTxn!['notes'] as List;
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text('• ${notes[index]}'),
      ),
    );
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }
}

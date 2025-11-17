import 'package:flutter/material.dart';

class KYCColors {
  static const Color primary = Color(0xFF900603);
  static const Color background = Color(0xFFF8F8F8);
  static const Color success = Color(0xFF28A745);
  static const Color danger = Color(0xFFDC3545);
  static const Color warning = Color(0xFFFFC107);
  static const Color pending = Color(0xFFFFC107);
  static const Color escalated = Color(0xFFFF5722);
}

class KYCStyles {
  static BoxShadow cardShadow = BoxShadow(
    color: Colors.black.withValues(alpha: 0.05),
    blurRadius: 10,
    offset: const Offset(0, 2),
  );
}

class ViewAlerts extends StatefulWidget {
  const ViewAlerts({super.key});

  @override
  State<ViewAlerts> createState() => _ViewAlertsState();
}

class _ViewAlertsState extends State<ViewAlerts> {
  List<Map<String, dynamic>> alerts = [
    {
      'alertId': 'A001',
      'name': 'Ram Kumar',
      'type': 'Suspicious Transaction',
      'status': 'Pending',
      'date': '2025-09-18',
      'note': 'Transaction above threshold',
      'auditLogs': [
        {'id': 1, 'action': 'Created', 'user': 'Admin1', 'date': '2025-09-18 10:00', 'remark': 'Initial alert'},
      ],
      'notes': ['Check transaction details'],
    },
    {
      'alertId': 'A002',
      'name': 'Sita Sharma',
      'type': 'Customer Complaint',
      'status': 'Resolved',
      'date': '2025-09-17',
      'note': 'Refund issued',
      'auditLogs': [
        {'id': 1, 'action': 'Resolved', 'user': 'Admin2', 'date': '2025-09-17 12:00', 'remark': 'Refund processed'},
      ],
      'notes': ['Customer notified'],
    },
    {
      'alertId': 'A003',
      'name': 'Amit Verma',
      'type': 'Suspicious Transaction',
      'status': 'Escalated',
      'date': '2025-09-16',
      'note': 'Large transfer flagged',
      'auditLogs': [
        {'id': 1, 'action': 'Escalated', 'user': 'Admin1', 'date': '2025-09-16 14:00', 'remark': 'High-risk transaction'},
      ],
      'notes': ['Sent to compliance team'],
    },
  ];

  String search = '';
  String filter = 'All';
  String sort = 'latest';
  int page = 1;
  List<String> selectedAlerts = [];
  Map<String, dynamic>? viewingAlert;
  String activeTab = 'info';
  final int itemsPerPage = 5;

  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _escalateController = TextEditingController();

  List<Map<String, dynamic>> get filteredAlerts {
    var filtered = alerts.where((a) {
      final matchesSearch = a['name'].toString().toLowerCase().contains(search.toLowerCase()) ||
          a['alertId'].toString().toLowerCase().contains(search.toLowerCase()) ||
          a['type'].toString().toLowerCase().contains(search.toLowerCase());
      final matchesFilter = filter == 'All' || a['status'] == filter;
      return matchesSearch && matchesFilter;
    }).toList();

    filtered.sort((a, b) {
      final dateA = DateTime.parse(a['date']);
      final dateB = DateTime.parse(b['date']);
      return sort == 'latest' ? dateB.compareTo(dateA) : dateA.compareTo(dateB);
    });

    return filtered;
  }

  int get totalPages => (filteredAlerts.length / itemsPerPage).ceil();

  List<Map<String, dynamic>> get paginatedAlerts {
    final start = (page - 1) * itemsPerPage;
    final end = start + itemsPerPage;
    return filteredAlerts.sublist(
      start,
      end > filteredAlerts.length ? filteredAlerts.length : end,
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
                    'Neo Bank AML & Complaints',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'View and manage all AML reports and customer complaints here.',
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
            Icon(Icons.notifications, size: 28, color: KYCColors.primary),
            SizedBox(width: 12),
            Text(
              'AML / Complaints Alerts',
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
        hintText: 'Search by ID / Name / Type',
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
      items: ['All', 'Pending', 'Resolved', 'Escalated']
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

  // 🔥 CHANGED TEXT COLOR TO WHITE (requested)
  Widget _buildBulkButtons() {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () => _bulkAction('Resolved'),
          style: ElevatedButton.styleFrom(
            backgroundColor: KYCColors.success,
            foregroundColor: Colors.white,   // <-- CHANGED HERE
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          child: const Text('Bulk Resolve'),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () => _bulkAction('Escalated'),
          style: ElevatedButton.styleFrom(
            backgroundColor: KYCColors.danger,
            foregroundColor: Colors.white,   // <-- CHANGED HERE
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          child: const Text('Bulk Escalate'),
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
                value: selectedAlerts.length == paginatedAlerts.length && paginatedAlerts.isNotEmpty,
                onChanged: (_) => _toggleAll(),
                fillColor: WidgetStateProperty.all(Colors.white),
                checkColor: KYCColors.primary,
              ),
            ),
            const DataColumn(label: Text('Alert ID', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
            const DataColumn(label: Text('Name', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
            const DataColumn(label: Text('Type', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
            const DataColumn(label: Text('Status', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
            const DataColumn(label: Text('Date', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
            const DataColumn(label: Text('Note', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
            const DataColumn(label: Text('Action', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
          ],
          rows: paginatedAlerts.map((a) {
            return DataRow(cells: [
              DataCell(Checkbox(
                value: selectedAlerts.contains(a['alertId']),
                onChanged: (_) => _toggleAlert(a['alertId']),
              )),
              DataCell(Text(a['alertId'])),
              DataCell(Text(a['name'])),
              DataCell(Text(a['type'])),
              DataCell(Text(
                a['status'],
                style: TextStyle(
                  color: _getStatusColor(a['status']),
                  fontWeight: FontWeight.w600,
                ),
              )),
              DataCell(Text(a['date'])),
              DataCell(Text(a['note'])),
              
              // 🔥 CHANGED TEXT COLOR TO WHITE (requested)
              DataCell(
                ElevatedButton(
                  onPressed: () => _openModal(a),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: KYCColors.primary,
                    foregroundColor: Colors.white, // <-- CHANGED HERE
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: KYCColors.primary,
                side: const BorderSide(color: KYCColors.primary),
              ),
              child: const Text('Prev'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: page == totalPages ? null : () => setState(() => page++),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: KYCColors.primary,
                side: const BorderSide(color: KYCColors.primary),
              ),
              child: const Text('Next'),
            ),
          ],
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return KYCColors.pending;
      case 'Resolved':
        return KYCColors.success;
      case 'Escalated':
        return KYCColors.escalated;
      default:
        return Colors.black;
    }
  }

  void _toggleAlert(String alertId) {
    setState(() {
      if (selectedAlerts.contains(alertId)) {
        selectedAlerts.remove(alertId);
      } else {
        selectedAlerts.add(alertId);
      }
    });
  }

  void _toggleAll() {
    setState(() {
      if (selectedAlerts.length == paginatedAlerts.length) {
        selectedAlerts.clear();
      } else {
        selectedAlerts = paginatedAlerts.map((a) => a['alertId'] as String).toList();
      }
    });
  }

  void _bulkAction(String action) {
    if (selectedAlerts.isEmpty) return;
    setState(() {
      alerts = alerts.map((a) {
        if (selectedAlerts.contains(a['alertId'])) {
          a['status'] = action;
          (a['auditLogs'] as List).add({
            'id': (a['auditLogs'] as List).length + 1,
            'action': action,
            'user': 'Admin',
            'date': DateTime.now().toString(),
            'remark': '$action via bulk',
          });
        }
        return a;
      }).toList();
      selectedAlerts.clear();
    });
  }

  void _openModal(Map<String, dynamic> alert) {
    setState(() {
      viewingAlert = alert;
      activeTab = 'info';
      _noteController.clear();
      _escalateController.clear();
    });

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
                      viewingAlert!['name'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        setState(() => viewingAlert = null);
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
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() => viewingAlert = null);
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: KYCColors.primary,
                      side: const BorderSide(color: KYCColors.primary),
                    ),
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
        final label = tab == 'info' ? 'Info' : tab == 'audit' ? 'Audit Logs' : 'Notes';
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
          _buildInfoRow('Alert ID:', viewingAlert!['alertId']),
          _buildInfoRow('Type:', viewingAlert!['type']),
          _buildInfoRow('Status:', viewingAlert!['status']),
          _buildInfoRow('Note:', viewingAlert!['note']),
          _buildInfoRow('Date:', viewingAlert!['date']),
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

              // 🔥 CHANGED TEXT COLOR TO WHITE (requested)
              ElevatedButton(
                onPressed: () => _addNote(viewingAlert!['alertId'], _noteController.text),
                style: ElevatedButton.styleFrom(
                  backgroundColor: KYCColors.primary,
                  foregroundColor: Colors.white,  // <-- CHANGED HERE
                ),
                child: const Text('Add Note'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _escalateController,
                  decoration: InputDecoration(
                    hintText: 'Escalate reason...',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // 🔥 CHANGED TEXT COLOR TO WHITE (requested)
              ElevatedButton(
                onPressed: () => _escalateAlert(viewingAlert!['alertId'], _escalateController.text),
                style: ElevatedButton.styleFrom(
                  backgroundColor: KYCColors.danger,
                  foregroundColor: Colors.white,  // <-- CHANGED HERE
                ),
                child: const Text('Escalate'),
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
    final logs = viewingAlert!['auditLogs'] as List;
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
    final notes = viewingAlert!['notes'] as List;
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text('• ${notes[index]}'),
      ),
    );
  }

  void _addNote(String alertId, String noteText) {
    if (noteText.trim().isEmpty) return;
    setState(() {
      final alertIndex = alerts.indexWhere((a) => a['alertId'] == alertId);
      if (alertIndex != -1) {
        (alerts[alertIndex]['notes'] as List).add(noteText);
        (alerts[alertIndex]['auditLogs'] as List).add({
          'id': (alerts[alertIndex]['auditLogs'] as List).length + 1,
          'action': 'Note Added',
          'user': 'Admin',
          'date': DateTime.now().toString(),
          'remark': noteText,
        });
      }
    });
    _noteController.clear();
  }

  void _escalateAlert(String alertId, String reason) {
    if (reason.trim().isEmpty) return;
    setState(() {
      final alertIndex = alerts.indexWhere((a) => a['alertId'] == alertId);
      if (alertIndex != -1) {
        alerts[alertIndex]['status'] = 'Escalated';
        alerts[alertIndex]['note'] = reason;
        (alerts[alertIndex]['auditLogs'] as List).add({
          'id': (alerts[alertIndex]['auditLogs'] as List).length + 1,
          'action': 'Escalated',
          'user': 'Admin',
          'date': DateTime.now().toString(),
          'remark': reason,
        });
      }
    });
    _escalateController.clear();
  }

  @override
  void dispose() {
    _noteController.dispose();
    _escalateController.dispose();
    super.dispose();
  }
}

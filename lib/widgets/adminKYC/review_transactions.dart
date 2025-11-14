import 'package:flutter/material.dart';
import '../../styles/kyc_styles.dart';
// import 'kyc_routes.dart';

class ReviewTransactions extends StatefulWidget {
  const ReviewTransactions({super.key});

  @override
  State<ReviewTransactions> createState() => _ReviewTransactionsState();
}

class _ReviewTransactionsState extends State<ReviewTransactions> {
  List<Map<String, dynamic>> cases = [
    {
      'caseId': 'C001',
      'name': 'Ram Kumar',
      'status': 'Pending',
      'date': '2025-09-18',
      'note': 'Initial KYC',
      'docs': [
        {'type': 'Aadhar', 'url': 'https://via.placeholder.com/150'},
        {'type': 'PAN', 'url': 'https://via.placeholder.com/150'},
      ],
      'auditLogs': [
        {
          'id': 1,
          'action': 'Created',
          'user': 'Admin1',
          'date': '2025-09-18 10:00',
          'remark': 'KYC started',
        },
      ],
      'notes': ['Initial check pending'],
    },
    {
      'caseId': 'C002',
      'name': 'Sita Sharma',
      'status': 'Approved',
      'date': '2025-09-17',
      'note': 'Verified',
      'docs': [
        {'type': 'Passport', 'url': 'https://via.placeholder.com/150'},
      ],
      'auditLogs': [
        {
          'id': 1,
          'action': 'Approved',
          'user': 'Admin2',
          'date': '2025-09-17 12:00',
          'remark': 'Verified',
        },
      ],
      'notes': ['Documents verified'],
    },
    {
      'caseId': 'C003',
      'name': 'Amit Verma',
      'status': 'Rejected',
      'date': '2025-09-16',
      'note': 'Invalid Docs',
      'docs': [],
      'auditLogs': [
        {
          'id': 1,
          'action': 'Rejected',
          'user': 'Admin1',
          'date': '2025-09-16 14:00',
          'remark': 'Invalid documents',
        },
      ],
      'notes': ['Documents not valid'],
    },
  ];

  String search = '';
  String filter = 'All';
  String sort = 'latest';
  int page = 1;
  List<String> selectedCases = [];
  Map<String, dynamic>? viewingCase;
  String activeTab = 'Documents';
  final int itemsPerPage = 5;

  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _escalateController = TextEditingController();

  List<Map<String, dynamic>> get filteredCases {
    var filtered = cases.where((c) {
      final matchesSearch =
          c['name'].toString().toLowerCase().contains(search.toLowerCase()) ||
          c['caseId'].toString().toLowerCase().contains(search.toLowerCase());
      final matchesFilter = filter == 'All' || c['status'] == filter;
      return matchesSearch && matchesFilter;
    }).toList();

    filtered.sort((a, b) {
      final dateA = DateTime.parse(a['date']);
      final dateB = DateTime.parse(b['date']);
      return sort == 'latest' ? dateB.compareTo(dateA) : dateA.compareTo(dateB);
    });

    return filtered;
  }

  int get totalPages => (filteredCases.length / itemsPerPage).ceil();

  List<Map<String, dynamic>> get paginatedCases {
    final start = (page - 1) * itemsPerPage;
    final end = start + itemsPerPage;
    return filteredCases.sublist(
      start,
      end > filteredCases.length ? filteredCases.length : end,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'KYC History',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: KYCColors.primary,
                    ),
                  ),
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
                    'Neo Bank - KYC History',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'All verified and pending KYC records are listed here',
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
        hintText: 'Search Case ID or Name',
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
      items: [
        'All',
        'Pending',
        'Approved',
        'Rejected',
        'Escalated',
      ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
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
          onPressed: () => _bulkAction('Approved'),
          style: ElevatedButton.styleFrom(
            backgroundColor: KYCColors.success,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          child: const Text('Bulk Approve'),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () => _bulkAction('Rejected'),
          style: ElevatedButton.styleFrom(
            backgroundColor: KYCColors.danger,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          child: const Text('Bulk Reject'),
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
                value:
                    selectedCases.length == paginatedCases.length &&
                    paginatedCases.isNotEmpty,
                onChanged: (_) => _toggleAll(),
                fillColor: WidgetStateProperty.all(Colors.white),
                checkColor: KYCColors.primary,
              ),
            ),
            const DataColumn(
              label: Text(
                'Case ID',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const DataColumn(
              label: Text(
                'Name',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const DataColumn(
              label: Text(
                'Status',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const DataColumn(
              label: Text(
                'Date',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const DataColumn(
              label: Text(
                'Note',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const DataColumn(
              label: Text(
                'Action',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
          rows: paginatedCases.map((c) {
            return DataRow(
              cells: [
                DataCell(
                  Checkbox(
                    value: selectedCases.contains(c['caseId']),
                    onChanged: (_) => _toggleCase(c['caseId']),
                  ),
                ),
                DataCell(Text(c['caseId'])),
                DataCell(Text(c['name'])),
                DataCell(
                  Text(
                    c['status'],
                    style: TextStyle(
                      color: _getStatusColor(c['status']),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                DataCell(Text(c['date'])),
                DataCell(Text(c['note'])),
                DataCell(
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        viewingCase = c;
                        activeTab = 'Documents';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: KYCColors.primary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                    ),
                    child: const Text('View'),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildPagination() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: page == 1 ? null : () => setState(() => page--),
          child: const Text('Prev'),
        ),
        Text('Page $page of $totalPages'),
        ElevatedButton(
          onPressed: page == totalPages ? null : () => setState(() => page++),
          child: const Text('Next'),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return KYCColors.pending;
      case 'approved':
        return KYCColors.approved;
      case 'rejected':
        return KYCColors.rejected;
      case 'escalated':
        return KYCColors.escalated;
      default:
        return Colors.black;
    }
  }

  void _toggleCase(String caseId) {
    setState(() {
      if (selectedCases.contains(caseId)) {
        selectedCases.remove(caseId);
      } else {
        selectedCases.add(caseId);
      }
    });
  }

  void _toggleAll() {
    setState(() {
      if (selectedCases.length == paginatedCases.length) {
        selectedCases.clear();
      } else {
        selectedCases = paginatedCases
            .map((c) => c['caseId'] as String)
            .toList();
      }
    });
  }

  void _bulkAction(String action) {
    if (selectedCases.isEmpty) return;
    setState(() {
      cases = cases.map((c) {
        if (selectedCases.contains(c['caseId'])) {
          c['status'] = action;
          (c['auditLogs'] as List).add({
            'id': (c['auditLogs'] as List).length + 1,
            'action': action,
            'user': 'Admin',
            'date': DateTime.now().toString(),
            'remark': '$action via bulk',
          });
        }
        return c;
      }).toList();
      selectedCases.clear();
    });
  }

  void _addNote(String caseId, String noteText) {
    if (noteText.trim().isEmpty) return;
    setState(() {
      final caseIndex = cases.indexWhere((c) => c['caseId'] == caseId);
      if (caseIndex != -1) {
        (cases[caseIndex]['notes'] as List).add(noteText);
        (cases[caseIndex]['auditLogs'] as List).add({
          'id': (cases[caseIndex]['auditLogs'] as List).length + 1,
          'action': 'Note Added',
          'user': 'Admin',
          'date': DateTime.now().toString(),
          'remark': noteText,
        });
      }
    });
    _noteController.clear();
  }

  void _escalateCase(String caseId, String reason) {
    if (reason.trim().isEmpty) return;
    setState(() {
      final caseIndex = cases.indexWhere((c) => c['caseId'] == caseId);
      if (caseIndex != -1) {
        cases[caseIndex]['status'] = 'Escalated';
        cases[caseIndex]['note'] = reason;
        (cases[caseIndex]['auditLogs'] as List).add({
          'id': (cases[caseIndex]['auditLogs'] as List).length + 1,
          'action': 'Escalated',
          'user': 'Admin',
          'date': DateTime.now().toString(),
          'remark': reason,
        });
      }
    });
    _escalateController.clear();
  }

  void _showModal() {
    if (viewingCase == null) return;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          constraints: const BoxConstraints(maxWidth: 900, maxHeight: 700),
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
                      '${viewingCase!['caseId']} - ${viewingCase!['name']}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        setState(() => viewingCase = null);
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
                      _buildTabButtons(),
                      const SizedBox(height: 16),
                      Expanded(child: _buildTabContent()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabButtons() {
    return Row(
      children: ['Documents', 'Notes', 'Audit Trail', 'Escalate'].map((tab) {
        return Expanded(
          child: InkWell(
            onTap: () => setState(() => activeTab = tab),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: activeTab == tab
                    ? KYCColors.primary
                    : const Color(0xFFEEECEC),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                ),
              ),
              child: Text(
                tab,
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

  Widget _buildTabContent() {
    switch (activeTab) {
      case 'Documents':
        return _buildDocumentsTab();
      case 'Notes':
        return _buildNotesTab();
      case 'Audit Trail':
        return _buildAuditTab();
      case 'Escalate':
        return _buildEscalateTab();
      default:
        return Container();
    }
  }

  Widget _buildDocumentsTab() {
    final docs = viewingCase!['docs'] as List;
    if (docs.isEmpty) {
      return const Center(child: Text('No documents uploaded'));
    }
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: docs.length,
      itemBuilder: (context, index) {
        final doc = docs[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Expanded(
                  child: Image.network(
                    doc['url'],
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) =>
                        const Icon(Icons.image, size: 64),
                  ),
                ),
                Text(
                  doc['type'],
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Download functionality
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: KYCColors.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                  ),
                  child: const Text('Download', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNotesTab() {
    final notes = viewingCase!['notes'] as List;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text('• ${notes[index]}'),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _noteController,
                decoration: InputDecoration(
                  hintText: 'Add a note...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                _addNote(viewingCase!['caseId'], _noteController.text);
                Navigator.pop(context);
                _showModal();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: KYCColors.primary,
              ),
              child: const Text('Add Note'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAuditTab() {
    final logs = viewingCase!['auditLogs'] as List;
    return ListView.builder(
      itemCount: logs.length,
      itemBuilder: (context, index) {
        final log = logs[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            '${log['date']} - ${log['user']} - ${log['action']} - ${log['remark']}',
            style: const TextStyle(fontSize: 13),
          ),
        );
      },
    );
  }

  Widget _buildEscalateTab() {
    return Column(
      children: [
        TextField(
          controller: _escalateController,
          decoration: InputDecoration(
            hintText: 'Reason for escalation',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            _escalateCase(viewingCase!['caseId'], _escalateController.text);
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(backgroundColor: KYCColors.primary),
          child: const Text('Escalate Case'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _noteController.dispose();
    _escalateController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import '../../styles/kyc_styles.dart';
// import 'kyc_routes.dart';

class ReviewKYC extends StatefulWidget {
  const ReviewKYC({Key? key}) : super(key: key);

  @override
  State<ReviewKYC> createState() => _ReviewKYCState();
}

class _ReviewKYCState extends State<ReviewKYC> {
  final TextEditingController _searchController = TextEditingController();
  String _searchTerm = '';
  // ignore: unused_field
  Map<String, dynamic>? _selectedDoc;
  Map<String, dynamic> _alert = {};
  Map<int, String> _recentAction = {};

  List<Map<String, dynamic>> users = [
    {
      'id': 1,
      'name': 'Priya Sharma',
      'email': 'priya.sharma@example.com',
      'kycId': 'KYC-001-20240715',
      'documents': [
        {'type': 'Aadhaar', 'img': 'https://via.placeholder.com/600x400?text=Aadhaar'},
        {'type': 'PAN', 'img': 'https://via.placeholder.com/600x400?text=PAN'},
        {'type': 'Passport', 'img': 'https://via.placeholder.com/600x400?text=Passport'},
        {'type': 'Utility Bill', 'img': 'https://via.placeholder.com/600x400?text=Utility+Bill'},
      ],
      'uploadedDate': 'Jul 15, 2024',
      'validity': 'Dec 31, 2030',
      'status': 'Pending',
      'notes': ['Aadhaar image slightly blurry, but readable. PAN looks clear.'],
    },
    {
      'id': 2,
      'name': 'Rajesh Kumar',
      'email': 'rajesh.kumar@example.com',
      'kycId': 'KYC-002-20240714',
      'documents': [
        {'type': 'Aadhaar', 'img': 'https://via.placeholder.com/600x400?text=Aadhaar'},
        {'type': 'PAN', 'img': 'https://via.placeholder.com/600x400?text=PAN'},
        {'type': 'Passport', 'img': 'https://via.placeholder.com/600x400?text=Passport'},
        {'type': 'Utility Bill', 'img': 'https://via.placeholder.com/600x400?text=Utility+Bill'},
      ],
      'uploadedDate': 'Jul 14, 2024',
      'validity': 'Jun 15, 2028',
      'status': 'Approved',
      'notes': ['All documents verified and approved. No issues found.'],
    },
  ];

  List<Map<String, dynamic>> get filteredUsers {
    if (_searchTerm.isEmpty) return users;
    return users.where((user) {
      final name = user['name'].toString().toLowerCase();
      final kycId = user['kycId'].toString().toLowerCase();
      final email = user['email'].toString().toLowerCase();
      final search = _searchTerm.toLowerCase();
      return name.contains(search) || kycId.contains(search) || email.contains(search);
    }).toList();
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
                  _buildSearchBar(),
                  const SizedBox(height: 16),
                  if (_alert['type'] != null) ...[
                    _buildAlert(),
                    const SizedBox(height: 16),
                  ],
                  ...filteredUsers.map((user) => _buildUserCard(user)),
                  if (filteredUsers.isEmpty) _buildNoResults(),
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
                    'KYC Approve',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Efficiently review and manage all KYC submissions',
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

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search by Name, Email, or KYC ID...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: KYCColors.primary),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: KYCColors.primary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: KYCColors.primary, width: 2),
          ),
          suffixIcon: Container(
            margin: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: KYCColors.primary,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(6),
                bottomRight: Radius.circular(6),
              ),
            ),
            child: const Icon(Icons.search, color: Colors.white),
          ),
        ),
        onChanged: (value) => setState(() => _searchTerm = value),
      ),
    );
  }

  Widget _buildAlert() {
    Color bgColor;
    switch (_alert['type']) {
      case 'success':
        bgColor = KYCColors.success;
        break;
      case 'danger':
        bgColor = KYCColors.danger;
        break;
      case 'warning':
        bgColor = KYCColors.warning;
        break;
      default:
        bgColor = KYCColors.primary;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        _alert['msg'] ?? '',
        style: TextStyle(
          color: _alert['type'] == 'warning' ? Colors.black : Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildUserCard(Map<String, dynamic> user) {
    final isRecent = _recentAction[user['id']] != null;
    Color? borderColor;
    
    if (isRecent) {
      switch (_recentAction[user['id']]) {
        case 'approve':
          borderColor = KYCColors.success;
          break;
        case 'reject':
          borderColor = KYCColors.danger;
          break;
        case 'request':
          borderColor = KYCColors.warning;
          break;
        case 'edd':
          borderColor = KYCColors.danger;
          break;
      }
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: borderColor ?? KYCColors.primary,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUserInfo(user),
            const SizedBox(height: 16),
            _buildDocumentsGrid(user['documents']),
            const SizedBox(height: 16),
            _buildMetaInfo(user),
            const SizedBox(height: 12),
            _buildNotes(user),
            const SizedBox(height: 16),
            _buildActionButtons(user),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo(Map<String, dynamic> user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user['name'],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${user['email']} | KYC ID: ${user['kycId']}',
                style: const TextStyle(
                  fontSize: 12,
                  color: KYCColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        _buildStatusBadge(user['status']),
      ],
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bgColor;
    switch (status) {
      case 'Approved':
        bgColor = KYCColors.approved;
        break;
      case 'Rejected':
        bgColor = KYCColors.rejected;
        break;
      case 'Info Requested':
        bgColor = KYCColors.warning;
        break;
      case 'Escalated (EDD)':
        bgColor = KYCColors.escalated;
        break;
      default:
        bgColor = KYCColors.pending;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: status == 'Info Requested' ? Colors.black : Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildDocumentsGrid(List<dynamic> documents) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
        
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 0.8,
          ),
          itemCount: documents.length,
          itemBuilder: (context, index) {
            final doc = documents[index];
            return Container(
              decoration: BoxDecoration(
                color: KYCColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    doc['type'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => setState(() => _selectedDoc = doc),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white),
                            padding: const EdgeInsets.symmetric(vertical: 6),
                          ),
                          child: const Text('View', style: TextStyle(fontSize: 12)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => _handleDownload(doc),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white),
                            padding: const EdgeInsets.symmetric(vertical: 6),
                          ),
                          child: const Text('Download', style: TextStyle(fontSize: 12)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildMetaInfo(Map<String, dynamic> user) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        'Uploaded: ${user['uploadedDate']} | Validity: ${user['validity']}',
        style: const TextStyle(fontSize: 13),
      ),
    );
  }

  Widget _buildNotes(Map<String, dynamic> user) {
    final notes = user['notes'] as List<dynamic>;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3CD),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: KYCColors.warning),
      ),
      child: Text(
        'Compliance Notes: ${notes.isNotEmpty ? notes.last : "No notes yet."}',
        style: const TextStyle(fontSize: 13),
      ),
    );
  }

  Widget _buildActionButtons(Map<String, dynamic> user) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        ElevatedButton.icon(
          onPressed: () => _handleAction('approve', user['id']),
          icon: const Icon(Icons.check_circle, size: 18),
          label: const Text('Approve'),
          style: ElevatedButton.styleFrom(
            backgroundColor: KYCColors.success,
            foregroundColor: Colors.white,
          ),
        ),
        ElevatedButton.icon(
          onPressed: () => _handleAction('reject', user['id']),
          icon: const Icon(Icons.cancel, size: 18),
          label: const Text('Reject'),
          style: ElevatedButton.styleFrom(
            backgroundColor: KYCColors.danger,
            foregroundColor: Colors.white,
          ),
        ),
        ElevatedButton.icon(
          onPressed: () => _handleAction('request', user['id']),
          icon: const Icon(Icons.description, size: 18),
          label: const Text('Request Docs'),
          style: ElevatedButton.styleFrom(
            backgroundColor: KYCColors.warning,
            foregroundColor: Colors.black,
          ),
        ),
        ElevatedButton.icon(
          onPressed: () => _handleAction('notes', user['id']),
          icon: const Icon(Icons.note, size: 18),
          label: const Text('Add Notes'),
          style: ElevatedButton.styleFrom(
            backgroundColor: KYCColors.primary,
            foregroundColor: Colors.white,
          ),
        ),
        ElevatedButton.icon(
          onPressed: () => _handleAction('edd', user['id']),
          icon: const Icon(Icons.security, size: 18),
          label: const Text('Mark EDD'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[800],
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildNoResults() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: const [
            Icon(Icons.search_off, size: 64, color: KYCColors.textSecondary),
            SizedBox(height: 16),
            Text(
              'No users found matching your search.',
              style: TextStyle(fontSize: 16, color: KYCColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }

  void _handleAction(String type, int userId) {
    final userIndex = users.indexWhere((u) => u['id'] == userId);
    if (userIndex == -1) return;

    final user = users[userIndex];
    String msg = '';
    String alertType = 'success';

    setState(() {
      switch (type) {
        case 'approve':
          users[userIndex]['status'] = 'Approved';
          msg = '✅ ${user['name']} approved.';
          _recentAction[userId] = 'approve';
          break;
        case 'reject':
          users[userIndex]['status'] = 'Rejected';
          msg = '❌ ${user['name']} rejected.';
          alertType = 'danger';
          _recentAction[userId] = 'reject';
          break;
        case 'request':
          users[userIndex]['status'] = 'Info Requested';
          msg = '📑 Requested more documents from ${user['name']}.';
          alertType = 'warning';
          _recentAction[userId] = 'request';
          break;
        case 'notes':
          users[userIndex]['notes'].add('New note added');
          msg = '📝 Note added for ${user['name']}.';
          break;
        case 'edd':
          users[userIndex]['status'] = 'Escalated (EDD)';
          msg = '🔎 ${user['name']} marked for EDD.';
          alertType = 'danger';
          _recentAction[userId] = 'edd';
          break;
      }

      _alert = {'type': alertType, 'msg': msg};
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _recentAction.remove(userId);
        });
      }
    });

    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        setState(() {
          _alert = {};
        });
      }
    });
  }

  void _handleDownload(Map<String, dynamic> doc) {
    // In a real app, implement actual download functionality
    setState(() {
      _alert = {
        'type': 'success',
        'msg': '${doc['type']} downloaded successfully!'
      };
    });

    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        setState(() {
          _alert = {};
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
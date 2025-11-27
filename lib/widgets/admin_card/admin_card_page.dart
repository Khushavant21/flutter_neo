import 'package:flutter/material.dart';

void main() {
  runApp(const CardServicesApp());
}

class CardServicesApp extends StatelessWidget {
  const CardServicesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card Services',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      home: const CardPage(),
    );
  }
}

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  late String activeTab;
  String? notificationMessage;
  bool isNotificationSuccess = false;

  late int requestsPage;
  late int managementPage;
  late int fraudPage;
  static const int itemsPerPage = 5;

  late List<CardRequest> cardRequests;
  late List<CardManagement> cardManagement;
  late List<FraudData> fraudData;

  late Map<String, String> newFraud;

  @override
  void initState() {
    super.initState();
    activeTab = 'requests';
    requestsPage = 1;
    managementPage = 1;
    fraudPage = 1;
    newFraud = {
      'transactionId': '',
      'cardNumber': '',
      'amount': '',
      'user': '',
      'reason': '',
    };
    _initializeData();
  }

  void _initializeData() {
    cardRequests = [
      CardRequest(1, 'Khushavant', 'AHGPY1234T', 'new', 'pending', ''),
      CardRequest(2, 'Amit', 'AHFWQ1234R', 'virtual', 'pending', ''),
      CardRequest(3, 'Priya', 'BHWPX5678S', 'new', 'pending', ''),
      CardRequest(4, 'Ravi', 'CHGPZ1234U', 'virtual', 'pending', ''),
      CardRequest(5, 'Neha', 'DHFQR5678V', 'new', 'approved', 'approved'),
      CardRequest(6, 'Vikram', 'EHGPS1234W', 'virtual', 'pending', ''),
      CardRequest(7, 'Sneha', 'FHFPT5678X', 'new', 'pending', ''),
    ];

    cardManagement = [
      CardManagement(1, 'ACC001234567', '', '', 'Added by admin'),
      CardManagement(2, 'ACC001234568', '', '', 'Added by admin'),
      CardManagement(3, 'ACC001234569', '', '', 'Added by admin'),
      CardManagement(4, 'ACC001234570', '', '', 'Added by admin'),
      CardManagement(5, 'ACC001234571', '', '', 'Added by admin'),
      CardManagement(6, 'ACC001234572', '', '', 'Added by admin'),
    ];

    fraudData = [
      FraudData(
        'TXN001',
        'ACC001234567',
        '50000',
        'Khushavant',
        'Unusual location',
        '',
      ),
      FraudData(
        'TXN002',
        'ACC001234568',
        '25000',
        'Amit',
        'High amount transaction',
        '',
      ),
      FraudData(
        'TXN003',
        'ACC001234569',
        '75000',
        'Priya',
        'Multiple rapid transactions',
        '',
      ),
      FraudData(
        'TXN004',
        'ACC001234570',
        '30000',
        'Ravi',
        'International transaction',
        '',
      ),
      FraudData(
        'TXN005',
        'ACC001234571',
        '60000',
        'Neha',
        'Late night transaction',
        '',
      ),
      FraudData(
        'TXN006',
        'ACC001234572',
        '40000',
        'Vikram',
        'Duplicate charge',
        '',
      ),
    ];
  }

  void _showNotification(String message, bool isSuccess) {
    setState(() {
      notificationMessage = message;
      isNotificationSuccess = isSuccess;
    });
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => notificationMessage = null);
      }
    });
  }

  List<T> _getPaginatedData<T>(List<T> data, int page) {
    final start = (page - 1) * itemsPerPage;
    return data.sublist(start, (start + itemsPerPage).clamp(0, data.length));
  }

  int _getTotalPages(int dataLength) => (dataLength / itemsPerPage).ceil();

  void _handleRequestAction(int index, bool approved) {
    final actualIndex = (requestsPage - 1) * itemsPerPage + index;
    final req = cardRequests[actualIndex];
    final cardType = req.requestType == 'new' ? 'New Card' : 'Virtual Card';
    final status = approved ? 'approved' : 'rejected';

    setState(() {
      cardRequests[actualIndex].status = status;
      cardRequests[actualIndex].action = status;
    });

    final message = approved
        ? '$cardType request approved for ${req.accountNumber} ✓'
        : 'Card request rejected for ${req.accountNumber} ✗';
    _showNotification(message, approved);
  }

  void _handleRequestStatusChange(int index, String newStatus) {
    final actualIndex = (requestsPage - 1) * itemsPerPage + index;

    setState(() {
      cardRequests[actualIndex].status = newStatus;
      cardRequests[actualIndex].action = newStatus;
    });

    final statusMsg = newStatus[0].toUpperCase() + newStatus.substring(1);
    _showNotification('Status changed to $statusMsg ✓', true);
  }

  void _handleManagementAction(int index) {
    final actualIndex = (managementPage - 1) * itemsPerPage + index;
    final card = cardManagement[actualIndex];

    if (card.action.isEmpty) {
      _showNotification('Please select an action ✗', false);
      return;
    }

    final actionMessages = {
      'block': 'Card Blocked',
      'change': 'Transaction Limit Changed',
      'replace': 'Card Replacement Initiated',
      'setlimit': 'New Card Limit Set',
    };

    setState(() {
      cardManagement[actualIndex].actionTaken =
          actionMessages[card.action] ?? '';
    });

    _showNotification(
      '${actionMessages[card.action]} for ${card.cardNumber} ✓',
      true,
    );
  }

  void _handleFraudAction(int index, String actionType) {
    final actualIndex = (fraudPage - 1) * itemsPerPage + index;
    setState(() {
      fraudData[actualIndex].action = actionType;
    });

    final msg = actionType == 'Safe'
        ? '${fraudData[actualIndex].user} is marked as SAFE ✓'
        : '${fraudData[actualIndex].user} is NOT safe ✗';
    _showNotification(msg, actionType == 'Safe');
  }

  void _handleFraudSubmit() {
    if (newFraud.values.any((v) => v.isEmpty)) {
      _showNotification('Please fill all fields ✗', false);
      return;
    }

    setState(() {
      fraudData.add(
        FraudData(
          newFraud['transactionId']!,
          newFraud['cardNumber']!,
          newFraud['amount']!,
          newFraud['user']!,
          newFraud['reason']!,
          '',
        ),
      );
      newFraud = {
        'transactionId': '',
        'cardNumber': '',
        'amount': '',
        'user': '',
        'reason': '',
      };
    });

    _showNotification('Fraud record added successfully ✓', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with title
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF900603), Color(0xFFB30805)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x33900603),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Text(
                'Card Services',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),

            // Tabs - Fixed to show all three tabs
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTab('requests', 'Card Requests'),
                    const SizedBox(width: 10),
                    _buildTab('management', 'Card Management'),
                    const SizedBox(width: 10),
                    _buildTab('fraud', 'Fraud Flags'),
                  ],
                ),
              ),
            ),

            // Notification
            if (notificationMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 0,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 18,
                  ),
                  decoration: BoxDecoration(
                    color: isNotificationSuccess
                        ? const Color(0xFFD4EDDA)
                        : const Color(0xFFF8D7DA),
                    border: Border.all(
                      color: isNotificationSuccess
                          ? const Color(0xFFC3E6CB)
                          : const Color(0xFFF5C6CB),
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text(
                      notificationMessage!,
                      style: TextStyle(
                        color: isNotificationSuccess
                            ? const Color(0xFF155724)
                            : const Color(0xFF721C24),
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),

            // Content
            if (activeTab == 'requests') _buildRequestsSection(),
            if (activeTab == 'management') _buildManagementSection(),
            if (activeTab == 'fraud') _buildFraudSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String tab, String label) {
    final isActive = activeTab == tab;
    return GestureDetector(
      onTap: () => setState(() => activeTab = tab),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color.fromARGB(255, 144, 6, 3) : Colors.white,
          border: Border.all(
            color: isActive
                ? const Color.fromARGB(255, 144, 6, 3)
                : const Color.fromARGB(255, 221, 221, 221),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(6),
          boxShadow: isActive
              ? [
                  const BoxShadow(
                    color: Color.fromARGB(51, 144, 6, 3),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : const Color(0xFF900603),
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  // Part 2 code
  Widget _buildRequestsSection() {
    final paginatedData = _getPaginatedData(cardRequests, requestsPage);
    final totalPages = _getTotalPages(cardRequests.length);

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _buildSectionHeader('Card Requests'),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: paginatedData.length,
              itemBuilder: (context, index) {
                final req = paginatedData[index];
                return _buildRequestCard(req, index);
              },
            ),
          ),
          _buildPagination(requestsPage, totalPages, (page) {
            setState(() => requestsPage = page);
          }),
        ],
      ),
    );
  }

  Widget _buildRequestCard(CardRequest req, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFEEE)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDataRow('Account Number', req.accountNumber),
          _buildDataRow('PAN Number', req.panNumber),
          _buildDataRow(
            'Request Type',
            req.requestType == 'new' ? 'New Card' : 'Virtual Card',
            isTypeField: true,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Status',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: req.status == 'approved'
                        ? const Color.fromARGB(255, 212, 237, 218)
                        : req.status == 'rejected'
                        ? const Color.fromARGB(255, 248, 215, 218)
                        : const Color.fromARGB(255, 255, 243, 205),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    req.status.toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: req.status == 'approved'
                          ? const Color.fromARGB(255, 21, 87, 36)
                          : req.status == 'rejected'
                          ? const Color.fromARGB(255, 114, 28, 36)
                          : const Color.fromARGB(255, 133, 100, 4),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          if (req.status == 'pending')
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _handleRequestAction(index, true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF900603),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Text(
                      'Approve',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _handleRequestAction(index, false),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFDDD)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Text(
                      'Reject',
                      style: TextStyle(
                        color: Color(0xFF666),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            )
          else
            SizedBox(
              width: double.infinity,
              child: DropdownButtonFormField<String>(
                initialValue: req.status,
                style: const TextStyle(
                  color: Color(0xFF900603),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Color(0xFFDDD)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Color(0xFFDDD)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Color(0xFF900603)),
                  ),
                ),
                dropdownColor: Colors.white,
                items: const [
                  DropdownMenuItem(value: 'approved', child: Text('Approved')),
                  DropdownMenuItem(value: 'rejected', child: Text('Rejected')),
                  DropdownMenuItem(value: 'pending', child: Text('Pending')),
                  DropdownMenuItem(value: 'hold', child: Text('Hold')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    _handleRequestStatusChange(index, value);
                  }
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildManagementSection() {
    final paginatedData = _getPaginatedData(cardManagement, managementPage);
    final totalPages = _getTotalPages(cardManagement.length);

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _buildSectionHeader('Card Management'),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: paginatedData.length,
              itemBuilder: (context, index) {
                final card = paginatedData[index];
                return _buildManagementCard(card, index);
              },
            ),
          ),
          _buildPagination(managementPage, totalPages, (page) {
            setState(() => managementPage = page);
          }),
        ],
      ),
    );
  }

  Widget _buildManagementCard(CardManagement card, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFEEE)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDataRow('Card Number', card.cardNumber),
          _buildDataRow('Remarks', card.remarks),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: DropdownButtonFormField<String>(
              initialValue: card.action.isEmpty ? null : card.action,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                hintText: 'Choose Option',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: Color(0xFFDDD)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: Color(0xFFDDD)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: Color(0xFF900603)),
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'block',
                  child: Text('Block/Unblock Card'),
                ),
                DropdownMenuItem(
                  value: 'change',
                  child: Text('Change Transaction Limit'),
                ),
                DropdownMenuItem(value: 'replace', child: Text('Replace Card')),
                DropdownMenuItem(
                  value: 'setlimit',
                  child: Text('Set New Card Limit'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  cardManagement[(managementPage - 1) * itemsPerPage + index]
                          .action =
                      value ?? '';
                });
              },
            ),
          ),
          if (card.actionTaken.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFD4EDDA),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                card.actionTaken,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF155724),
                ),
              ),
            ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _handleManagementAction(index),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF900603),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: const Text(
                'Submit',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFraudSection() {
    final paginatedData = _getPaginatedData(fraudData, fraudPage);
    final totalPages = _getTotalPages(fraudData.length);

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _buildSectionHeader('Fraud Flags'),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: paginatedData.length,
              itemBuilder: (context, index) {
                final fraud = paginatedData[index];
                return _buildFraudCard(fraud, index);
              },
            ),
          ),
          _buildPagination(fraudPage, totalPages, (page) {
            setState(() => fraudPage = page);
          }),
          _buildAddFraudForm(),
        ],
      ),
    );
  }

  Widget _buildFraudCard(FraudData fraud, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFEEE)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDataRow('Transaction ID', fraud.transactionId),
          _buildDataRow('Card Number', fraud.cardNumber),
          _buildDataRow('Amount', '₹${fraud.amount}'),
          _buildDataRow('User', fraud.user),
          _buildDataRow('Reason', fraud.reason),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _handleFraudAction(index, 'Safe'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF900603),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text(
                    'Mark Safe',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _handleFraudAction(index, 'Escalated'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF900603),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text(
                    'Escalate',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (fraud.action.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                fraud.action,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: fraud.action == 'Safe'
                      ? const Color(0xFF28A745)
                      : const Color(0xFFDC3545),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAddFraudForm() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add Suspicious Transaction',
            style: TextStyle(
              color: Color(0xFF900603),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          _buildFormInput(
            'Transaction ID',
            (value) => newFraud['transactionId'] = value,
          ),
          _buildFormInput(
            'Card Number',
            (value) => newFraud['cardNumber'] = value,
          ),
          _buildFormInput(
            'Amount',
            (value) => newFraud['amount'] = value,
            isNumber: true,
          ),
          _buildFormInput('User', (value) => newFraud['user'] = value),
          _buildFormInput('Reason', (value) => newFraud['reason'] = value),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _handleFraudSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF900603),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: const Text(
                'Add Record',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormInput(
    String hint,
    Function(String) onChanged, {
    bool isNumber = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Color(0xFFDDD)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Color(0xFFDDD)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Color(0xFF900603)),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 248, 249, 250),
        border: Border(
          bottom: BorderSide(color: Color.fromARGB(255, 144, 6, 3), width: 3),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 144, 6, 3),
        ),
      ),
    );
  }

  Widget _buildDataRow(String label, String value, {bool isTypeField = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Color.fromARGB(255, 144, 6, 3),
            ),
          ),
          if (isTypeField)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 227, 242, 253),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 25, 118, 210),
                ),
              ),
            )
          else
            Flexible(
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color.fromARGB(255, 51, 51, 51),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPagination(
    int currentPage,
    int totalPages,
    Function(int) onPageChange,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: currentPage > 1
                ? () => onPageChange(currentPage - 1)
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF900603),
              disabledBackgroundColor: const Color(0xFFCCC),
              foregroundColor: Colors.white,
              disabledForegroundColor: Colors.white,
            ),
            child: const Text('Prev'),
          ),
          const SizedBox(width: 8),
          ...List.generate(totalPages, (index) {
            final pageNum = index + 1;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ElevatedButton(
                onPressed: () => onPageChange(pageNum),
                style: ElevatedButton.styleFrom(
                  backgroundColor: currentPage == pageNum
                      ? const Color(0xFF900603)
                      : const Color(0xFFE0E0E0),
                  foregroundColor: currentPage == pageNum
                      ? Colors.white
                      : Colors.black,
                  minimumSize: const Size(50, 36),
                ),
                child: Text('$pageNum'),
              ),
            );
          }),
          ElevatedButton(
            onPressed: currentPage < totalPages
                ? () => onPageChange(currentPage + 1)
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF900603),
              disabledBackgroundColor: const Color(0xFFCCC),
              foregroundColor: Colors.white,
              disabledForegroundColor: Colors.white,
            ),
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}

// Models
class CardRequest {
  final int id;
  final String accountNumber;
  final String panNumber;
  final String requestType;
  String status;
  String action;

  CardRequest(
    this.id,
    this.accountNumber,
    this.panNumber,
    this.requestType,
    this.status,
    this.action,
  );
}

class CardManagement {
  final int id;
  final String cardNumber;
  String action;
  String actionTaken;
  final String remarks;

  CardManagement(
    this.id,
    this.cardNumber,
    this.action,
    this.actionTaken,
    this.remarks,
  );
}

class FraudData {
  final String transactionId;
  final String cardNumber;
  final String amount;
  final String user;
  final String reason;
  String action;

  FraudData(
    this.transactionId,
    this.cardNumber,
    this.amount,
    this.user,
    this.reason,
    this.action,
  );
}

// lib/widgets/card_page.dart
import 'package:flutter/material.dart';
import '../admin_card/admin_card_styles.dart';
import '../admin_top_navbar.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage>
    with SingleTickerProviderStateMixin {
  String activeTab = 'requests';
  List<Map<String, dynamic>> fraudData = [];
  Map<String, dynamic>? notification;
  int? editingIndex;

  // Form controllers for new fraud entry
  final TextEditingController _transactionIdController =
      TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  // Form controllers for editing
  final TextEditingController _editTransactionIdController =
      TextEditingController();
  final TextEditingController _editCardNumberController =
      TextEditingController();
  final TextEditingController _editAmountController = TextEditingController();
  final TextEditingController _editUserController = TextEditingController();
  final TextEditingController _editReasonController = TextEditingController();

  // Controllers for Card Requests
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _panNumberController = TextEditingController();
  String _selectedRequestType = 'new';

  // Controllers for Card Management
  final TextEditingController _cardNumberManagementController =
      TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  String _selectedAction = 'block';

  late AnimationController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _transactionIdController.dispose();
    _cardNumberController.dispose();
    _amountController.dispose();
    _userController.dispose();
    _reasonController.dispose();
    _editTransactionIdController.dispose();
    _editCardNumberController.dispose();
    _editAmountController.dispose();
    _editUserController.dispose();
    _editReasonController.dispose();
    _accountNumberController.dispose();
    _panNumberController.dispose();
    _cardNumberManagementController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  void _handleFraudSubmit() {
    if (_transactionIdController.text.isEmpty ||
        _cardNumberController.text.isEmpty ||
        _amountController.text.isEmpty ||
        _userController.text.isEmpty ||
        _reasonController.text.isEmpty) {
      return;
    }

    setState(() {
      fraudData.add({
        'transactionId': _transactionIdController.text,
        'cardNumber': _cardNumberController.text,
        'amount': _amountController.text,
        'user': _userController.text,
        'reason': _reasonController.text,
        'action': '',
      });

      _transactionIdController.clear();
      _cardNumberController.clear();
      _amountController.clear();
      _userController.clear();
      _reasonController.clear();
    });
  }

  void _handleFraudAction(int index, String actionType) {
    setState(() {
      fraudData[index]['action'] = actionType;

      final msg = actionType == 'Safe'
          ? '${fraudData[index]['user']} is marked as SAFE ✅'
          : '${fraudData[index]['user']} is NOT safe ❌. Please check details!';

      notification = {'type': actionType.toLowerCase(), 'message': msg};
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          notification = null;
        });
      }
    });
  }

  void _handleEditClick(int index) {
    setState(() {
      editingIndex = index;
      _editTransactionIdController.text = fraudData[index]['transactionId'];
      _editCardNumberController.text = fraudData[index]['cardNumber'];
      _editAmountController.text = fraudData[index]['amount'];
      _editUserController.text = fraudData[index]['user'];
      _editReasonController.text = fraudData[index]['reason'];
    });
  }

  void _handleSaveEdit(int index) {
    setState(() {
      fraudData[index]['transactionId'] = _editTransactionIdController.text;
      fraudData[index]['cardNumber'] = _editCardNumberController.text;
      fraudData[index]['amount'] = _editAmountController.text;
      fraudData[index]['user'] = _editUserController.text;
      fraudData[index]['reason'] = _editReasonController.text;
      editingIndex = null;

      notification = {
        'type': 'safe',
        'message':
            'Record for ${_editUserController.text} updated successfully ✅',
      };
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          notification = null;
        });
      }
    });
  }

  void _handleCancelEdit() {
    setState(() {
      editingIndex = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Scaffold(
      backgroundColor: CardStyles.backgroundColor,
      body: Column(
        children: [
          // Top Navbar - NeoBank Admin header
          const TopNavbar(),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Scrolling Card Title
                  _buildScrollingTitle(),

                  // Main Container
                  Container(
                    constraints: const BoxConstraints(maxWidth: 900),
                    padding: EdgeInsets.all(isMobile ? 15 : 20),
                    margin: EdgeInsets.symmetric(
                      horizontal: isMobile ? 10 : 20,
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
                        // Tabs
                        _buildTabs(isMobile),

                        const SizedBox(height: 25),

                        // Notification
                        if (notification != null) _buildNotification(),

                        // Content based on active tab
                        if (activeTab == 'requests')
                          _buildRequestsForm(isMobile),
                        if (activeTab == 'management')
                          _buildManagementForm(isMobile),
                        if (activeTab == 'fraud') _buildFraudSection(isMobile),
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

  Widget _buildScrollingTitle() {
    return Container(
      width: double.infinity,
      color: CardStyles.primaryRed,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      margin: const EdgeInsets.only(top: 0, bottom: 20),
      child: AnimatedBuilder(
        animation: _scrollController,
        builder: (context, child) {
          return ShaderMask(
            shaderCallback: (bounds) {
              return const LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.white,
                  Colors.white,
                  Colors.transparent,
                ],
                stops: [0.0, 0.1, 0.9, 1.0],
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstIn,
            child: Text(
              'Card Services',
              style: CardStyles.titleStyle,
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    );
  }

  Widget _buildTabs(bool isMobile) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: [
        _buildTabButton('Card Requests', 'requests', isMobile),
        _buildTabButton('Card Management', 'management', isMobile),
        _buildTabButton('Fraud Flags', 'fraud', isMobile),
      ],
    );
  }

  Widget _buildTabButton(String label, String value, bool isMobile) {
    final isActive = activeTab == value;
    return ElevatedButton(
      onPressed: () => setState(() => activeTab = value),
      style: CardStyles.tabButtonStyle(isActive: isActive, isMobile: isMobile),
      child: Text(
        label,
        style: isActive
            ? CardStyles.buttonStyleActive
            : (isMobile
                ? CardStyles.buttonStyleMobile
                : CardStyles.buttonStyle),
      ),
    );
  }

  Widget _buildNotification() {
    final isSafe = notification!['type'] == 'safe';
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: CardStyles.notificationDecoration(isSafe: isSafe),
      child: Text(
        notification!['message'],
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isSafe ? CardStyles.successText : CardStyles.errorText,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildRequestsForm(bool isMobile) {
    return Column(
      children: [
        _buildFormField(
          'Account Number',
          _accountNumberController,
          'Enter your account number',
          isMobile,
        ),
        const SizedBox(height: 15),
        _buildFormField(
          'PAN Number',
          _panNumberController,
          'Enter your PAN number',
          isMobile,
        ),
        const SizedBox(height: 15),
        _buildDropdownField(
          'Request Type',
          _selectedRequestType,
          [
            {'value': 'new', 'label': 'New Card Issuance'},
            {'value': 'virtual', 'label': 'Virtual Card Creation'},
          ],
          (value) => setState(() => _selectedRequestType = value!),
          isMobile,
        ),
        const SizedBox(height: 15),
        _buildSubmitButton('Submit Request', isMobile),
      ],
    );
  }

  Widget _buildManagementForm(bool isMobile) {
    return Column(
      children: [
        _buildFormField(
          'Card Number',
          _cardNumberManagementController,
          'Enter your card number',
          isMobile,
        ),
        const SizedBox(height: 15),
        _buildDropdownField(
          'Action',
          _selectedAction,
          [
            {'value': 'block', 'label': 'Block / Unblock Card'},
            {'value': 'limit', 'label': 'Change Transaction Limit'},
            {'value': 'replace', 'label': 'Replace Card'},
            {'value': 'setlimit', 'label': 'Set New Card Limit'},
          ],
          (value) => setState(() => _selectedAction = value!),
          isMobile,
        ),
        const SizedBox(height: 15),
        _buildTextAreaField(
          'Remarks',
          _remarksController,
          'Enter additional details',
          isMobile,
        ),
        const SizedBox(height: 15),
        _buildSubmitButton('Submit Action', isMobile),
      ],
    );
  }

  Widget _buildFormField(
    String label,
    TextEditingController controller,
    String hint,
    bool isMobile,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: isMobile
              ? CardStyles.labelStyleMobile
              : CardStyles.labelStyle,
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          decoration: CardStyles.inputDecoration(
            hintText: hint,
            isMobile: isMobile,
          ),
          style: isMobile
              ? CardStyles.bodyStyleMobile
              : CardStyles.bodyStyle,
        ),
      ],
    );
  }

  Widget _buildDropdownField(
    String label,
    String value,
    List<Map<String, String>> options,
    Function(String?) onChanged,
    bool isMobile,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: isMobile
              ? CardStyles.labelStyleMobile
              : CardStyles.labelStyle,
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          initialValue: value,
          decoration: CardStyles.inputDecoration(
            hintText: '',
            isMobile: isMobile,
          ),
          items: options.map((option) {
            return DropdownMenuItem<String>(
              value: option['value'],
              child: Text(
                option['label']!,
                style: isMobile
                    ? CardStyles.bodyStyleMobile
                    : CardStyles.bodyStyle,
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildTextAreaField(
    String label,
    TextEditingController controller,
    String hint,
    bool isMobile,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: isMobile
              ? CardStyles.labelStyleMobile
              : CardStyles.labelStyle,
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: 3,
          decoration: CardStyles.inputDecoration(
            hintText: hint,
            isMobile: isMobile,
          ),
          style: isMobile
              ? CardStyles.bodyStyleMobile
              : CardStyles.bodyStyle,
        ),
      ],
    );
  }

  Widget _buildSubmitButton(String label, bool isMobile) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$label submitted successfully!'),
              backgroundColor: CardStyles.successColor,
              duration: const Duration(seconds: 2),
            ),
          );
        },
        style: CardStyles.primaryButtonStyle(isMobile: isMobile),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isMobile ? 13 : 14,
          ),
        ),
      ),
    );
  }

  Widget _buildFraudSection(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '🚨 Fraud Flags',
          style: CardStyles.headingStyle,
        ),
        const SizedBox(height: 15),

        // Fraud Table
        if (fraudData.isNotEmpty) _buildFraudTable(isMobile),

        const SizedBox(height: 20),

        // Add New Fraud Entry
        const Text(
          '➕ Add Suspicious Transaction',
          style: CardStyles.subHeadingStyle,
        ),
        const SizedBox(height: 15),

        _buildAddFraudForm(isMobile),
      ],
    );
  }

  Widget _buildFraudTable(bool isMobile) {
    if (isMobile) {
      return Column(
        children: fraudData.asMap().entries.map((entry) {
          final index = entry.key;
          final row = entry.value;
          final isEditing = editingIndex == index;

          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(10),
            decoration: CardStyles.mobileTableRowDecoration,
            child: Column(
              children: [
                _buildMobileTableRow(
                  'Transaction ID',
                  isEditing,
                  row['transactionId'],
                  _editTransactionIdController,
                ),
                _buildMobileTableRow(
                  'Card Number',
                  isEditing,
                  row['cardNumber'],
                  _editCardNumberController,
                ),
                _buildMobileTableRow(
                  'Amount',
                  isEditing,
                  '₹${row['amount']}',
                  _editAmountController,
                  isAmount: true,
                ),
                _buildMobileTableRow(
                  'User',
                  isEditing,
                  row['user'],
                  _editUserController,
                ),
                _buildMobileTableRow(
                  'Reason',
                  isEditing,
                  row['reason'],
                  _editReasonController,
                ),
                const Divider(),
                _buildMobileActionButtons(index, row, isEditing),
              ],
            ),
          );
        }).toList(),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: CardStyles.tableHeaderColor,
        columns: const [
          DataColumn(
            label: Text('Transaction ID', style: CardStyles.tableHeaderStyle),
          ),
          DataColumn(
            label: Text('Card Number', style: CardStyles.tableHeaderStyle),
          ),
          DataColumn(
            label: Text('Amount', style: CardStyles.tableHeaderStyle),
          ),
          DataColumn(
            label: Text('User', style: CardStyles.tableHeaderStyle),
          ),
          DataColumn(
            label: Text('Reason', style: CardStyles.tableHeaderStyle),
          ),
          DataColumn(
            label: Text('Action', style: CardStyles.tableHeaderStyle),
          ),
          DataColumn(
            label: Text('Action Performed', style: CardStyles.tableHeaderStyle),
          ),
          DataColumn(
            label: Text('Edit', style: CardStyles.tableHeaderStyle),
          ),
        ],
        rows: fraudData.asMap().entries.map((entry) {
          final index = entry.key;
          final row = entry.value;
          final isEditing = editingIndex == index;

          return DataRow(
            color: isEditing ? CardStyles.tableEditingRowColor : null,
            cells: [
              DataCell(
                isEditing
                    ? _buildEditField(_editTransactionIdController)
                    : Text(row['transactionId'], style: CardStyles.tableCellStyle),
              ),
              DataCell(
                isEditing
                    ? _buildEditField(_editCardNumberController)
                    : Text(row['cardNumber'], style: CardStyles.tableCellStyle),
              ),
              DataCell(
                isEditing
                    ? _buildEditField(_editAmountController, isNumber: true)
                    : Text('₹${row['amount']}', style: CardStyles.tableCellStyle),
              ),
              DataCell(
                isEditing
                    ? _buildEditField(_editUserController)
                    : Text(row['user'], style: CardStyles.tableCellStyle),
              ),
              DataCell(
                isEditing
                    ? _buildEditField(_editReasonController)
                    : Text(row['reason'], style: CardStyles.tableCellStyle),
              ),
              DataCell(_buildActionButtons(index)),
              DataCell(
                Text(
                  row['action'] ?? '—',
                  style: TextStyle(
                    color: row['action'] == 'Safe'
                        ? CardStyles.successColor
                        : CardStyles.errorColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              DataCell(_buildEditButtons(index, isEditing)),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMobileTableRow(
    String label,
    bool isEditing,
    String value,
    TextEditingController controller, {
    bool isAmount = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 45,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: CardStyles.primaryRed,
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 55,
            child: isEditing
                ? TextField(
                    controller: controller,
                    keyboardType: isAmount
                        ? TextInputType.number
                        : TextInputType.text,
                    style: CardStyles.tableCellStyleMobile,
                    decoration: CardStyles.editingInputDecoration(isMobile: true),
                  )
                : Text(
                    value,
                    style: CardStyles.tableCellStyleMobile,
                    overflow: TextOverflow.ellipsis,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileActionButtons(
    int index,
    Map<String, dynamic> row,
    bool isEditing,
  ) {
    if (isEditing) {
      return Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () => _handleSaveEdit(index),
              style: CardStyles.successButtonStyle(small: true),
              child: const Text('Save', style: TextStyle(fontSize: 11)),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: ElevatedButton(
              onPressed: _handleCancelEdit,
              style: CardStyles.errorButtonStyle(small: true),
              child: const Text('Cancel', style: TextStyle(fontSize: 11)),
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () => _handleFraudAction(index, 'Safe'),
          style: CardStyles.successButtonStyle(small: true),
          child: const Text('Mark Safe', style: TextStyle(fontSize: 11)),
        ),
        const SizedBox(height: 2),
        ElevatedButton(
          onPressed: () => _handleFraudAction(index, 'Escalated'),
          style: CardStyles.errorButtonStyle(small: true),
          child: const Text('Escalate', style: TextStyle(fontSize: 11)),
        ),
        const SizedBox(height: 2),
        if (row['action'] != null && row['action'].isNotEmpty)
          Text(
            row['action'],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: row['action'] == 'Safe'
                  ? CardStyles.successColor
                  : CardStyles.errorColor,
            ),
          ),
        const SizedBox(height: 2),
        ElevatedButton(
          onPressed: () => _handleEditClick(index),
          style: CardStyles.neutralButtonStyle(small: true),
          child: const Text('Edit', style: TextStyle(fontSize: 11)),
        ),
      ],
    );
  }

  Widget _buildEditField(
    TextEditingController controller, {
    bool isNumber = false,
  }) {
    return SizedBox(
      width: 120,
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        style: const TextStyle(fontSize: 13),
        decoration: CardStyles.editingInputDecoration(),
      ),
    );
  }

  Widget _buildActionButtons(int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: () => _handleFraudAction(index, 'Safe'),
          style: CardStyles.successButtonStyle(small: true),
          child: const Text('Mark Safe', style: TextStyle(fontSize: 12)),
        ),
        const SizedBox(width: 2),
        ElevatedButton(
          onPressed: () => _handleFraudAction(index, 'Escalated'),
          style: CardStyles.errorButtonStyle(small: true),
          child: const Text('Escalate', style: TextStyle(fontSize: 12)),
        ),
      ],
    );
  }

  Widget _buildEditButtons(int index, bool isEditing) {
    if (isEditing) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () => _handleSaveEdit(index),
            style: CardStyles.successButtonStyle(small: true),
            child: const Text('Save', style: TextStyle(fontSize: 12)),
          ),
          const SizedBox(width: 2),
          ElevatedButton(
            onPressed: _handleCancelEdit,
            style: CardStyles.errorButtonStyle(small: true),
            child: const Text('Cancel', style: TextStyle(fontSize: 12)),
          ),
        ],
      );
    }

    return ElevatedButton(
      onPressed: () => _handleEditClick(index),
      style: CardStyles.neutralButtonStyle(small: true),
      child: const Text('Edit', style: TextStyle(fontSize: 12)),
    );
  }

  Widget _buildAddFraudForm(bool isMobile) {
    return Column(
      children: [
        TextField(
          controller: _transactionIdController,
          decoration: CardStyles.inputDecoration(
            hintText: 'Transaction ID',
            isMobile: isMobile,
          ),
          style: isMobile
              ? CardStyles.bodyStyleMobile
              : CardStyles.bodyStyle,
        ),
        const SizedBox(height: 15),
        TextField(
          controller: _cardNumberController,
          decoration: CardStyles.inputDecoration(
            hintText: 'Card Number',
            isMobile: isMobile,
          ),
          style: isMobile
              ? CardStyles.bodyStyleMobile
              : CardStyles.bodyStyle,
        ),
        const SizedBox(height: 15),
        TextField(
          controller: _amountController,
          keyboardType: TextInputType.number,
          decoration: CardStyles.inputDecoration(
            hintText: 'Amount',
            isMobile: isMobile,
          ),
          style: isMobile
              ? CardStyles.bodyStyleMobile
              : CardStyles.bodyStyle,
        ),
        const SizedBox(height: 15),
        TextField(
          controller: _userController,
          decoration: CardStyles.inputDecoration(
            hintText: 'User',
            isMobile: isMobile,
          ),
          style: isMobile
              ? CardStyles.bodyStyleMobile
              : CardStyles.bodyStyle,
        ),
        const SizedBox(height: 15),
        TextField(
          controller: _reasonController,
          decoration: CardStyles.inputDecoration(
            hintText: 'Reason',
            isMobile: isMobile,
          ),
          style: isMobile
              ? CardStyles.bodyStyleMobile
              : CardStyles.bodyStyle,
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _handleFraudSubmit,
            style: CardStyles.primaryButtonStyle(isMobile: isMobile),
            child: Text(
              'Add Record',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: isMobile ? 13 : 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
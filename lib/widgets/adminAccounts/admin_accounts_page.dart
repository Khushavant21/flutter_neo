import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'admin_accounts_styles.dart';

class AdminAccountsPage extends StatefulWidget {
  const AdminAccountsPage({super.key});

  @override
  State<AdminAccountsPage> createState() => _AdminAccountsPageState();
}

class _AdminAccountsPageState extends State<AdminAccountsPage> {
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> accounts = [
    {
      'id': 1,
      'customerName': 'John Doe',
      'accountNumber': 'ACC001234567',
      'accountType': 'Savings',
      'balance': 25000.50,
      'walletBalance': 1200.0,
      'status': 'Active',
      'lastTransaction': '2024-01-15',
      'kycStatus': 'Verified',
    },
    {
      'id': 2,
      'customerName': 'Jane Smith',
      'accountNumber': 'ACC001234568',
      'accountType': 'Current',
      'balance': 45000.75,
      'walletBalance': 800.0,
      'status': 'Active',
      'lastTransaction': '2024-01-14',
      'kycStatus': 'Pending',
    },
    {
      'id': 3,
      'customerName': 'Mike Johnson',
      'accountNumber': 'ACC001234569',
      'accountType': 'Savings',
      'balance': 15000.25,
      'walletBalance': 500.0,
      'status': 'Frozen',
      'lastTransaction': '2024-01-10',
      'kycStatus': 'Verified',
    },
    {
      'id': 4,
      'customerName': 'Sarah Wilson',
      'accountNumber': 'ACC001234570',
      'accountType': 'Business',
      'balance': 75000.0,
      'walletBalance': 2000.0,
      'status': 'Active',
      'lastTransaction': '2024-01-16',
      'kycStatus': 'Verified',
    },
    {
      'id': 5,
      'customerName': 'Robert Brown',
      'accountNumber': 'ACC001234571',
      'accountType': 'Current',
      'balance': 500.0,
      'walletBalance': 50.0,
      'status': 'Pending',
      'lastTransaction': '2024-01-12',
      'kycStatus': 'Pending',
    },
  ];

  List<Map<String, dynamic>> filteredAccounts = [];
  String searchTerm = '';
  String statusFilter = 'All';
  String typeFilter = 'All';
  String balanceRangeFilter = 'All';
  DateTime? dateFromFilter;
  DateTime? dateToFilter;
  bool showFilters = false;
  Map<String, dynamic>? selectedAccount;
  Map<String, dynamic>? editingAccount;
  Map<String, dynamic> editFormData = {};
  bool showNewAccountForm = false;
  Map<String, dynamic> newAccountData = {
    'customerName': '',
    'accountNumber': '',
    'accountType': 'Savings',
    'balance': 0.0,
    'walletBalance': 0.0,
    'status': 'Pending',
    'lastTransaction': DateFormat('yyyy-MM-dd').format(DateTime.now()),
    'kycStatus': 'Pending',
  };

  @override
  void initState() {
    super.initState();
    filteredAccounts = List.from(accounts);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _applyFilters() {
    setState(() {
      filteredAccounts = accounts.where((account) {
        if (searchTerm.isNotEmpty) {
          final matchesSearch =
              account['customerName'].toString().toLowerCase().contains(
                searchTerm.toLowerCase(),
              ) ||
              account['accountNumber'].toString().toLowerCase().contains(
                searchTerm.toLowerCase(),
              );
          if (!matchesSearch) return false;
        }

        if (statusFilter != 'All' && account['status'] != statusFilter) {
          return false;
        }

        if (typeFilter != 'All' && account['accountType'] != typeFilter) {
          return false;
        }

        if (balanceRangeFilter != 'All') {
          final balance = account['balance'] as double;
          switch (balanceRangeFilter) {
            case '0-1000':
              if (balance < 0 || balance > 1000) return false;
              break;
            case '1000-10000':
              if (balance <= 1000 || balance > 10000) return false;
              break;
            case '10000-50000':
              if (balance <= 10000 || balance > 50000) return false;
              break;
            case '50000+':
              if (balance <= 50000) return false;
              break;
          }
        }

        if (dateFromFilter != null || dateToFilter != null) {
          final transactionDate = DateTime.parse(account['lastTransaction']);
          final fromDate = dateFromFilter ?? DateTime(1900, 1, 1);
          final toDate = dateToFilter ?? DateTime(2099, 12, 31);
          if (transactionDate.isBefore(fromDate) ||
              transactionDate.isAfter(toDate)) {
            return false;
          }
        }

        return true;
      }).toList();
    });
  }

  void _clearFilters() {
    setState(() {
      searchTerm = '';
      _searchController.clear();
      statusFilter = 'All';
      typeFilter = 'All';
      balanceRangeFilter = 'All';
      dateFromFilter = null;
      dateToFilter = null;
      _applyFilters();
    });
  }

  void _handleEdit(Map<String, dynamic> account) {
    setState(() {
      editingAccount = account;
      editFormData = Map.from(account);
    });
  }

  void _handleSaveEdit() {
    setState(() {
      final index = accounts.indexWhere(
        (acc) => acc['id'] == editingAccount!['id'],
      );
      if (index != -1) {
        accounts[index] = Map.from(editFormData);
      }
      editingAccount = null;
      editFormData = {};
      _applyFilters();
    });
  }

  void _handleCancelEdit() {
    setState(() {
      editingAccount = null;
      editFormData = {};
    });
  }

  void _handleOpenNewAccountForm() {
    setState(() {
      showNewAccountForm = true;
      newAccountData = {
        'customerName': '',
        'accountNumber': '', // ✅ EMPTY - ADMIN WILL ENTER
        'accountType': 'Savings',
        'balance': 0.0,
        'walletBalance': 0.0,
        'status': 'Pending',
        'lastTransaction': DateFormat('yyyy-MM-dd').format(DateTime.now()),
        'kycStatus': 'Pending',
      };
    });
  }

  void _handleSaveNewAccount() {
    // Validate customer name
    if (newAccountData['customerName'].toString().trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter customer name'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Validate account number
    if (newAccountData['accountNumber'].toString().trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter account number'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Check for duplicate account number
    final isDuplicate = accounts.any(
      (account) =>
          account['accountNumber'] ==
          newAccountData['accountNumber'].toString().trim(),
    );

    if (isDuplicate) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account number already exists!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      final newAccount = Map<String, dynamic>.from(newAccountData);
      newAccount['id'] = accounts.length + 1;
      accounts.add(newAccount);
      showNewAccountForm = false;
      _applyFilters();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Account created successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _handleCancelNewAccount() {
    setState(() {
      showNewAccountForm = false;
      newAccountData = {};
    });
  }

  int get totalAccounts => accounts.length;
  int get activeAccounts =>
      accounts.where((acc) => acc['status'] == 'Active').length;
  double get totalBalance =>
      accounts.fold(0.0, (sum, acc) => sum + (acc['balance'] as double));
  double get totalWalletBalance =>
      accounts.fold(0.0, (sum, acc) => sum + (acc['walletBalance'] as double));

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isSmallMobile = screenWidth < 376;

    return Scaffold(
      backgroundColor: AccountsStyles.backgroundColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(isSmallMobile),
                Padding(
                  padding: EdgeInsets.all(isMobile ? 12.0 : 16.0),
                  child: Column(
                    children: [
                      _buildSummaryCards(isMobile, isSmallMobile),
                      const SizedBox(height: 24),
                      _buildFiltersSection(isMobile, isSmallMobile),
                      const SizedBox(height: 24),
                      _buildAccountsTable(isMobile),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (selectedAccount != null &&
              editingAccount == null &&
              !showNewAccountForm)
            _buildDetailModal(isMobile),
          if (editingAccount != null) _buildEditModal(isMobile),
          if (showNewAccountForm) _buildNewAccountModal(isMobile),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isSmallMobile) {
    return Container(
      decoration: AccountsStyles.headerDecoration,
      padding: EdgeInsets.all(isSmallMobile ? 17.0 : 20.0),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Accounts & Wallets',
              style: AccountsStyles.getHeaderTitleStyle(isSmallMobile),
            ),
            const SizedBox(height: 7),
            Text(
              'Manage customer accounts, wallets, and financial operations',
              style: AccountsStyles.getHeaderSubtitleStyle(isSmallMobile),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCards(bool isMobile, bool isSmallMobile) {
    final cards = [
      {
        'label': 'Total Accounts',
        'value': totalAccounts.toString(),
        'description': '$activeAccounts active',
        'color': AccountsStyles.primaryColor,
        'icon': Icons.account_balance_wallet,
      },
      {
        'label': 'Total Balance',
        'value': '\$${NumberFormat('#,##0.00').format(totalBalance)}',
        'description': 'Account balances',
        'color': AccountsStyles.successColor,
        'icon': Icons.attach_money,
      },
      {
        'label': 'Wallet Balance',
        'value': '\$${NumberFormat('#,##0.00').format(totalWalletBalance)}',
        'description': 'Digital wallet funds',
        'color': AccountsStyles.infoColor,
        'icon': Icons.account_balance,
      },
      {
        'label': 'Pending Actions',
        'value': '5',
        'description': 'Requires attention',
        'color': AccountsStyles.warningColor,
        'icon': Icons.pending_actions,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isSmallMobile ? 1 : (isMobile ? 2 : 4),
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: isSmallMobile ? 3.0 : (isMobile ? 1.6 : 1.4),
      ),
      itemCount: cards.length,
      itemBuilder: (context, index) {
        final card = cards[index];
        return _buildSummaryCard(
          card['label'] as String,
          card['value'] as String,
          card['description'] as String,
          card['color'] as Color,
          card['icon'] as IconData,
          isSmallMobile,
        );
      },
    );
  }

  Widget _buildSummaryCard(
    String label,
    String value,
    String description,
    Color color,
    IconData icon,
    bool isSmallMobile,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 3),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(isSmallMobile ? 14.0 : 16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: isSmallMobile ? 24 : 28),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: AccountsStyles.textMuted,
                    fontSize: isSmallMobile ? 11 : 12,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: isSmallMobile ? 18 : 22,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(
                    color: const Color(0xFF868E96),
                    fontSize: isSmallMobile ? 10 : 11,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersSection(bool isMobile, bool isSmallMobile) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AccountsStyles.primaryColor, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(isSmallMobile ? 14.0 : 16.0),
      child: Column(
        children: [
          // Search Field
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search accounts, customers...',
              hintStyle: const TextStyle(
                color: Color(0xFFADB5BD),
                fontSize: 14,
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: AccountsStyles.primaryColor,
                size: 22,
              ),
              filled: true,
              fillColor: const Color(0xFFF8F9FA),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: AccountsStyles.borderColor,
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: AccountsStyles.borderColor,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: AccountsStyles.primaryColor,
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            onChanged: (value) {
              setState(() {
                searchTerm = value;
                _applyFilters();
              });
            },
          ),

          const SizedBox(height: 12),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      showFilters = !showFilters;
                    });
                  },
                  icon: Icon(
                    showFilters ? Icons.filter_list_off : Icons.filter_list,
                    size: 18,
                  ),
                  label: Text(showFilters ? 'Hide' : 'Filters'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AccountsStyles.primaryColor,
                    side: const BorderSide(
                      color: AccountsStyles.primaryColor,
                      width: 2,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download, size: 18),
                  label: const Text('Export'),
                  style: AccountsStyles.primaryButtonStyle,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _handleOpenNewAccountForm,
              icon: const Icon(Icons.add, size: 18),
              label: const Text('New Account'),
              style: AccountsStyles.primaryButtonStyle,
            ),
          ),

          // Filters Panel
          if (showFilters) ...[
            const SizedBox(height: 16),
            const Divider(thickness: 1, height: 1),
            const SizedBox(height: 16),
            _buildFiltersPanel(isMobile, isSmallMobile),
          ],
        ],
      ),
    );
  }

  Widget _buildFiltersPanel(bool isMobile, bool isSmallMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFilterDropdown(
          'Status',
          statusFilter,
          ['All', 'Active', 'Frozen', 'Pending', 'Closed'],
          (value) {
            setState(() {
              statusFilter = value!;
              _applyFilters();
            });
          },
        ),
        const SizedBox(height: 12),
        _buildFilterDropdown(
          'Account Type',
          typeFilter,
          ['All', 'Savings', 'Current', 'Business'],
          (value) {
            setState(() {
              typeFilter = value!;
              _applyFilters();
            });
          },
        ),
        const SizedBox(height: 12),
        _buildFilterDropdown(
          'Balance Range',
          balanceRangeFilter,
          ['All', '0-1000', '1000-10000', '10000-50000', '50000+'],
          (value) {
            setState(() {
              balanceRangeFilter = value!;
              _applyFilters();
            });
          },
        ),
        const SizedBox(height: 12),
        _buildDateFilter('Date From', dateFromFilter, (date) {
          setState(() {
            dateFromFilter = date;
            _applyFilters();
          });
        }),
        const SizedBox(height: 12),
        _buildDateFilter('Date To', dateToFilter, (date) {
          setState(() {
            dateToFilter = date;
            _applyFilters();
          });
        }),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _clearFilters,
            icon: const Icon(Icons.clear_all, size: 18),
            label: const Text('Clear All Filters'),
            style: AccountsStyles.secondaryButtonStyle,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterDropdown(
    String label,
    String value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: AccountsStyles.textSecondary,
          ),
        ),
        const SizedBox(height: 6),
        FormField<String>(
          initialValue: value,
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(
                    color: AccountsStyles.borderColor,
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(
                    color: AccountsStyles.borderColor,
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(
                    color: AccountsStyles.primaryColor,
                    width: 2,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
              ),
              child: DropdownButton<String>(
                value: state.value,
                items: items.map((item) {
                  return DropdownMenuItem(value: item, child: Text(item));
                }).toList(),
                onChanged: (newValue) {
                  state.didChange(newValue);
                  onChanged(newValue);
                },
                isExpanded: true,
                underline: const SizedBox(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildDateFilter(
    String label,
    DateTime? value,
    ValueChanged<DateTime?> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: AccountsStyles.textSecondary,
          ),
        ),
        const SizedBox(height: 6),
        InkWell(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: value ?? DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2099),
            );
            onChanged(date);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AccountsStyles.borderColor, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value != null
                      ? DateFormat('yyyy-MM-dd').format(value)
                      : 'Select date',
                  style: TextStyle(
                    fontSize: 14,
                    color: value != null ? Colors.black87 : Colors.grey,
                  ),
                ),
                const Icon(
                  Icons.calendar_today,
                  size: 18,
                  color: AccountsStyles.primaryColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAccountsTable(bool isMobile) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AccountsStyles.primaryColor, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF900603), Color(0xFFB30805)],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(9),
                topRight: Radius.circular(9),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'All Accounts',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    '${filteredAccounts.length} accounts',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: isMobile ? 20 : 40,
              headingRowColor: WidgetStateProperty.all(const Color(0xFFF8F9FA)),
              columns: const [
                DataColumn(
                  label: Text(
                    'Customer',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: AccountsStyles.textSecondary,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Type',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: AccountsStyles.textSecondary,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Account Balance',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: AccountsStyles.textSecondary,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Wallet Balance',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: AccountsStyles.textSecondary,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Status',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: AccountsStyles.textSecondary,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Last Transaction',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: AccountsStyles.textSecondary,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Actions',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: AccountsStyles.textSecondary,
                    ),
                  ),
                ),
              ],
              rows: filteredAccounts.asMap().entries.map((entry) {
                final index = entry.key;
                final account = entry.value;
                return DataRow(
                  color: WidgetStateProperty.all(
                    index % 2 == 0 ? Colors.white : const Color(0xFFF8F9FA),
                  ),
                  onSelectChanged: (_) {
                    setState(() {
                      selectedAccount = account;
                    });
                  },
                  cells: [
                    DataCell(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            account['customerName'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            account['accountNumber'],
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    DataCell(_buildTypeBadge(account['accountType'])),
                    DataCell(
                      Text(
                        '\$${NumberFormat('#,##0.00').format(account['balance'])}',
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                    DataCell(
                      Text(
                        '\$${NumberFormat('#,##0.00').format(account['walletBalance'])}',
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                    DataCell(_buildStatusBadge(account['status'])),
                    DataCell(
                      Text(
                        account['lastTransaction'],
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.visibility, size: 18),
                            onPressed: () {
                              setState(() {
                                selectedAccount = account;
                              });
                            },
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.blue,
                              side: const BorderSide(
                                color: Colors.blue,
                                width: 2,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              padding: const EdgeInsets.all(6),
                              minimumSize: const Size(32, 32),
                            ),
                            tooltip: 'View',
                          ),
                          const SizedBox(width: 4),
                          IconButton(
                            icon: const Icon(Icons.edit, size: 18),
                            onPressed: () => _handleEdit(account),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.green,
                              side: const BorderSide(
                                color: Colors.green,
                                width: 2,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              padding: const EdgeInsets.all(6),
                              minimumSize: const Size(32, 32),
                            ),
                            tooltip: 'Edit',
                          ),
                          const SizedBox(width: 4),
                          IconButton(
                            icon: const Icon(Icons.more_vert, size: 18),
                            onPressed: () {},
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.grey,
                              side: const BorderSide(
                                color: Colors.grey,
                                width: 2,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              padding: const EdgeInsets.all(6),
                              minimumSize: const Size(32, 32),
                            ),
                            tooltip: 'More',
                          ),
                        ],
                      ),
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

  Widget _buildTypeBadge(String type) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF007BFF),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        type,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color backgroundColor;
    Color textColor;
    Color borderColor;

    switch (status.toLowerCase()) {
      case 'active':
        backgroundColor = const Color(0xFFD4EDDA);
        textColor = const Color(0xFF155724);
        borderColor = const Color(0xFFC3E6CB);
        break;
      case 'pending':
        backgroundColor = const Color(0xFFFFF3CD);
        textColor = const Color(0xFF856404);
        borderColor = const Color(0xFFFFEAA7);
        break;
      case 'frozen':
        backgroundColor = const Color(0xFFF8D7DA);
        textColor = const Color(0xFF721C24);
        borderColor = const Color(0xFFF5C6CB);
        break;
      case 'closed':
        backgroundColor = const Color(0xFFD1ECF1);
        textColor = const Color(0xFF0C5460);
        borderColor = const Color(0xFFBEE5EB);
        break;
      default:
        backgroundColor = Colors.grey[200]!;
        textColor = Colors.grey[800]!;
        borderColor = Colors.grey[400]!;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: textColor,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildDetailModal(bool isMobile) {
    return Material(
      color: Colors.black54,
      child: Center(
        child: Container(
          width: isMobile ? MediaQuery.of(context).size.width * 0.95 : 800,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 60,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF900603),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Account Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          selectedAccount = null;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isMobile
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Customer Information',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: AccountsStyles.primaryColor,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                _buildInfoRow(
                                  'Name:',
                                  selectedAccount!['customerName'],
                                ),
                                _buildInfoRow(
                                  'Account Number:',
                                  selectedAccount!['accountNumber'],
                                ),
                                _buildInfoRow(
                                  'Account Type:',
                                  selectedAccount!['accountType'],
                                ),
                                _buildInfoRow(
                                  'KYC Status:',
                                  selectedAccount!['kycStatus'],
                                ),
                                const SizedBox(height: 24),
                                const Text(
                                  'Balance Information',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: AccountsStyles.primaryColor,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                _buildInfoRow(
                                  'Account Balance:',
                                  '\$${NumberFormat('#,##0.00').format(selectedAccount!['balance'])}',
                                ),
                                _buildInfoRow(
                                  'Wallet Balance:',
                                  '\$${NumberFormat('#,##0.00').format(selectedAccount!['walletBalance'])}',
                                ),
                                _buildInfoRow(
                                  'Status:',
                                  selectedAccount!['status'],
                                  badge: true,
                                ),
                                _buildInfoRow(
                                  'Last Transaction:',
                                  selectedAccount!['lastTransaction'],
                                ),
                              ],
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Customer Information',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: AccountsStyles.primaryColor,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      _buildInfoRow(
                                        'Name:',
                                        selectedAccount!['customerName'],
                                      ),
                                      _buildInfoRow(
                                        'Account Number:',
                                        selectedAccount!['accountNumber'],
                                      ),
                                      _buildInfoRow(
                                        'Account Type:',
                                        selectedAccount!['accountType'],
                                      ),
                                      _buildInfoRow(
                                        'KYC Status:',
                                        selectedAccount!['kycStatus'],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 32),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Balance Information',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: AccountsStyles.primaryColor,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      _buildInfoRow(
                                        'Account Balance:',
                                        '\$${NumberFormat('#,##0.00').format(selectedAccount!['balance'])}',
                                      ),
                                      _buildInfoRow(
                                        'Wallet Balance:',
                                        '\$${NumberFormat('#,##0.00').format(selectedAccount!['walletBalance'])}',
                                      ),
                                      _buildInfoRow(
                                        'Status:',
                                        selectedAccount!['status'],
                                        badge: true,
                                      ),
                                      _buildInfoRow(
                                        'Last Transaction:',
                                        selectedAccount!['lastTransaction'],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: AccountsStyles.primaryButtonStyle,
                      child: const Text('Generate Statement'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: AccountsStyles.successButtonStyle,
                      child: const Text('Manual Adjustment'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: AccountsStyles.warningButtonStyle,
                      child: const Text('Update Limits'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: AccountsStyles.dangerButtonStyle,
                      child: const Text('Freeze Account'),
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

  Widget _buildEditModal(bool isMobile) {
    return Material(
      color: Colors.black54,
      child: Center(
        child: Container(
          width: isMobile ? MediaQuery.of(context).size.width * 0.95 : 800,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 60,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF28A745), Color(0xFF20C997)],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Edit Account',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: _handleCancelEdit,
                    ),
                  ],
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isMobile
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Customer Information',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: AccountsStyles.primaryColor,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                _buildFormField(
                                  'Name:',
                                  editFormData['customerName'],
                                  (value) {
                                    setState(() {
                                      editFormData['customerName'] = value;
                                    });
                                  },
                                ),
                                _buildFormField(
                                  'Account Number:',
                                  editFormData['accountNumber'],
                                  null,
                                  enabled: false,
                                ),
                                _buildDropdownField(
                                  'Account Type:',
                                  editFormData['accountType'],
                                  ['Savings', 'Current', 'Business'],
                                  (value) {
                                    setState(() {
                                      editFormData['accountType'] = value;
                                    });
                                  },
                                ),
                                _buildDropdownField(
                                  'KYC Status:',
                                  editFormData['kycStatus'],
                                  ['Verified', 'Pending', 'Rejected'],
                                  (value) {
                                    setState(() {
                                      editFormData['kycStatus'] = value;
                                    });
                                  },
                                ),
                                const SizedBox(height: 24),
                                const Text(
                                  'Balance Information',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: AccountsStyles.primaryColor,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                _buildFormField(
                                  'Account Balance:',
                                  editFormData['balance'].toString(),
                                  (value) {
                                    setState(() {
                                      editFormData['balance'] =
                                          double.tryParse(value) ?? 0.0;
                                    });
                                  },
                                  isNumber: true,
                                ),
                                _buildFormField(
                                  'Wallet Balance:',
                                  editFormData['walletBalance'].toString(),
                                  (value) {
                                    setState(() {
                                      editFormData['walletBalance'] =
                                          double.tryParse(value) ?? 0.0;
                                    });
                                  },
                                  isNumber: true,
                                ),
                                _buildDropdownField(
                                  'Status:',
                                  editFormData['status'],
                                  ['Active', 'Pending', 'Frozen', 'Closed'],
                                  (value) {
                                    setState(() {
                                      editFormData['status'] = value;
                                    });
                                  },
                                ),
                                _buildFormField(
                                  'Last Transaction:',
                                  editFormData['lastTransaction'],
                                  null,
                                  enabled: false,
                                ),
                              ],
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Customer Information',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: AccountsStyles.primaryColor,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      _buildFormField(
                                        'Name:',
                                        editFormData['customerName'],
                                        (value) {
                                          setState(() {
                                            editFormData['customerName'] =
                                                value;
                                          });
                                        },
                                      ),
                                      _buildFormField(
                                        'Account Number:',
                                        editFormData['accountNumber'],
                                        null,
                                        enabled: false,
                                      ),
                                      _buildDropdownField(
                                        'Account Type:',
                                        editFormData['accountType'],
                                        ['Savings', 'Current', 'Business'],
                                        (value) {
                                          setState(() {
                                            editFormData['accountType'] = value;
                                          });
                                        },
                                      ),
                                      _buildDropdownField(
                                        'KYC Status:',
                                        editFormData['kycStatus'],
                                        ['Verified', 'Pending', 'Rejected'],
                                        (value) {
                                          setState(() {
                                            editFormData['kycStatus'] = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 32),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Balance Information',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: AccountsStyles.primaryColor,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      _buildFormField(
                                        'Account Balance:',
                                        editFormData['balance'].toString(),
                                        (value) {
                                          setState(() {
                                            editFormData['balance'] =
                                                double.tryParse(value) ?? 0.0;
                                          });
                                        },
                                        isNumber: true,
                                      ),
                                      _buildFormField(
                                        'Wallet Balance:',
                                        editFormData['walletBalance']
                                            .toString(),
                                        (value) {
                                          setState(() {
                                            editFormData['walletBalance'] =
                                                double.tryParse(value) ?? 0.0;
                                          });
                                        },
                                        isNumber: true,
                                      ),
                                      _buildDropdownField(
                                        'Status:',
                                        editFormData['status'],
                                        [
                                          'Active',
                                          'Pending',
                                          'Frozen',
                                          'Closed',
                                        ],
                                        (value) {
                                          setState(() {
                                            editFormData['status'] = value;
                                          });
                                        },
                                      ),
                                      _buildFormField(
                                        'Last Transaction:',
                                        editFormData['lastTransaction'],
                                        null,
                                        enabled: false,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: _handleCancelEdit,
                      style: AccountsStyles.secondaryButtonStyle,
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: _handleSaveEdit,
                      style: AccountsStyles.primaryButtonStyle,
                      child: const Text('Save Changes'),
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

  Widget _buildNewAccountModal(bool isMobile) {
    return Material(
      color: Colors.black54,
      child: Center(
        child: Container(
          width: isMobile ? MediaQuery.of(context).size.width * 0.95 : 800,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 60,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF900603), Color(0xFFB30805)],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.add_circle_outline,
                          color: Colors.white,
                          size: 24,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Create New Account',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: _handleCancelNewAccount,
                    ),
                  ],
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isMobile
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Customer Information',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: AccountsStyles.primaryColor,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                _buildNewAccountField(
                                  'Customer Name:',
                                  newAccountData['customerName'],
                                  (value) {
                                    setState(() {
                                      newAccountData['customerName'] = value;
                                    });
                                  },
                                  required: true,
                                ),
                                _buildNewAccountField(
                                  'Account Number:',
                                  newAccountData['accountNumber'],
                                  (value) {
                                    setState(() {
                                      newAccountData['accountNumber'] = value;
                                    });
                                  },
                                  required: true, // ✅ REQUIRED FIELD
                                ),
                                _buildNewAccountDropdown(
                                  'Account Type:',
                                  newAccountData['accountType'],
                                  ['Savings', 'Current', 'Business'],
                                  (value) {
                                    setState(() {
                                      newAccountData['accountType'] = value;
                                    });
                                  },
                                ),
                                _buildNewAccountDropdown(
                                  'KYC Status:',
                                  newAccountData['kycStatus'],
                                  ['Verified', 'Pending', 'Rejected'],
                                  (value) {
                                    setState(() {
                                      newAccountData['kycStatus'] = value;
                                    });
                                  },
                                ),
                                const SizedBox(height: 24),
                                const Text(
                                  'Balance Information',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: AccountsStyles.primaryColor,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                _buildNewAccountField(
                                  'Initial Account Balance:',
                                  newAccountData['balance'].toString(),
                                  (value) {
                                    setState(() {
                                      newAccountData['balance'] =
                                          double.tryParse(value) ?? 0.0;
                                    });
                                  },
                                  isNumber: true,
                                ),
                                _buildNewAccountField(
                                  'Initial Wallet Balance:',
                                  newAccountData['walletBalance'].toString(),
                                  (value) {
                                    setState(() {
                                      newAccountData['walletBalance'] =
                                          double.tryParse(value) ?? 0.0;
                                    });
                                  },
                                  isNumber: true,
                                ),
                                _buildNewAccountDropdown(
                                  'Status:',
                                  newAccountData['status'],
                                  ['Active', 'Pending', 'Frozen'],
                                  (value) {
                                    setState(() {
                                      newAccountData['status'] = value;
                                    });
                                  },
                                ),
                              ],
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Customer Information',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: AccountsStyles.primaryColor,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      _buildNewAccountField(
                                        'Customer Name:',
                                        newAccountData['customerName'],
                                        (value) {
                                          setState(() {
                                            newAccountData['customerName'] =
                                                value;
                                          });
                                        },
                                        required: true,
                                      ),
                                      _buildNewAccountField(
                                        'Account Number:',
                                        newAccountData['accountNumber'],
                                        (value) {
                                          setState(() {
                                            newAccountData['accountNumber'] =
                                                value;
                                          });
                                        },
                                        required: true, // ✅ REQUIRED FIELD
                                      ),
                                      _buildNewAccountDropdown(
                                        'Account Type:',
                                        newAccountData['accountType'],
                                        ['Savings', 'Current', 'Business'],
                                        (value) {
                                          setState(() {
                                            newAccountData['accountType'] =
                                                value;
                                          });
                                        },
                                      ),
                                      _buildNewAccountDropdown(
                                        'KYC Status:',
                                        newAccountData['kycStatus'],
                                        ['Verified', 'Pending', 'Rejected'],
                                        (value) {
                                          setState(() {
                                            newAccountData['kycStatus'] = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 32),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Balance Information',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: AccountsStyles.primaryColor,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      _buildNewAccountField(
                                        'Initial Account Balance:',
                                        newAccountData['balance'].toString(),
                                        (value) {
                                          setState(() {
                                            newAccountData['balance'] =
                                                double.tryParse(value) ?? 0.0;
                                          });
                                        },
                                        isNumber: true,
                                      ),
                                      _buildNewAccountField(
                                        'Initial Wallet Balance:',
                                        newAccountData['walletBalance']
                                            .toString(),
                                        (value) {
                                          setState(() {
                                            newAccountData['walletBalance'] =
                                                double.tryParse(value) ?? 0.0;
                                          });
                                        },
                                        isNumber: true,
                                      ),
                                      _buildNewAccountDropdown(
                                        'Status:',
                                        newAccountData['status'],
                                        ['Active', 'Pending', 'Frozen'],
                                        (value) {
                                          setState(() {
                                            newAccountData['status'] = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: _handleCancelNewAccount,
                      style: AccountsStyles.secondaryButtonStyle,
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: _handleSaveNewAccount,
                      icon: const Icon(Icons.check, size: 18),
                      label: const Text('Create Account'),
                      style: AccountsStyles.primaryButtonStyle,
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

  Widget _buildInfoRow(String label, String value, {bool badge = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AccountsStyles.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          badge
              ? _buildStatusBadge(value)
              : Text(
                  value,
                  style: const TextStyle(
                    color: AccountsStyles.textPrimary,
                    fontSize: 15,
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildFormField(
    String label,
    String value,
    ValueChanged<String>? onChanged, {
    bool enabled = true,
    bool isNumber = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AccountsStyles.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            initialValue: value,
            decoration: InputDecoration(
              filled: true,
              fillColor: enabled ? Colors.white : const Color(0xFFF8F9FA),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(
                  color: AccountsStyles.borderColor,
                  width: 2,
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(
                  color: AccountsStyles.borderColor,
                  width: 2,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(
                  color: AccountsStyles.primaryColor,
                  width: 2,
                ),
              ),
              disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(
                  color: AccountsStyles.borderColor,
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
            ),
            enabled: enabled,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField(
    String label,
    String value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AccountsStyles.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 6),
          FormField<String>(
            initialValue: value,
            builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(
                      color: AccountsStyles.borderColor,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(
                      color: AccountsStyles.borderColor,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(
                      color: AccountsStyles.primaryColor,
                      width: 2,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                ),
                child: DropdownButton<String>(
                  value: state.value,
                  items: items.map((item) {
                    return DropdownMenuItem(value: item, child: Text(item));
                  }).toList(),
                  onChanged: (newValue) {
                    state.didChange(newValue);
                    onChanged(newValue);
                  },
                  isExpanded: true,
                  underline: const SizedBox(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNewAccountField(
    String label,
    String value,
    ValueChanged<String>? onChanged, {
    bool enabled = true,
    bool isNumber = false,
    bool required = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AccountsStyles.textSecondary,
                  fontSize: 14,
                ),
              ),
              if (required)
                const Text(
                  ' *',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          TextFormField(
            initialValue: value,
            decoration: InputDecoration(
              filled: true,
              fillColor: enabled ? Colors.white : const Color(0xFFF8F9FA),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(
                  color: AccountsStyles.borderColor,
                  width: 2,
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(
                  color: AccountsStyles.borderColor,
                  width: 2,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(
                  color: AccountsStyles.primaryColor,
                  width: 2,
                ),
              ),
              disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(
                  color: AccountsStyles.borderColor,
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
            ),
            enabled: enabled,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildNewAccountDropdown(
    String label,
    String value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AccountsStyles.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 6),
          FormField<String>(
            initialValue: value,
            builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(
                      color: AccountsStyles.borderColor,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(
                      color: AccountsStyles.borderColor,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(
                      color: AccountsStyles.primaryColor,
                      width: 2,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                ),
                child: DropdownButton<String>(
                  value: state.value,
                  items: items.map((item) {
                    return DropdownMenuItem(value: item, child: Text(item));
                  }).toList(),
                  onChanged: (newValue) {
                    state.didChange(newValue);
                    onChanged(newValue);
                  },
                  isExpanded: true,
                  underline: const SizedBox(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

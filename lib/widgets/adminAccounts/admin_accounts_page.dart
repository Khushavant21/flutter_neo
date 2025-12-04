import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'admin_accounts_styles.dart';

class AdminAccountsPage extends StatefulWidget {
  const AdminAccountsPage({super.key});

  @override
  State<AdminAccountsPage> createState() => _AdminAccountsPageState();
}

class _AdminAccountsPageState extends State<AdminAccountsPage> {
  final currencyFormat = NumberFormat.currency(symbol: '\$', decimalDigits: 0);
  
  // Sample accounts data
  List<Map<String, dynamic>> accounts = [
    {
      'id': 1,
      'customerName': 'John Doe',
      'accountNumber': 'ACC001234567',
      'accountType': 'Savings',
      'balance': 25000.5,
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
  TextEditingController searchController = TextEditingController();
  
  // Filters
  String statusFilter = 'All';
  String typeFilter = 'All';
  String balanceRangeFilter = 'All';
  DateTime? dateFromFilter;
  DateTime? dateToFilter;
  bool showFilters = false;

  // Pagination
  int currentPage = 1;
  int itemsPerPage = 3;

  // Selected account for modal
  Map<String, dynamic>? selectedAccount;
  Map<String, dynamic>? editingAccount;
  
  // Edit form controllers
  late TextEditingController editNameController;
  late TextEditingController editBalanceController;
  late TextEditingController editWalletBalanceController;
  String editAccountType = 'Savings';
  String editStatus = 'Active';
  String editKycStatus = 'Verified';

  @override
  void initState() {
    super.initState();
    filteredAccounts = List.from(accounts);
    editNameController = TextEditingController();
    editBalanceController = TextEditingController();
    editWalletBalanceController = TextEditingController();
  }

  void applyFilters() {
    List<Map<String, dynamic>> filtered = List.from(accounts);

    // Search filter
    if (searchController.text.isNotEmpty) {
      filtered = filtered.where((account) {
        String customerName = account['customerName'].toString().toLowerCase();
        String accountNumber = account['accountNumber'].toString().toLowerCase();
        String searchTerm = searchController.text.toLowerCase();
        return customerName.contains(searchTerm) || accountNumber.contains(searchTerm);
      }).toList();
    }

    // Status filter
    if (statusFilter != 'All') {
      filtered = filtered.where((account) => account['status'] == statusFilter).toList();
    }

    // Type filter
    if (typeFilter != 'All') {
      filtered = filtered.where((account) => account['accountType'] == typeFilter).toList();
    }

    // Balance range filter
    if (balanceRangeFilter != 'All') {
      filtered = filtered.where((account) {
        double balance = (account['balance'] as num).toDouble();
        switch (balanceRangeFilter) {
          case '0-1000':
            return balance >= 0 && balance <= 1000;
          case '1000-10000':
            return balance > 1000 && balance <= 10000;
          case '10000-50000':
            return balance > 10000 && balance <= 50000;
          case '50000+':
            return balance > 50000;
          default:
            return true;
        }
      }).toList();
    }

    // Date range filter
    if (dateFromFilter != null || dateToFilter != null) {
      filtered = filtered.where((account) {
        DateTime transactionDate = DateTime.parse(account['lastTransaction'].toString());
        DateTime fromDate = dateFromFilter ?? DateTime(1900, 1, 1);
        DateTime toDate = dateToFilter ?? DateTime(2099, 12, 31);
        return transactionDate.isAfter(fromDate.subtract(const Duration(days: 1))) &&
            transactionDate.isBefore(toDate.add(const Duration(days: 1)));
      }).toList();
    }

    setState(() {
      filteredAccounts = filtered;
      currentPage = 1;
    });
  }

  void clearFilters() {
    setState(() {
      searchController.clear();
      statusFilter = 'All';
      typeFilter = 'All';
      balanceRangeFilter = 'All';
      dateFromFilter = null;
      dateToFilter = null;
      filteredAccounts = List.from(accounts);
      currentPage = 1;
    });
  }

  int get totalPages {
    if (filteredAccounts.isEmpty) return 1;
    return (filteredAccounts.length / itemsPerPage).ceil();
  }
  
  List<Map<String, dynamic>> get currentAccounts {
    if (filteredAccounts.isEmpty) return [];
    int startIndex = (currentPage - 1) * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;
    if (endIndex > filteredAccounts.length) endIndex = filteredAccounts.length;
    return filteredAccounts.sublist(startIndex, endIndex);
  }

  void handleEdit(Map<String, dynamic> account) {
    editNameController.text = account['customerName'].toString();
    editBalanceController.text = (account['balance'] as num).toString();
    editWalletBalanceController.text = (account['walletBalance'] as num).toString();
    editAccountType = account['accountType'].toString();
    editStatus = account['status'].toString();
    editKycStatus = account['kycStatus'].toString();
    
    setState(() {
      editingAccount = account;
    });
  }

  void handleSaveEdit() {
    setState(() {
      int index = accounts.indexWhere((acc) => acc['id'] == editingAccount!['id']);
      if (index != -1) {
        accounts[index] = {
          ...accounts[index],
          'customerName': editNameController.text,
          'balance': double.tryParse(editBalanceController.text) ?? 0.0,
          'walletBalance': double.tryParse(editWalletBalanceController.text) ?? 0.0,
          'accountType': editAccountType,
          'status': editStatus,
          'kycStatus': editKycStatus,
        };
      }
      editingAccount = null;
      applyFilters();
    });
  }

  void handleCancelEdit() {
    setState(() {
      editingAccount = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalBalance = accounts.fold(0.0, (sum, acc) => sum + (acc['balance'] as num).toDouble());
    double totalWalletBalance = accounts.fold(0.0, (sum, acc) => sum + (acc['walletBalance'] as num).toDouble());
    int activeAccounts = accounts.where((acc) => acc['status'] == 'Active').length;

    return Scaffold(
      backgroundColor: AccountsStyles.backgroundColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(),
                
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildSummaryCards(totalBalance, totalWalletBalance, activeAccounts),
                      const SizedBox(height: 24),
                      _buildFiltersSection(),
                      const SizedBox(height: 24),
                      _buildAccountsTable(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Account Detail Modal
          if (selectedAccount != null && editingAccount == null)
            _buildViewModal(),
          
          // Edit Account Modal
          if (editingAccount != null)
            _buildEditModal(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: AccountsStyles.primaryGradient,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(144, 6, 3, 0.2),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Accounts & Wallets',
            style: AccountsStyles.headerTitleStyle,
          ),
          SizedBox(height: 8),
          Text(
            'Manage customer accounts, wallets, and financial operations',
            style: AccountsStyles.headerSubtitleStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards(double totalBalance, double totalWalletBalance, int activeAccounts) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth > 900 
            ? 4 
            : constraints.maxWidth > 600 
                ? 2 
                : 1;
        
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: constraints.maxWidth > 900 
              ? 1.8 
              : constraints.maxWidth > 600 
                  ? 1.5 
                  : 2.0,
          children: [
            _buildSummaryCard(
              'Total Accounts',
              accounts.length.toString(),
              '$activeAccounts active',
              AccountsStyles.primaryColor,
            ),
            _buildSummaryCard(
              'Total Balance',
              currencyFormat.format(totalBalance),
              'Account balances',
              AccountsStyles.successColor,
            ),
            _buildSummaryCard(
              'Wallet Balance',
              currencyFormat.format(totalWalletBalance),
              'Digital wallet funds',
              AccountsStyles.infoColor,
            ),
            _buildSummaryCard(
              'Pending Actions',
              '5',
              'Requires attention',
              AccountsStyles.warningColor,
            ),
          ],
        );
      },
    );
  }

  Widget _buildSummaryCard(String label, String value, String description, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: color, width: 4)),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: AccountsStyles.cardLabelStyle,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: AccountsStyles.cardDescriptionStyle,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Column(
            children: [
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search accounts, customers...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: AccountsStyles.primaryColor, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                ),
                onChanged: (value) => applyFilters(),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          showFilters = !showFilters;
                        });
                      },
                      icon: const Icon(Icons.filter_list),
                      label: const Text('Filters'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: AccountsStyles.primaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        side: const BorderSide(color: AccountsStyles.primaryColor, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.download),
                      label: const Text('Export'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AccountsStyles.primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          if (showFilters) ...[
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            _buildFiltersPanel(),
          ],
        ],
      ),
    );
  }

  Widget _buildFiltersPanel() {
    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = constraints.maxWidth > 900 ? 3 : constraints.maxWidth > 600 ? 2 : 1;
            
            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: constraints.maxWidth > 600 ? 3 : 5,
              children: [
                _buildDropdownFilter(
                  'Status',
                  statusFilter,
                  ['All', 'Active', 'Frozen', 'Pending', 'Closed'],
                  (value) {
                    setState(() {
                      statusFilter = value!;
                      applyFilters();
                    });
                  },
                ),
                _buildDropdownFilter(
                  'Account Type',
                  typeFilter,
                  ['All', 'Savings', 'Current', 'Business'],
                  (value) {
                    setState(() {
                      typeFilter = value!;
                      applyFilters();
                    });
                  },
                ),
                _buildDropdownFilter(
                  'Balance Range',
                  balanceRangeFilter,
                  ['All', '0-1000', '1000-10000', '10000-50000', '50000+'],
                  (value) {
                    setState(() {
                      balanceRangeFilter = value!;
                      applyFilters();
                    });
                  },
                ),
                _buildDateFilter('Date From', dateFromFilter, (date) {
                  setState(() {
                    dateFromFilter = date;
                    applyFilters();
                  });
                }),
                _buildDateFilter('Date To', dateToFilter, (date) {
                  setState(() {
                    dateToFilter = date;
                    applyFilters();
                  });
                }),
              ],
            );
          },
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: clearFilters,
            style: ElevatedButton.styleFrom(
              backgroundColor: AccountsStyles.textSecondary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 2,
            ),
            child: const Text('Clear All Filters'),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownFilter(
    String label,
    String value,
    List<String> items,
    Function(String?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AccountsStyles.filterLabelStyle),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300, width: 2),
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            ),
            items: items.map((item) {
              return DropdownMenuItem(value: item, child: Text(item));
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildDateFilter(String label, DateTime? value, Function(DateTime?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AccountsStyles.filterLabelStyle),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: value ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (picked != null) {
              onChanged(picked);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300, width: 2),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value != null ? DateFormat('yyyy-MM-dd').format(value) : 'Select date',
                  style: TextStyle(
                    color: value != null ? Colors.black87 : Colors.grey,
                  ),
                ),
                const Icon(Icons.calendar_today, size: 18),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAccountsTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: AccountsStyles.primaryGradient,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('All Accounts', style: AccountsStyles.tableTitleStyle),
              ],
            ),
          ),
          
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 20,
              headingRowColor: WidgetStateProperty.all(Colors.grey.shade50),
              columns: const [
                DataColumn(label: Text('CUSTOMER')),
                DataColumn(label: Text('TYPE')),
                DataColumn(label: Text('ACCOUNT BALANCE')),
                DataColumn(label: Text('WALLET BALANCE')),
                DataColumn(label: Text('STATUS')),
                DataColumn(label: Text('LAST TRANSACTION')),
                DataColumn(label: Text('ACTIONS')),
              ],
              rows: currentAccounts.map((account) {
                return DataRow(
                  cells: [
                    DataCell(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            account['customerName'].toString(),
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            account['accountNumber'].toString(),
                            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                    DataCell(_buildTypeBadge(account['accountType'].toString())),
                    DataCell(Text('\$${(account['balance'] as num).toStringAsFixed(2)}')),
                    DataCell(Text('\$${(account['walletBalance'] as num).toStringAsFixed(2)}')),
                    DataCell(_buildStatusBadge(account['status'].toString())),
                    DataCell(Text(account['lastTransaction'].toString())),
                    DataCell(
                      Row(
                        children: [
                          _buildActionButton(
                            '👁',
                            'View',
                            Colors.blue,
                            () {
                              setState(() {
                                selectedAccount = account;
                              });
                            },
                          ),
                          const SizedBox(width: 6),
                          _buildActionButton(
                            '✏',
                            'Edit',
                            Colors.green,
                            () => handleEdit(account),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
          
          if (filteredAccounts.isNotEmpty) _buildPagination(),
        ],
      ),
    );
  }

  Widget _buildTypeBadge(String type) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        type,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bgColor, textColor, borderColor;
    
    switch (status.toLowerCase()) {
      case 'active':
        bgColor = const Color(0xFFD4EDDA);
        textColor = const Color(0xFF155724);
        borderColor = const Color(0xFFC3E6CB);
        break;
      case 'pending':
        bgColor = const Color(0xFFFFF3CD);
        textColor = const Color(0xFF856404);
        borderColor = const Color(0xFFFFEAA7);
        break;
      case 'frozen':
        bgColor = const Color(0xFFF8D7DA);
        textColor = const Color(0xFF721C24);
        borderColor = const Color(0xFFF5C6CB);
        break;
      default:
        bgColor = const Color(0xFFD1ECF1);
        textColor = const Color(0xFF0C5460);
        borderColor = const Color(0xFFBEE5EB);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildActionButton(String emoji, String label, Color color, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 2),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 12)),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPagination() {
    if (filteredAccounts.isEmpty) return const SizedBox.shrink();
    
    int startIndex = (currentPage - 1) * itemsPerPage + 1;
    int endIndex = currentPage * itemsPerPage;
    if (endIndex > filteredAccounts.length) endIndex = filteredAccounts.length;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border(top: BorderSide(color: Colors.grey.shade300, width: 2)),
      ),
      child: Column(
        children: [
          Text(
            'Showing $startIndex to $endIndex of ${filteredAccounts.length} accounts',
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: currentPage > 1
                      ? () => setState(() => currentPage--)
                      : null,
                  icon: const Icon(Icons.arrow_back),
                ),
                ...List.generate(totalPages > 10 ? 10 : totalPages, (index) {
                  int page = index + 1;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: InkWell(
                      onTap: () => setState(() => currentPage = page),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: currentPage == page
                              ? AccountsStyles.primaryColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: currentPage == page
                                ? AccountsStyles.primaryColor
                                : Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '$page',
                            style: TextStyle(
                              color: currentPage == page ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
                IconButton(
                  onPressed: currentPage < totalPages
                      ? () => setState(() => currentPage++)
                      : null,
                  icon: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    editNameController.dispose();
    editBalanceController.dispose();
    editWalletBalanceController.dispose();
    super.dispose();
  }

  // View Modal
  Widget _buildViewModal() {
    return GestureDetector(
      onTap: () => setState(() => selectedAccount = null),
      child: Container(
        color: Colors.black.withOpacity(0.6),
        child: Center(
          child: GestureDetector(
            onTap: () {}, // Prevent closing when tapping modal content
            child: Container(
              margin: const EdgeInsets.all(20),
              constraints: const BoxConstraints(maxWidth: 800),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.3),
                    blurRadius: 60,
                    offset: Offset(0, 20),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Container(
                    decoration: const BoxDecoration(
                      gradient: AccountsStyles.primaryGradient,
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
                          style: AccountsStyles.modalTitleStyle,
                        ),
                        InkWell(
                          onTap: () => setState(() => selectedAccount = null),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.close, color: Colors.white, size: 24),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Body
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Customer Information',
                                      style: AccountsStyles.sectionTitleStyle,
                                    ),
                                    const SizedBox(height: 8),
                                    const Divider(color: AccountsStyles.primaryColor, thickness: 2),
                                    const SizedBox(height: 16),
                                    _buildInfoRow('Name:', selectedAccount!['customerName'].toString()),
                                    _buildInfoRow('Account Number:', selectedAccount!['accountNumber'].toString()),
                                    _buildInfoRow('Account Type:', selectedAccount!['accountType'].toString()),
                                    _buildInfoRow('KYC Status:', selectedAccount!['kycStatus'].toString()),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 32),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Balance Information',
                                      style: AccountsStyles.sectionTitleStyle,
                                    ),
                                    const SizedBox(height: 8),
                                    const Divider(color: AccountsStyles.primaryColor, thickness: 2),
                                    const SizedBox(height: 16),
                                    _buildInfoRow('Account Balance:', '\$${(selectedAccount!['balance'] as num).toStringAsFixed(2)}'),
                                    _buildInfoRow('Wallet Balance:', '\$${(selectedAccount!['walletBalance'] as num).toStringAsFixed(2)}'),
                                    _buildInfoRow('Status:', selectedAccount!['status'].toString()),
                                    _buildInfoRow('Last Transaction:', selectedAccount!['lastTransaction'].toString()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  // Footer
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      border: const Border(top: BorderSide(color: AccountsStyles.borderColor)),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AccountsStyles.primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text('Generate Statement'),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AccountsStyles.successColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text('Manual Adjustment'),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AccountsStyles.warningColor,
                            foregroundColor: Colors.black87,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text('Update Limits'),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AccountsStyles.dangerColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text('Freeze Account'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AccountsStyles.infoLabelStyle),
          const SizedBox(height: 4),
          Text(value, style: AccountsStyles.infoValueStyle),
        ],
      ),
    );
  }

  // Edit Modal
  Widget _buildEditModal() {
    return GestureDetector(
      onTap: handleCancelEdit,
      child: Container(
        color: Colors.black.withOpacity(0.6),
        child: Center(
          child: GestureDetector(
            onTap: () {}, // Prevent closing when tapping modal content
            child: Container(
              margin: const EdgeInsets.all(20),
              constraints: const BoxConstraints(maxWidth: 800),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.3),
                    blurRadius: 60,
                    offset: Offset(0, 20),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Container(
                    decoration: const BoxDecoration(
                      gradient: AccountsStyles.successGradient,
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
                          style: AccountsStyles.modalTitleStyle,
                        ),
                        InkWell(
                          onTap: handleCancelEdit,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.close, color: Colors.white, size: 24),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Body
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Customer Information',
                                  style: AccountsStyles.sectionTitleStyle,
                                ),
                                const SizedBox(height: 8),
                                const Divider(color: AccountsStyles.primaryColor, thickness: 2),
                                const SizedBox(height: 16),
                                _buildEditField('Name:', editNameController),
                                _buildReadOnlyField('Account Number:', editingAccount!['accountNumber'].toString()),
                                _buildDropdownEditField('Account Type:', editAccountType, ['Savings', 'Current', 'Business'], (val) {
                                  setState(() => editAccountType = val!);
                                }),
                                _buildDropdownEditField('KYC Status:', editKycStatus, ['Verified', 'Pending', 'Rejected'], (val) {
                                  setState(() => editKycStatus = val!);
                                }),
                              ],
                            ),
                          ),
                          const SizedBox(width: 32),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Balance Information',
                                  style: AccountsStyles.sectionTitleStyle,
                                ),
                                const SizedBox(height: 8),
                                const Divider(color: AccountsStyles.primaryColor, thickness: 2),
                                const SizedBox(height: 16),
                                _buildEditField('Account Balance:', editBalanceController, isNumber: true),
                                _buildEditField('Wallet Balance:', editWalletBalanceController, isNumber: true),
                                _buildDropdownEditField('Status:', editStatus, ['Active', 'Pending', 'Frozen', 'Closed'], (val) {
                                  setState(() => editStatus = val!);
                                }),
                                _buildReadOnlyField('Last Transaction:', editingAccount!['lastTransaction'].toString()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  // Footer
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      border: const Border(top: BorderSide(color: AccountsStyles.borderColor)),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: handleCancelEdit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AccountsStyles.textSecondary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text('Cancel'),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: handleSaveEdit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AccountsStyles.primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text('Save Changes'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditField(String label, TextEditingController controller, {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AccountsStyles.infoLabelStyle),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AccountsStyles.borderColor, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AccountsStyles.borderColor, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AccountsStyles.primaryColor, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReadOnlyField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AccountsStyles.infoLabelStyle),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300, width: 2),
            ),
            child: Text(value, style: const TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownEditField(String label, String value, List<String> items, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AccountsStyles.infoLabelStyle),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300, width: 2),
            ),
            child: DropdownButtonFormField<String>(
              value: value,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              ),
              items: items.map((item) {
                return DropdownMenuItem(value: item, child: Text(item));
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
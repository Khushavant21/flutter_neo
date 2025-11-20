import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'user_profile_modal.dart';
import 'user_management_styles.dart';

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  State<UserManagementPage> createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  List<UserData> users = [];
  List<UserData> filteredUsers = [];
  UserData? selectedUser;
  String searchQuery = '';
  String statusFilter = 'All';
  String sortKey = 'name';
  bool sortAscending = true;
  int currentPage = 1;
  final int pageSize = 10;
  Set<int> selectedIds = {};
  final random = Random();

  @override
  void initState() {
    super.initState();
    _generateDummyUsers();
    _filterAndSortUsers();
  }

  String _generateRandomName() {
    final firstNames = [
      'Rajesh',
      'Priya',
      'Amit',
      'Sneha',
      'Vikram',
      'Anjali',
      'Rahul',
      'Pooja',
      'Karan',
      'Neha',
      'Sanjay',
      'Divya',
      'Arjun',
      'Kavya',
      'Rohan',
      'Ishita',
      'Aditya',
      'Riya',
      'Nikhil',
      'Shreya',
      'Varun',
      'Ananya',
      'Harsh',
      'Tanvi',
      'Manish',
      'Simran',
      'Gaurav',
      'Preeti',
      'Ashok',
      'Meera',
    ];
    final lastNames = [
      'Sharma',
      'Patel',
      'Kumar',
      'Singh',
      'Reddy',
      'Gupta',
      'Mehta',
      'Shah',
      'Joshi',
      'Desai',
      'Agarwal',
      'Verma',
      'Iyer',
      'Nair',
      'Kapoor',
      'Malhotra',
      'Chopra',
      'Bose',
      'Das',
      'Roy',
    ];
    return '${firstNames[random.nextInt(firstNames.length)]} ${lastNames[random.nextInt(lastNames.length)]}';
  }

  String _generateRandomEmail(String name) {
    final domain = ['gmail.com', 'yahoo.com', 'outlook.com', 'hotmail.com'];
    final cleanName = name.toLowerCase().replaceAll(' ', '.');
    return '$cleanName${random.nextInt(999)}@${domain[random.nextInt(domain.length)]}';
  }

  String _generateRandomPhone() {
    // Generate 10 digit phone number in parts to avoid overflow
    final part1 = random.nextInt(900) + 100; // 3 digits (100-999)
    final part2 = random.nextInt(900) + 100; // 3 digits (100-999)
    final part3 = random.nextInt(9000) + 1000; // 4 digits (1000-9999)
    return '+91 $part1$part2$part3';
  }

  String _generateRandomAddress() {
    final streets = [
      'MG Road',
      'Park Street',
      'Mall Road',
      'Station Road',
      'Gandhi Nagar',
      'Nehru Place',
      'Ring Road',
    ];
    final cities = [
      'Mumbai',
      'Delhi',
      'Bangalore',
      'Hyderabad',
      'Chennai',
      'Kolkata',
      'Pune',
      'Ahmedabad',
    ];
    return '${random.nextInt(999) + 1}, ${streets[random.nextInt(streets.length)]}, ${cities[random.nextInt(cities.length)]}';
  }

  void _generateDummyUsers() {
    final statusList = ['Active', 'Pending KYC', 'Suspended'];
    final accountTypes = ['Savings', 'Current', 'Salary'];

    users = List.generate(50, (i) {
      final name = _generateRandomName();
      final fatherName = _generateRandomName();
      final email = _generateRandomEmail(name);

      return UserData(
        id: i + 1,
        name: name,
        fatherName: fatherName,
        email: email,
        phone: _generateRandomPhone(),
        address: _generateRandomAddress(),
        account:
            'XXXX${random.nextInt(9000) + 1000}${random.nextInt(9000) + 1000}',
        type: accountTypes[random.nextInt(accountTypes.length)],
        balance: (random.nextDouble() * 195000) + 5000,
        status: statusList[random.nextInt(statusList.length)],
        frozen: random.nextBool(),
        lastLogin: DateTime.now().subtract(Duration(days: random.nextInt(30))),
        photo: 'https://i.pravatar.cc/150?u=${i + 1}',
        aadhaar:
            '${random.nextInt(9000) + 1000}${random.nextInt(9000) + 1000}${random.nextInt(9000) + 1000}',
        aadhaarFront:
            'https://via.placeholder.com/150?text=Aadhaar+Front+${i + 1}',
        aadhaarBack:
            'https://via.placeholder.com/150?text=Aadhaar+Back+${i + 1}',
        pan: 'ABCDE${random.nextInt(9000) + 1000}F',
        panCard: 'https://via.placeholder.com/150?text=PAN+${i + 1}',
        signature: 'https://via.placeholder.com/150?text=Signature+${i + 1}',
        documents: [
          {
            'name': 'Bank Statement',
            'url': 'https://via.placeholder.com/150?text=Statement+${i + 1}',
          },
        ],
      );
    });
  }

  void _filterAndSortUsers() {
    setState(() {
      filteredUsers = users.where((user) {
        final matchesSearch =
            user.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
            user.email.toLowerCase().contains(searchQuery.toLowerCase()) ||
            user.phone.contains(searchQuery) ||
            user.account.contains(searchQuery);
        final matchesStatus =
            statusFilter == 'All' || user.status == statusFilter;
        return matchesSearch && matchesStatus;
      }).toList();

      filteredUsers.sort((a, b) {
        dynamic aVal, bVal;
        switch (sortKey) {
          case 'name':
            aVal = a.name;
            bVal = b.name;
            break;
          case 'status':
            aVal = a.status;
            bVal = b.status;
            break;
          case 'lastLogin':
            aVal = a.lastLogin;
            bVal = b.lastLogin;
            break;
          default:
            aVal = a.name;
            bVal = b.name;
        }
        final comparison = aVal.compareTo(bVal);
        return sortAscending ? comparison : -comparison;
      });
    });
  }

  List<UserData> get pagedUsers {
    final startIndex = (currentPage - 1) * pageSize;
    final endIndex = startIndex + pageSize;
    return filteredUsers.sublist(
      startIndex,
      endIndex > filteredUsers.length ? filteredUsers.length : endIndex,
    );
  }

  int get totalPages => (filteredUsers.length / pageSize).ceil();

  void _handleSort(String key) {
    setState(() {
      if (sortKey == key) {
        sortAscending = !sortAscending;
      } else {
        sortKey = key;
        sortAscending = true;
      }
    });
    _filterAndSortUsers();
  }

  void _toggleFreeze(int userId) {
    setState(() {
      final index = users.indexWhere((u) => u.id == userId);
      if (index != -1) {
        users[index].frozen = !users[index].frozen;
      }
    });
    _filterAndSortUsers();
  }

  void _toggleStatus(int userId, String currentStatus) {
    setState(() {
      final index = users.indexWhere((u) => u.id == userId);
      if (index != -1) {
        users[index].status = currentStatus == 'Active'
            ? 'Suspended'
            : 'Active';
      }
    });
    _filterAndSortUsers();
  }

  void _toggleSelect(int id) {
    setState(() {
      if (selectedIds.contains(id)) {
        selectedIds.remove(id);
      } else {
        selectedIds.add(id);
      }
    });
  }

  void _toggleSelectAll() {
    setState(() {
      if (pagedUsers.every((u) => selectedIds.contains(u.id))) {
        for (var user in pagedUsers) {
          selectedIds.remove(user.id);
        }
      } else {
        for (var user in pagedUsers) {
          selectedIds.add(user.id);
        }
      }
    });
  }

  void _bulkFreeze() {
    setState(() {
      for (var user in users) {
        if (selectedIds.contains(user.id)) {
          user.frozen = true;
        }
      }
    });
    _filterAndSortUsers();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Frozen ${selectedIds.length} users!')),
    );
  }

  void _bulkExport() {
    final exportData = users.where((u) => selectedIds.contains(u.id)).toList();
    debugPrint('Exported: $exportData');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Exported ${exportData.length} users (check console)'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final summaryData = {
      'total': users.length,
      'active': users.where((u) => u.status == 'Active').length,
      'frozen': users.where((u) => u.frozen).length,
      'pending': users.where((u) => u.status == 'Pending KYC').length,
    };

    return Container(
      color: UserManagementStyles.backgroundColor,
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
            decoration: const BoxDecoration(
              color: UserManagementStyles.primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'User Dashboard',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Manage users, roles, and permissions from here.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 50),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // Summary Cards
                  _buildSummaryCards(summaryData),

                  const SizedBox(height: 20),

                  // Controls
                  _buildControls(isMobile),

                  const SizedBox(height: 15),

                  // Table or Mobile Cards
                  if (isMobile) _buildMobileCards() else _buildDesktopTable(),

                  const SizedBox(height: 10),

                  // Pagination
                  if (totalPages > 1) _buildPagination(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards(Map<String, int> summaryData) {
    final cards = [
      {
        'title': 'Total Users',
        'value': summaryData['total']!,
        'icon': Icons.people,
        'color': UserManagementStyles.primaryColor,
      },
      {
        'title': 'Active Users',
        'value': summaryData['active']!,
        'icon': Icons.person_add_alt_1,
        'color': UserManagementStyles.primaryColor,
      },
      {
        'title': 'Frozen Accounts',
        'value': summaryData['frozen']!,
        'icon': Icons.ac_unit,
        'color': UserManagementStyles.primaryColor,
      },
      {
        'title': 'Pending KYC',
        'value': summaryData['pending']!,
        'icon': Icons.playlist_add_check,
        'color': UserManagementStyles.primaryColor,
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        return Wrap(
          spacing: 20,
          runSpacing: 20,
          children: cards.map((card) {
            return Container(
              width: constraints.maxWidth > 768
                  ? (constraints.maxWidth - 60) / 4
                  : constraints.maxWidth > 480
                  ? (constraints.maxWidth - 20) / 2
                  : constraints.maxWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          card['title'] as String,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${card['value']}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: card['color'] as Color,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      card['icon'] as IconData,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildControls(bool isMobile) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.start,
      children: [
        // Search Field
        SizedBox(
          width: isMobile ? double.infinity : 300,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search by name, email, phone, account...',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  color: UserManagementStyles.primaryColor,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
            ),
            onChanged: (value) {
              setState(() {
                searchQuery = value;
                currentPage = 1;
              });
              _filterAndSortUsers();
            },
          ),
        ),

        // Status Filter
        SizedBox(
          width: isMobile ? double.infinity : 200,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: statusFilter,
                isExpanded: true,
                items: ['All', 'Active', 'Pending KYC', 'Suspended']
                    .map(
                      (status) => DropdownMenuItem(
                        value: status,
                        child: Text(status == 'All' ? 'All Status' : status),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    statusFilter = value!;
                    currentPage = 1;
                  });
                  _filterAndSortUsers();
                },
              ),
            ),
          ),
        ),

        // Action Buttons
        ElevatedButton.icon(
          onPressed: selectedIds.isEmpty ? null : _bulkFreeze,
          icon: const Icon(Icons.ac_unit, size: 18),
          label: const Text('Freeze'),
          style: ElevatedButton.styleFrom(
            backgroundColor: UserManagementStyles.primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        ElevatedButton.icon(
          onPressed: selectedIds.isEmpty ? null : _bulkExport,
          icon: const Icon(Icons.download, size: 18),
          label: const Text('Export'),
          style: ElevatedButton.styleFrom(
            backgroundColor: UserManagementStyles.primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(
            UserManagementStyles.primaryColor,
          ),
          columns: [
            DataColumn(
              label: Checkbox(
                value:
                    pagedUsers.isNotEmpty &&
                    pagedUsers.every((u) => selectedIds.contains(u.id)),
                onChanged: (_) => _toggleSelectAll(),
                fillColor: WidgetStateProperty.all(Colors.white),
                checkColor: UserManagementStyles.primaryColor,
              ),
            ),
            DataColumn(
              label: InkWell(
                onTap: () => _handleSort('name'),
                child: Row(
                  children: [
                    const Text(
                      'User',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      sortKey == 'name'
                          ? (sortAscending
                                ? Icons.arrow_upward
                                : Icons.arrow_downward)
                          : Icons.unfold_more,
                      color: Colors.white,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
            DataColumn(
              label: InkWell(
                onTap: () => _handleSort('status'),
                child: Row(
                  children: [
                    const Text(
                      'Status',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      sortKey == 'status'
                          ? (sortAscending
                                ? Icons.arrow_upward
                                : Icons.arrow_downward)
                          : Icons.unfold_more,
                      color: Colors.white,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
            DataColumn(
              label: InkWell(
                onTap: () => _handleSort('lastLogin'),
                child: Row(
                  children: [
                    const Text(
                      'Last Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      sortKey == 'lastLogin'
                          ? (sortAscending
                                ? Icons.arrow_upward
                                : Icons.arrow_downward)
                          : Icons.unfold_more,
                      color: Colors.white,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
            const DataColumn(
              label: Text(
                'Actions',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          rows: pagedUsers.map((user) {
            return DataRow(
              cells: [
                DataCell(
                  Checkbox(
                    value: selectedIds.contains(user.id),
                    onChanged: (_) => _toggleSelect(user.id),
                  ),
                ),
                DataCell(
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(user.photo),
                        radius: 20,
                      ),
                      const SizedBox(width: 10),
                      Text(user.name),
                    ],
                  ),
                ),
                DataCell(
                  Row(
                    children: [
                      _buildStatusBadge(user.status),
                      if (user.frozen) const SizedBox(width: 5),
                      if (user.frozen) _buildStatusBadge('Frozen'),
                    ],
                  ),
                ),
                DataCell(Text(DateFormat('dd/MM/yyyy').format(user.lastLogin))),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.visibility, size: 18),
                        onPressed: () {
                          setState(() {
                            selectedUser = user;
                          });
                          _showUserProfileModal(user);
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(width: 5),
                      ElevatedButton(
                        onPressed: () => _toggleFreeze(user.id),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: user.frozen
                              ? Colors.green
                              : Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          minimumSize: const Size(0, 0),
                        ),
                        child: Text(
                          user.frozen ? 'Unfreeze' : 'Freeze',
                          style: const TextStyle(fontSize: 11),
                        ),
                      ),
                      const SizedBox(width: 5),
                      ElevatedButton(
                        onPressed: () => _toggleStatus(user.id, user.status),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: user.status == 'Active'
                              ? Colors.amber
                              : Colors.cyan,
                          foregroundColor: user.status == 'Active'
                              ? Colors.black
                              : Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          minimumSize: const Size(0, 0),
                        ),
                        child: Text(
                          user.status == 'Active' ? 'Deactivate' : 'Activate',
                          style: const TextStyle(fontSize: 11),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildMobileCards() {
    return Column(
      children: pagedUsers.map((user) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: selectedIds.contains(user.id),
                    onChanged: (_) => _toggleSelect(user.id),
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.photo),
                    radius: 25,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      user.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildStatusBadge(user.status),
                  if (user.frozen) const SizedBox(width: 5),
                  if (user.frozen) _buildStatusBadge('Frozen'),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Last Login: ${DateFormat('dd/MM/yyyy').format(user.lastLogin)}',
                style: const TextStyle(fontSize: 13.5, color: Colors.black87),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _showUserProfileModal(user),
                    icon: const Icon(Icons.visibility, size: 14),
                    label: const Text('View'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: UserManagementStyles.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      textStyle: const TextStyle(fontSize: 12),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _toggleFreeze(user.id),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: user.frozen ? Colors.green : Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      textStyle: const TextStyle(fontSize: 12),
                    ),
                    child: Text(user.frozen ? 'Unfreeze' : 'Freeze'),
                  ),
                  ElevatedButton(
                    onPressed: () => _toggleStatus(user.id, user.status),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: user.status == 'Active'
                          ? Colors.amber
                          : Colors.cyan,
                      foregroundColor: user.status == 'Active'
                          ? Colors.black
                          : Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      textStyle: const TextStyle(fontSize: 12),
                    ),
                    child: Text(
                      user.status == 'Active' ? 'Deactivate' : 'Activate',
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color badgeColor;
    switch (status.toLowerCase().replaceAll(' ', '-')) {
      case 'active':
        badgeColor = Colors.green;
        break;
      case 'suspended':
        badgeColor = Colors.red;
        break;
      case 'frozen':
        badgeColor = Colors.grey;
        break;
      case 'pending-kyc':
        badgeColor = UserManagementStyles.primaryColor;
        break;
      default:
        badgeColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  Widget _buildPagination() {
    final pagesPerView = 2; // Show 2 page numbers at a time
    final currentPageGroup = ((currentPage - 1) / pagesPerView).floor();
    final startPage = currentPageGroup * pagesPerView + 1;
    final endPage = (startPage + pagesPerView - 1).clamp(1, totalPages);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: currentPage == 1
              ? null
              : () => setState(() => currentPage--),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: UserManagementStyles.primaryColor,
            side: const BorderSide(color: UserManagementStyles.primaryColor),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: const Text('Prev'),
        ),
        const SizedBox(width: 5),
        ...List.generate(endPage - startPage + 1, (i) => startPage + i).map((
          page,
        ) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: ElevatedButton(
              onPressed: () => setState(() => currentPage = page),
              style: ElevatedButton.styleFrom(
                backgroundColor: currentPage == page
                    ? UserManagementStyles.primaryColor
                    : Colors.white,
                foregroundColor: currentPage == page
                    ? Colors.white
                    : UserManagementStyles.primaryColor,
                side: const BorderSide(
                  color: UserManagementStyles.primaryColor,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text('$page'),
            ),
          );
        }),
        const SizedBox(width: 5),
        ElevatedButton(
          onPressed: currentPage == totalPages
              ? null
              : () => setState(() => currentPage++),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: UserManagementStyles.primaryColor,
            side: const BorderSide(color: UserManagementStyles.primaryColor),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: const Text('Next'),
        ),
      ],
    );
  }

  void _showUserProfileModal(UserData user) {
    showDialog(
      context: context,
      builder: (context) => UserProfileModal(
        user: user,
        onUpdate: (updatedUser) {
          setState(() {
            final index = users.indexWhere((u) => u.id == updatedUser.id);
            if (index != -1) {
              users[index] = updatedUser;
            }
          });
          _filterAndSortUsers();
        },
      ),
    );
  }
}

class UserData {
  final int id;
  String name;
  String fatherName;
  String email;
  String phone;
  String address;
  String account;
  String type;
  double balance;
  String status;
  bool frozen;
  DateTime lastLogin;
  String photo;
  String aadhaar;
  String aadhaarFront;
  String aadhaarBack;
  String pan;
  String panCard;
  String signature;
  List<Map<String, String>> documents;

  UserData({
    required this.id,
    required this.name,
    required this.fatherName,
    required this.email,
    required this.phone,
    required this.address,
    required this.account,
    required this.type,
    required this.balance,
    required this.status,
    required this.frozen,
    required this.lastLogin,
    required this.photo,
    required this.aadhaar,
    required this.aadhaarFront,
    required this.aadhaarBack,
    required this.pan,
    required this.panCard,
    required this.signature,
    required this.documents,
  });
}

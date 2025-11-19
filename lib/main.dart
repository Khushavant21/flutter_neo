import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ===== Import your widget pages =====
import 'splash_screen.dart';
import 'admin_login.dart';
import 'widgets/admin_sidebar.dart';
import 'widgets/admin_card/admin_card_page.dart';
import 'widgets/admin_profile/admin_profile_page.dart';
import 'widgets/admin_loan/admin_loan_page.dart';
import 'widgets/admin_setting/admin_setting_page.dart';
import 'widgets/admin_report/admin_report_page.dart';
import 'widgets/admin_dashboard/dashboard_page.dart';
import 'widgets/adminTransaction/admin_transaction_page.dart';
import 'widgets/adminMoneyTransfer/admin_money_transfer_page.dart';
import 'widgets/adminDepositManagement/admin_deposit_management_page.dart';
import 'widgets/adminComplaint/complaints_layout_screen.dart';
import 'widgets/adminInvestment/admin_investment_page.dart';
import 'widgets/adminAccounts/admin_accounts_page.dart';
import 'widgets/adminKYC/kyc_dashboard.dart';
import 'widgets/adminUser/user_management_page.dart';

// Search controller
final TextEditingController homeSearchController = TextEditingController();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NeoBank Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red, fontFamily: 'Poppins'),
      home: const SplashScreen(),
      routes: {
        '/login': (context) => const AdminLogin(),
        '/admin/': (context) => const ResponsiveAdminLayout(
          title: 'Dashboard',
          content: DashboardPage(),
        ),
        '/admin/users': (context) => const ResponsiveAdminLayout(
          title: 'Users',
          content: UserManagementPage(),
        ),
        '/admin/kyc': (context) =>
            const ResponsiveAdminLayout(title: 'KYC', content: KYCDashboard()),
        '/admin/accountsdashboard': (context) => const ResponsiveAdminLayout(
          title: 'Accounts',
          content: AdminAccountsPage(),
        ),
        '/admin/transactions': (context) => const ResponsiveAdminLayout(
          title: 'Transactions',
          content: AdminTransactionPage(),
        ),
        '/admin/moneyrequest': (context) => const ResponsiveAdminLayout(
          title: 'Money Requests',
          content: MoneyTransferRequests(),
        ),
        '/admin/depositmanagement': (context) => const ResponsiveAdminLayout(
          title: 'Deposit Management',
          content: AdminDepositManagement(),
        ),
        '/admin/investment_products': (context) => const ResponsiveAdminLayout(
          title: 'Investment Products',
          content: AdminInvestmentPage(),
        ),
        '/admin/complaints&support': (context) => const ResponsiveAdminLayout(
          title: 'Complaints & Support',
          content: ComplaintsLayoutScreen(),
        ),
        '/admin/reports': (context) => const ResponsiveAdminLayout(
          title: 'Reports',
          content: AdminReportPage(),
        ),
        '/admin/loans': (context) => const ResponsiveAdminLayout(
          title: 'Loans',
          content: AdminLoanPage(),
        ),
        '/admin/cards': (context) =>
            const ResponsiveAdminLayout(title: 'Cards', content: CardPage()),
        '/admin/settings': (context) => const ResponsiveAdminLayout(
          title: 'Settings',
          content: AdminSettingPage(),
        ),
        '/admin/adminprofile': (context) => const ResponsiveAdminLayout(
          title: 'Admin Profile',
          content: ProfilePage(),
        ),
      },
    );
  }
}

// ===== Search Result Model =====
class SearchResult {
  final String title;
  final String subtitle;
  final String route;
  final IconData icon;

  SearchResult({
    required this.title,
    required this.subtitle,
    required this.route,
    required this.icon,
  });
}

// ===== Get all searchable items =====
List<SearchResult> getAllSearchItems() {
  return [
    SearchResult(
      title: 'Dashboard',
      subtitle: 'View main dashboard',
      route: '/admin/',
      icon: Icons.dashboard,
    ),
    SearchResult(
      title: 'Users',
      subtitle: 'Manage user accounts',
      route: '/admin/users',
      icon: Icons.people,
    ),
    SearchResult(
      title: 'KYC',
      subtitle: 'Know Your Customer verification',
      route: '/admin/kyc',
      icon: Icons.verified_user,
    ),
    SearchResult(
      title: 'Accounts',
      subtitle: 'Manage accounts',
      route: '/admin/accountsdashboard',
      icon: Icons.account_balance,
    ),
    SearchResult(
      title: 'Transactions',
      subtitle: 'View all transactions',
      route: '/admin/transactions',
      icon: Icons.swap_horiz,
    ),
    SearchResult(
      title: 'Money Requests',
      subtitle: 'Manage money transfer requests',
      route: '/admin/moneyrequest',
      icon: Icons.money,
    ),
    SearchResult(
      title: 'Deposit Management',
      subtitle: 'Handle deposits',
      route: '/admin/depositmanagement',
      icon: Icons.account_balance_wallet,
    ),
    SearchResult(
      title: 'Investment Products',
      subtitle: 'Manage investment products',
      route: '/admin/investment_products',
      icon: Icons.trending_up,
    ),
    SearchResult(
      title: 'Complaints',
      subtitle: 'View complaints and support tickets',
      route: '/admin/complaints&support',
      icon: Icons.report_problem,
    ),
    SearchResult(
      title: 'Reports',
      subtitle: 'Generate and view reports',
      route: '/admin/reports',
      icon: Icons.assessment,
    ),
    SearchResult(
      title: 'Loans',
      subtitle: 'Manage loan applications',
      route: '/admin/loans',
      icon: Icons.card_giftcard,
    ),
    SearchResult(
      title: 'Cards',
      subtitle: 'Manage user cards',
      route: '/admin/cards',
      icon: Icons.credit_card,
    ),
    SearchResult(
      title: 'Settings',
      subtitle: 'Configure app settings',
      route: '/admin/settings',
      icon: Icons.settings,
    ),
    SearchResult(
      title: 'Admin Profile',
      subtitle: 'View admin profile',
      route: '/admin/adminprofile',
      icon: Icons.person,
    ),
  ];
}

// ===== Search Function =====
List<SearchResult> searchItems(String query) {
  if (query.isEmpty) return [];

  final items = getAllSearchItems();
  return items
      .where((item) =>
          item.title.toLowerCase().contains(query.toLowerCase()) ||
          item.subtitle.toLowerCase().contains(query.toLowerCase()))
      .toList();
}

// ===== Notification Model =====
class NotificationItem {
  final String title;
  final String message;
  final String time;
  final IconData icon;
  final Color iconColor;

  NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
    required this.iconColor,
  });
}

// ===== Sample Notifications =====
final List<NotificationItem> notifications = [
  NotificationItem(
    title: 'New User Registration',
    message: 'A new user has completed registration and KYC verification.',
    time: '5 min ago',
    icon: Icons.person_add,
    iconColor: Colors.green,
  ),
  NotificationItem(
    title: 'Loan Application',
    message: 'New loan application submitted.',
    time: '1 hour ago',
    icon: Icons.account_balance_wallet,
    iconColor: Colors.orange,
  ),
  NotificationItem(
    title: 'System Alert',
    message: 'Server maintenance scheduled.',
    time: '3 hours ago',
    icon: Icons.warning,
    iconColor: Color.fromARGB(255, 148, 18, 8),
  ),
];

// ===== Notification List Widget =====
Widget notificationsList() {
  return ListView.builder(
    itemCount: notifications.length,
    itemBuilder: (context, index) {
      final item = notifications[index];
      return ListTile(
        leading: CircleAvatar(
          backgroundColor: item.iconColor.withValues(alpha: 0.2),
          child: Icon(item.icon, color: item.iconColor),
        ),
        title: Text(
          item.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(item.message),
        trailing: Text(
          item.time,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      );
    },
  );
}

//
// ===== Responsive Layout Widget =====
//
class ResponsiveAdminLayout extends StatefulWidget {
  final Widget content;
  final String title;

  const ResponsiveAdminLayout({
    super.key,
    required this.content,
    this.title = 'NeoBank Admin',
  });

  @override
  State<ResponsiveAdminLayout> createState() => _ResponsiveAdminLayoutState();
}

class _ResponsiveAdminLayoutState extends State<ResponsiveAdminLayout> {
  bool showSearch = false;
  List<SearchResult> searchResults = [];

  // ===== SHOW NOTIFICATION BOTTOM SHEET (Mobile) =====
  void _showNotifications() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SizedBox(
        height: 400,
        child: Column(
          children: [
            const SizedBox(height: 12),
            const Text(
              "Notifications",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Expanded(child: notificationsList()),
          ],
        ),
      ),
    );
  }

  // ===== SHOW SEARCH RESULTS =====
  void _showSearchResults(String query) {
    setState(() {
      searchResults = searchItems(query);
    });
  }

  // ===== NAVIGATE TO SEARCH RESULT =====
  void _navigateToResult(String route) {
    Navigator.pushNamed(context, route);
    setState(() {
      showSearch = false;
      homeSearchController.clear();
      searchResults = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 800;

        // MOBILE LAYOUT
        if (isMobile) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 2,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              leading: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, color: Colors.black87),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
              title: showSearch
                  ? _mobileSearchBar()
                  : Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
              actions: [
                if (!showSearch)
                  IconButton(
                    icon: const Icon(Icons.search, color: Color.fromARGB(255, 148, 18, 8)),
                    onPressed: () {
                      setState(() => showSearch = true);
                    },
                  )
                else
                  IconButton(
                    icon: const Icon(Icons.close, color: Color.fromARGB(255, 148, 18, 8)),
                    onPressed: () {
                      setState(() {
                        showSearch = false;
                        homeSearchController.clear();
                        searchResults = [];
                      });
                    },
                  ),

                // ===== NOTIFICATION ICON =====
                Stack(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.notifications_outlined,
                        color: Colors.black87,
                      ),
                      onPressed: _showNotifications,
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 141, 17, 8),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${notifications.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            drawer: const Drawer(child: AdminSidebar()),
            body: showSearch && searchResults.isNotEmpty
                ? _buildSearchResultsList()
                : widget.content,
          );
        }
        // DESKTOP VIEW
        else {
          return Scaffold(
            body: Row(
              children: [
                const AdminSidebar(),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 250,
                              child: _desktopSearchBar(),
                            ),
                            const SizedBox(width: 12),
                            Stack(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.notifications_outlined,
                                  ),
                                  onPressed: _showNotifications,
                                ),
                                Positioned(
                                  right: 8,
                                  top: 8,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 117, 15, 8),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      '${notifications.length}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: showSearch && searchResults.isNotEmpty
                            ? _buildSearchResultsList()
                            : widget.content,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  // ===== BUILD SEARCH RESULTS LIST =====
  Widget _buildSearchResultsList() {
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final result = searchResults[index];
        return ListTile(
          leading: Icon(result.icon, color: Color.fromARGB(255, 148, 18, 8)),
          title: Text(result.title),
          subtitle: Text(result.subtitle),
          onTap: () => _navigateToResult(result.route),
        );
      },
    );
  }

  // MOBILE SEARCH BAR
  Widget _mobileSearchBar() {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.black54, size: 20),
          const SizedBox(width: 6),
          Expanded(
            child: TextField(
              controller: homeSearchController,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: "Search...",
                border: InputBorder.none,
              ),
              onChanged: _showSearchResults,
              onSubmitted: (value) {
                _showSearchResults(value);
              },
            ),
          ),
        ],
      ),
    );
  }

  // DESKTOP SEARCH BAR
  Widget _desktopSearchBar() {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.black54, size: 20),
          const SizedBox(width: 6),
          Expanded(
            child: TextField(
              controller: homeSearchController,
              decoration: const InputDecoration(
                hintText: "Search pages...",
                border: InputBorder.none,
              ),
              onChanged: _showSearchResults,
              onSubmitted: (value) {
                _showSearchResults(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
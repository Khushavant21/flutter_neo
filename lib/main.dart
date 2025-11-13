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
import 'widgets/admin_dashboard/DashboardPage.dart';
import 'widgets/adminTransaction/adminTransactionPage.dart';
import 'widgets/adminMoneyTransfer/adminMoneyTransferPage.dart';
import 'widgets/adminDepositManagement/adminDepositManagementPage.dart';
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
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NeoBank Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Poppins',
      ),
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
        '/admin/kyc': (context) => const ResponsiveAdminLayout(
          title: 'KYC',
          content: KYCDashboard(),
        ),
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
        '/admin/cards': (context) => const ResponsiveAdminLayout(
            title: 'Cards', content: CardPage()),
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
    iconColor: Colors.red,
  ),
];

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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 800;

        // MOBILE UI — This is where search toggle happens
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
                // SEARCH ICON or CLOSE BUTTON
                if (!showSearch)
                  IconButton(
                    icon: const Icon(Icons.search, color: Colors.black87),
                    onPressed: () {
                      setState(() => showSearch = true);
                    },
                  )
                else
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black87),
                    onPressed: () {
                      setState(() {
                        showSearch = false;
                        homeSearchController.clear();
                      });
                    },
                  ),

                // NOTIFICATION ICON
                Stack(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.notifications_outlined,
                          color: Colors.black87),
                      onPressed: () {},
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${notifications.length}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            drawer: const Drawer(child: AdminSidebar()),
            body: widget.content,
          );
        }

        // DESKTOP VIEW (unchanged)
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
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {},
                            ),
                            const SizedBox(width: 12),
                            Stack(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.notifications_outlined),
                                  onPressed: () {},
                                ),
                                Positioned(
                                  right: 8,
                                  top: 8,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      '${notifications.length}',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(child: widget.content),
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

  // MOBILE SEARCH BAR WIDGET
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
              onSubmitted: (value) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Searching: $value")));
              },
            ),
          ),
        ],
      ),
    );
  }
}

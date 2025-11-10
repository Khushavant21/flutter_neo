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
          content: Center(child: Text('Users Screen')),
        ),
        '/admin/kyc': (context) => const ResponsiveAdminLayout(
          title: 'KYC',
          content: Center(child: Text('KYC Screen')),
        ),
        '/admin/accountsdashboard': (context) => const ResponsiveAdminLayout(
          title: 'Accounts',
          content: Center(child: Text('Accounts Dashboard')),
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
    message: 'New loan application submitted by John Doe for \$50,000.',
    time: '1 hour ago',
    icon: Icons.account_balance_wallet,
    iconColor: Colors.orange,
  ),
  NotificationItem(
    title: 'System Alert',
    message: 'Server maintenance scheduled for tonight at 2:00 AM.',
    time: '3 hours ago',
    icon: Icons.warning,
    iconColor: Colors.red,
  ),
];

//
// ===== Responsive Layout Widget =====
//
class ResponsiveAdminLayout extends StatelessWidget {
  final Widget content;
  final String title;
  const ResponsiveAdminLayout({
    super.key,
    required this.content,
    this.title = 'NeoBank Admin',
  });

  // Search Dialog
  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          padding: const EdgeInsets.all(20),
          constraints: const BoxConstraints(maxWidth: 500),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Icon(Icons.search, color: Colors.black54),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: 'Search users, transactions, reports...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.black38),
                      ),
                      onSubmitted: (value) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Searching for: $value')),
                        );
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black54),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Recent Searches',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _buildSearchItem(context, 'User Management', Icons.person),
              _buildSearchItem(context, 'Transaction History', Icons.receipt),
              _buildSearchItem(context, 'Loan Applications', Icons.money),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchItem(BuildContext context, String text, IconData icon) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Navigating to: $text')),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(icon, size: 18, color: Colors.black54),
            const SizedBox(width: 12),
            Text(text, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  // Notification Panel
  void _showNotificationPanel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade200),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Notifications',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Marked all as read')),
                        );
                      },
                      child: const Text('Mark all as read'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    return InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Opened: ${notification.title}')),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey.shade200),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: notification.iconColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                notification.icon,
                                color: notification.iconColor,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    notification.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    notification.message,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    notification.time,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 800;
        if (isMobile) {
          return Scaffold(
            appBar: AppBar(
              elevation: 2,
              shadowColor: Colors.black.withOpacity(0.1),
              title: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  letterSpacing: 0.3,
                ),
              ),
              backgroundColor: Colors.white,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              centerTitle: false,
              leadingWidth: 56,
              leading: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, color: Colors.black87, size: 24),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  padding: const EdgeInsets.all(16),
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.black87, size: 24),
                  onPressed: () => _showSearchDialog(context),
                  padding: const EdgeInsets.all(12),
                ),
                Stack(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.notifications_outlined, color: Colors.black87, size: 24),
                      onPressed: () => _showNotificationPanel(context),
                      padding: const EdgeInsets.all(12),
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 158, 26, 16),
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${notifications.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
              ],
            ),
            drawer: const Drawer(child: AdminSidebar()),
            body: SafeArea(
              top: false,
              child: content,
            ),
          );
        } else {
          return Scaffold(
            body: Row(
              children: [
                const AdminSidebar(),
                Expanded(
                  child: Column(
                    children: [
                      // Top bar with search and notification for desktop
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
                              icon: const Icon(Icons.search, color: Colors.black87, size: 24),
                              onPressed: () => _showSearchDialog(context),
                            ),
                            const SizedBox(width: 12),
                            Stack(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.notifications_outlined, color: Colors.black87, size: 24),
                                  onPressed: () => _showNotificationPanel(context),
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
                                    constraints: const BoxConstraints(
                                      minWidth: 16,
                                      minHeight: 16,
                                    ),
                                    child: Text(
                                      '${notifications.length}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SafeArea(child: content),
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
}
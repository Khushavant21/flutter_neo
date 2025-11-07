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
      // ✅ Start with SplashScreen
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
          content: Center(child: Text('Transactions Screen')),
        ),
        '/admin/moneyrequest': (context) => const ResponsiveAdminLayout(
          title: 'Money Requests',
          content: Center(child: Text('Money Transfer Requests')),
        ),
        '/admin/depositmanagement': (context) => const ResponsiveAdminLayout(
          title: 'Deposit Management',
          content: Center(child: Text('Deposit Management')),
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
                  onPressed: () {
                    // Handle search action
                    print('Search clicked');
                  },
                  padding: const EdgeInsets.all(12),
                ),
                Stack(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.notifications_outlined, color: Colors.black87, size: 24),
                      onPressed: () {
                        // Handle notification action
                        print('Notification clicked');
                      },
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
                        child: const Text(
                          '3',
                          style: TextStyle(
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
                              onPressed: () {
                                // Handle search action
                                print('Search clicked');
                              },
                            ),
                            const SizedBox(width: 12),
                            Stack(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.notifications_outlined, color: Colors.black87, size: 24),
                                  onPressed: () {
                                    // Handle notification action
                                    print('Notification clicked');
                                  },
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
                                    child: const Text(
                                      '3',
                                      style: TextStyle(
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
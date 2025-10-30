import 'package:flutter/material.dart';
import 'widgets/admin_top_navbar.dart';
import 'widgets/admin_card/admin_card_page.dart';
import 'widgets/admin_profile/admin_profile_page.dart';
import 'widgets/admin_loan/admin_loan_page.dart';
import 'widgets/admin_setting/admin_setting_page.dart';
import 'widgets/admin_report/admin_report_page.dart';
import 'widgets/admin_dashboard/admin_dashboard_page.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/admin/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/admin/': (context) => const DashboardPage(),
        '/admin/users': (context) => const UsersScreen(),
        '/admin/kyc': (context) => const KYCScreen(),
        '/admin/accountsdashboard': (context) => const AccountsScreen(),
        '/admin/transactions': (context) => const TransactionsScreen(),
        '/admin/moneyrequest': (context) => const MoneyRequestScreen(),
        '/admin/depositmanagement': (context) => const DepositScreen(),
        '/admin/investment_products': (context) => const InvestmentScreen(),
        '/admin/complaints': (context) => const ComplaintsScreen(),
        '/admin/reports': (context) => const AdminReportPage(),
        '/admin/loans': (context) => const AdminLoanPage(),
        '/admin/cards': (context) => const CardPage(),
        '/admin/settings': (context) => const AdminSettingPage(),
        '/admin/adminprofile': (context) => const ProfilePage(),
        '/admin/adminsettings': (context) => const AdminSettingPage(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const TopNavbar(),
          Expanded(
            child: Center(
              child: Text(
                'Welcome to NeoBank Admin',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Placeholder screens
class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: [
            const TopNavbar(),
            Expanded(
              child: Center(
                child: Text(
                  'Users Screen',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
          ],
        ),
      );
}

class KYCScreen extends StatelessWidget {
  const KYCScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: [
            const TopNavbar(),
            Expanded(
              child: Center(
                child: Text(
                  'KYC Screen',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
          ],
        ),
      );
}

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: [
            const TopNavbar(),
            Expanded(
              child: Center(
                child: Text(
                  'Accounts & Wallets Screen',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
          ],
        ),
      );
}

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: [
            const TopNavbar(),
            Expanded(
              child: Center(
                child: Text(
                  'Transactions Screen',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
          ],
        ),
      );
}

class MoneyRequestScreen extends StatelessWidget {
  const MoneyRequestScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: [
            const TopNavbar(),
            Expanded(
              child: Center(
                child: Text(
                  'Money Transfer Request Screen',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
          ],
        ),
      );
}

class DepositScreen extends StatelessWidget {
  const DepositScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: [
            const TopNavbar(),
            Expanded(
              child: Center(
                child: Text(
                  'Deposit Management Screen',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
          ],
        ),
      );
}

class InvestmentScreen extends StatelessWidget {
  const InvestmentScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: [
            const TopNavbar(),
            Expanded(
              child: Center(
                child: Text(
                  'Investment Products Screen',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
          ],
        ),
      );
}

class ComplaintsScreen extends StatelessWidget {
  const ComplaintsScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: [
            const TopNavbar(),
            Expanded(
              child: Center(
                child: Text(
                  'Complaints & Support Screen',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
          ],
        ),
      );
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: [
            const TopNavbar(),
            Expanded(
              child: Center(
                child: Text(
                  'Settings Screen',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
          ],
        ),
      );
}
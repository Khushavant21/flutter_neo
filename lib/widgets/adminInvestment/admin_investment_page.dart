import 'package:flutter/material.dart';
// Import your individual investment screens
import 'api_keys_integrations.dart';
import 'services_merchant.dart';
import 'investment_panel.dart';
import 'portfolio_reports.dart';
import 'product_catalog_screen.dart';
import 'subscriptions_screen.dart';

class AdminInvestmentPage extends StatefulWidget {
  const AdminInvestmentPage({super.key});

  @override
  State<AdminInvestmentPage> createState() => _AdminInvestmentPageState();
}

class _AdminInvestmentPageState extends State<AdminInvestmentPage> {
  int _selectedIndex = 0; // Start with Investment Panel (Dashboard)

  void _navigateToTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Just show the content directly without tabs
        return _buildContent();
      },
    );
  }

  Widget _buildContent() {
    // Return the actual screen based on selected tab
    switch (_selectedIndex) {
      case 0:
        // Investment Panel with navigation callback
        return InvestmentPanel(
          onNavigateToTab: _navigateToTab,
        );
      case 1:
        return const APIKeysIntegrationsScreen();
      case 2:
        return const PortfolioReports();
      case 3:
        return const ProductCatalogScreen();
      case 4:
        return const ServicesMerchantScreen();
      case 5:
        return const SubscriptionsScreen();
      default:
        return Center(
          child: Text(
            'Select a tab',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        );
    }
  }
}
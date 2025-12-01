import 'package:flutter/material.dart';

// Import pages
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
  int _selectedIndex = 0;

  void _navigateToTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handleBackPress,
      child: Navigator(
        pages: [
          MaterialPage(child: InvestmentPanel(onNavigateToTab: _navigateToTab)),

          // Push only when switching pages
          if (_selectedIndex == 1)
            const MaterialPage(child: APIKeysIntegrationsScreen()),

          if (_selectedIndex == 2)
            const MaterialPage(child: PortfolioReports()),

          if (_selectedIndex == 3)
            const MaterialPage(child: ProductCatalogScreen()),

          if (_selectedIndex == 4)
            const MaterialPage(child: ServicesMerchantScreen()),

          if (_selectedIndex == 5)
            const MaterialPage(child: SubscriptionsScreen()),
        ],
        onPopPage: (route, result) {
          if (!route.didPop(result)) return false;

          // When user presses back → go to previous tab
          setState(() {
            _selectedIndex = 0;
          });

          return true;
        },
      ),
    );
  }

  /// ⭐ Android Back Button Handler
  Future<bool> _handleBackPress() async {
    if (_selectedIndex != 0) {
      setState(() {
        _selectedIndex = 0;
      });
      return false; // prevent closing app
    }
    return true; // exit screen
  }
}

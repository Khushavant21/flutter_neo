import 'package:flutter/material.dart';
// Import your individual investment screens
import 'api_keys_integrations.dart';
import 'services_merchant.dart';
import 'investment_panel.dart';
import 'portfolio_reports.dart';
import 'product_catalog_screen.dart';
import 'subscriptions_screen.dart';

class AdminInvestmentPage extends StatefulWidget {
  const AdminInvestmentPage({Key? key}) : super(key: key);

  @override
  State<AdminInvestmentPage> createState() => _AdminInvestmentPageState();
}

class _AdminInvestmentPageState extends State<AdminInvestmentPage> {
  int _selectedIndex = 0;

  final List<InvestmentTab> _tabs = [
    InvestmentTab(
      title: 'API Keys & Integrations',
      icon: Icons.key,
    ),
    InvestmentTab(
      title: 'Investment Panel',
      icon: Icons.dashboard,
    ),
    InvestmentTab(
      title: 'Portfolio Reports',
      icon: Icons.assessment,
    ),
    InvestmentTab(
      title: 'Product Catalog',
      icon: Icons.inventory,
    ),
    InvestmentTab(
      title: 'Services Merchant',
      icon: Icons.storefront,
    ),
    InvestmentTab(
      title: 'Subscriptions',
      icon: Icons.subscriptions,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 800;

        if (isMobile) {
          return Column(
            children: [
              // Mobile tabs as horizontal scrollable list
              Container(
                height: 50,
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
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _tabs.length,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemBuilder: (context, index) {
                    return _buildMobileTab(index);
                  },
                ),
              ),
              Expanded(
                child: _buildContent(),
              ),
            ],
          );
        } else {
          return Row(
            children: [
              // Desktop sidebar
              Container(
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(2, 0),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'Investment Products',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _tabs.length,
                        itemBuilder: (context, index) {
                          return _buildDesktopTab(index);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _buildContent(),
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildMobileTab(int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF900603) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            _tabs[index].title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopTab(int index) {
    bool isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF900603).withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Color(0xFF900603) : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              _tabs[index].icon,
              color: isSelected ? Color(0xFF900603) : Colors.black54,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _tabs[index].title,
                style: TextStyle(
                  color: isSelected ? Color(0xFF900603) : Colors.black87,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    // Return the actual screen based on selected tab
    switch (_selectedIndex) {
      case 0:
        return const APIKeysIntegrationsScreen();
      case 1:
        return const InvestmentPanel();
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

class InvestmentTab {
  final String title;
  final IconData icon;

  InvestmentTab({
    required this.title,
    required this.icon,
  });
}
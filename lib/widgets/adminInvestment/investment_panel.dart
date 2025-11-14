import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InvestmentPanel extends StatefulWidget {
  final Function(int)? onNavigateToTab; // Add callback
  
  const InvestmentPanel({
    super.key,
    this.onNavigateToTab,
  });

  @override
  State<InvestmentPanel> createState() => _InvestmentPanelState();
}

class _InvestmentPanelState extends State<InvestmentPanel> {
  final List<Map<String, dynamic>> pages = [
    {
      "key": "catalog",
      "title": "Product Catalog",
      "icon": FontAwesomeIcons.boxOpen,
      "tabIndex": 3, // Maps to ProductCatalogScreen
      "description": "Manage investment products and offerings",
    },
    {
      "key": "subscriptions",
      "title": "Subscriptions/Redemptions",
      "icon": FontAwesomeIcons.exchangeAlt,
      "tabIndex": 5, // Maps to SubscriptionsScreen
      "description": "Handle subscription and redemption requests",
    },
    {
      "key": "reports",
      "title": "Portfolio Reports",
      "icon": FontAwesomeIcons.chartBar,
      "tabIndex": 2, // Maps to PortfolioReports
      "description": "View and export portfolio analytics",
    },
    {
      "key": "services",
      "title": "Services & Merchant",
      "icon": FontAwesomeIcons.cog,
      "tabIndex": 4, // Maps to ServicesMerchantScreen
      "description": "Manage merchant integrations",
    },
    {
      "key": "apikeys",
      "title": "API Keys & Integrations",
      "icon": FontAwesomeIcons.key,
      "tabIndex": 1, // Maps to APIKeysIntegrationsScreen
      "description": "Configure API access and integrations",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Investment Management",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF900603),
        elevation: 4,
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),

          child: SingleChildScrollView(
            child: LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = 2;

                if (constraints.maxWidth > 1200) {
                  crossAxisCount = 4;
                } else if (constraints.maxWidth > 800) {
                  crossAxisCount = 3;
                } else if (constraints.maxWidth < 600) {
                  crossAxisCount = 1;
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: pages.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: isMobile ? 1.1 : 1.2,
                  ),
                  itemBuilder: (context, index) {
                    return _buildCard(pages[index], isMobile);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(Map<String, dynamic> page, bool isMobile) {
    return InkWell(
      onTap: () {
        // Use callback to navigate to the correct tab
        if (widget.onNavigateToTab != null) {
          widget.onNavigateToTab!(page["tabIndex"]);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: const Border(
            top: BorderSide(color: Color(0xFF900603), width: 3),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: isMobile ? 50 : 60,
              height: isMobile ? 50 : 60,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFF900603), Color(0xFFB00804)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Icon(
                page["icon"],
                color: Colors.white,
                size: isMobile ? 22 : 26,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              page["title"],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 15 : 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF333333),
              ),
            ),

            const SizedBox(height: 6),

            Text(
              page["description"],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 12 : 13,
                color: Colors.grey[700],
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
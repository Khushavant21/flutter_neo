import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InvestmentPanel extends StatefulWidget {
  final Function(int)? onNavigateToTab;
  
  const InvestmentPanel({super.key, this.onNavigateToTab});

  @override
  State<InvestmentPanel> createState() => _InvestmentPanelState();
}

class _InvestmentPanelState extends State<InvestmentPanel> {
  final List<Map<String, dynamic>> pages = [
    {
      "key": "apikeys",
      "title": "API Keys & Integrations",
      "icon": FontAwesomeIcons.key,
      "tabIndex": 1, // Index in parent tabs
      "description": "Configure API access and integrations",
    },
    {
      "key": "reports",
      "title": "Portfolio Reports",
      "icon": FontAwesomeIcons.chartBar,
      "tabIndex": 2, // Index in parent tabs
      "description": "View and export portfolio analytics",
    },
    {
      "key": "catalog",
      "title": "Product Catalog",
      "icon": FontAwesomeIcons.boxOpen,
      "tabIndex": 3, // Index in parent tabs
      "description": "Manage investment products and offerings",
    },
    {
      "key": "services",
      "title": "Services & Merchant",
      "icon": FontAwesomeIcons.gear,
      "tabIndex": 4, // Index in parent tabs
      "description": "Manage merchant integrations",
    },
    {
      "key": "subscriptions",
      "title": "Subscriptions/Redemptions",
      "icon": FontAwesomeIcons.rightLeft,
      "tabIndex": 5, // Index in parent tabs
      "description": "Handle subscription and redemption requests",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      color: const Color(0xFFF8F9FA),
      child: Column(
        children: [
          // ====== Header Section ======
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF900603), Color(0xFFB00804)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Manage Investments & Integrations",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "Access product, reports, and API tools easily.",
                  style: TextStyle(color: Color(0xFFF0F0F0), fontSize: 13),
                ),
              ],
            ),
          ),

          // ====== Cards Section ======
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  int crossAxisCount = 2;

                  if (width > 1200) {
                    crossAxisCount = 4;
                  } else if (width > 800) {
                    crossAxisCount = 3;
                  } else if (width < 600) {
                    crossAxisCount = 1;
                  }

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: isMobile ? 1.2 : 1.1,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: pages.length,
                    itemBuilder: (context, index) {
                      final page = pages[index];
                      return _buildCard(page, isMobile);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(Map<String, dynamic> page, bool isMobile) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Navigate to the specific tab in parent
          if (widget.onNavigateToTab != null) {
            widget.onNavigateToTab!(page["tabIndex"]);
          }
        },
        borderRadius: BorderRadius.circular(12),
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
                color: Colors.black.withValues(alpha: 0.08),
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
      ),
    );
  }
}
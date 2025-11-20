import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../styles/kyc_styles.dart';

class InvestmentPanel extends StatefulWidget {
  final Function(int)? onNavigateToTab;

  const InvestmentPanel({super.key, this.onNavigateToTab});

  @override
  State<InvestmentPanel> createState() => _InvestmentPanelState();
}

class _InvestmentPanelState extends State<InvestmentPanel> {
  final List<Map<String, dynamic>> pages = [
    {
      "title": "Product Catalog",
      "description": "Manage investment products and offerings",
      "icon": FontAwesomeIcons.boxOpen,
      "tabIndex": 3,
    },
    {
      "title": "Subscriptions / Redemptions",
      "description": "Handle subscription and redemption requests",
      "icon": FontAwesomeIcons.rightLeft,
      "tabIndex": 5,
    },
    {
      "title": "Portfolio Reports",
      "description": "View and export portfolio analytics",
      "icon": FontAwesomeIcons.chartBar,
      "tabIndex": 2,
    },
    {
      "title": "Services & Merchant",
      "description": "Manage merchant integrations",
      "icon": FontAwesomeIcons.gear,
      "tabIndex": 4,
    },
    {
      "title": "API Keys & Integrations",
      "description": "Configure API access and integrations",
      "icon": FontAwesomeIcons.key,
      "tabIndex": 1,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KYCColors.background,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: _buildCardsGrid(),
            ),
          ),
        ],
      ),
    );
  }

  // HEADER
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 22, 16, 20),
      decoration: const BoxDecoration(color: KYCColors.primary),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Investment Management",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 6),
            Text(
              "Investment management with Neo",
              style: TextStyle(fontSize: 15, color: Color(0xFFF0F0F0)),
            ),
          ],
        ),
      ),
    );
  }

  // GRID
  Widget _buildCardsGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        int count = constraints.maxWidth > 900
            ? 3
            : constraints.maxWidth > 600
            ? 2
            : 1;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: pages.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: count,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.25,
          ),
          itemBuilder: (context, index) {
            return _buildFeatureCard(pages[index]);
          },
        );
      },
    );
  }

  // CARD
  Widget _buildFeatureCard(Map<String, dynamic> data) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          if (widget.onNavigateToTab != null) {
            widget.onNavigateToTab!(data["tabIndex"]);
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ICON
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: KYCColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(data["icon"], color: Colors.white, size: 22),
              ),

              const SizedBox(height: 12),

              Text(
                data["title"],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              Text(
                data["description"],
                style: const TextStyle(
                  fontSize: 13,
                  color: KYCColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

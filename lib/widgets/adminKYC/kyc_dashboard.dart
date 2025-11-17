import 'package:flutter/material.dart';
import '../../styles/kyc_styles.dart';
import 'review_kyc.dart';
import 'review_transactions.dart';
import 'view_alerts.dart' hide KYCColors;
import 'transactions.dart' hide KYCColors;

class KYCDashboard extends StatefulWidget {
  const KYCDashboard({super.key});

  @override
  State<KYCDashboard> createState() => _KYCDashboardState();
}

class _KYCDashboardState extends State<KYCDashboard> {
  final List<Map<String, dynamic>> transactions = [
    {
      'id': 'TXN001',
      'type': 'High Value',
      'amount': '\$30,000',
      'status': 'pending',
    },
    {
      'id': 'TXN002',
      'type': 'Structuring',
      'amount': '\$25,000',
      'status': 'flagged',
    },
    {
      'id': 'TXN003',
      'type': 'Offshore',
      'amount': '\$35,000',
      'status': 'pending',
    },
  ];

  final List<Map<String, dynamic>> alerts = [
    {
      'id': 1,
      'text': 'AML compliance check failed for 3 users',
      'time': '2 hours ago',
    },
    {
      'id': 2,
      'text': 'High transaction volume detected',
      'time': '4 hours ago',
    },
    {
      'id': 3,
      'text': 'Daily backup completed successfully',
      'time': '6 hours ago',
    },
  ];

  // Navigation handler
  void _navigateToPage(String route) {
    Widget? page;

    switch (route) {
      case '/review-kyc':
        page = const ReviewKYC();
        break;
      case '/review-transactions':
        page = const ReviewTransactions();
        break;
      case '/view-alerts':
        page = const ViewAlerts();
        break;
      case '/transactions':
        page = const Transactions();
        break;
    }

    if (page != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => page!));
    }
  }

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
              child: Column(
                children: [
                  _buildSummaryCards(),
                  const SizedBox(height: 16),
                  _buildTransactionsAndAlerts(),
                  const SizedBox(height: 16),
                  _buildComplianceOverview(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
      decoration: const BoxDecoration(color: KYCColors.primary),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'KYC Dashboard',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Monitor and manage compliance operations',
              style: TextStyle(fontSize: 15, color: Color(0xFFF0F0F0)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCards() {
    final cards = [
      {
        'title': 'KYC Approvals',
        'text': 'Pending Review',
        'btn': 'Review KYC',
        'route': '/review-kyc',
        'icon': Icons.check_circle,
      },
      {
        'title': 'KYC History',
        'text': 'History list',
        'btn': 'Review History',
        'route': '/review-transactions',
        'icon': Icons.history,
      },
      {
        'title': 'System Alerts',
        'text': 'Requires Attention',
        'btn': 'View Alerts',
        'route': '/view-alerts',
        'icon': Icons.notifications,
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth > 900
            ? 3
            : constraints.maxWidth > 600
            ? 2
            : 1;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.3,
          ),
          itemCount: cards.length,
          itemBuilder: (context, index) {
            final card = cards[index];
            return _buildSummaryCard(
              title: card['title'] as String,
              text: card['text'] as String,
              buttonText: card['btn'] as String,
              route: card['route'] as String,
              icon: card['icon'] as IconData,
            );
          },
        );
      },
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String text,
    required String buttonText,
    required String route,
    required IconData icon,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () => _navigateToPage(route),
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: KYCColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                '0',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 13,
                  color: KYCColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => _navigateToPage(route),
                style: ElevatedButton.styleFrom(
                  backgroundColor: KYCColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Text(buttonText, style: const TextStyle(fontSize: 13)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionsAndAlerts() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 768) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildTransactionsCard()),
              const SizedBox(width: 16),
              Expanded(child: _buildAlertsCard()),
            ],
          );
        } else {
          return Column(
            children: [
              _buildTransactionsCard(),
              const SizedBox(height: 16),
              _buildAlertsCard(),
            ],
          );
        }
      },
    );
  }

  Widget _buildTransactionsCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Transactions',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                OutlinedButton(
                  onPressed: () => _navigateToPage('/transactions'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: KYCColors.primary,
                    side: const BorderSide(color: KYCColors.primary),
                  ),
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...transactions.map((txn) => _buildTransactionItem(txn)),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> txn) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  txn['id'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  txn['type'],
                  style: const TextStyle(
                    fontSize: 12,
                    color: KYCColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: KYCColors.background,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  txn['amount'],
                  style: const TextStyle(fontSize: 13),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: txn['status'] == 'pending'
                      ? Colors.grey[800]
                      : KYCColors.warning,
                  foregroundColor: txn['status'] == 'pending'
                      ? Colors.white
                      : Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                child: Text(txn['status'] == 'pending' ? 'Monitor' : 'Review'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAlertsCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'System Alerts',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                OutlinedButton(
                  onPressed: () => _navigateToPage('/view-alerts'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: KYCColors.primary,
                    side: const BorderSide(color: KYCColors.primary),
                  ),
                  child: const Text('Review Now'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...alerts.map((alert) => _buildAlertItem(alert)),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertItem(Map<String, dynamic> alert) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('⚠️ ', style: TextStyle(fontSize: 16)),
                    Expanded(
                      child: Text(
                        alert['text'],
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  alert['time'],
                  style: const TextStyle(
                    fontSize: 12,
                    color: KYCColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () => _navigateToPage('/view-alerts'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            child: const Text('View Reports'),
          ),
        ],
      ),
    );
  }

  Widget _buildComplianceOverview() {
    final items = [
      {'text': 'Total Submissions', 'icon': Icons.swap_horiz},
      {'text': 'Approval Rate', 'icon': Icons.check_circle},
      {'text': 'Pending Review', 'icon': Icons.history},
      {'text': 'Active Alerts', 'icon': Icons.security},
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth > 900
            ? 4
            : constraints.maxWidth > 600
            ? 2
            : 1;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 2,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      item['icon'] as IconData,
                      size: 32,
                      color: KYCColors.primary,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '0',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['text'] as String,
                      style: const TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

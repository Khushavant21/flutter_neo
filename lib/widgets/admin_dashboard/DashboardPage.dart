// lib/widgets/dashboard_page.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../admin_dashboard/admin_dashboard_styles.dart';
// import '../admin_top_navbar.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DashboardColors.background,
      body: Column(
        children: [
          // const TopNavbar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Red Header Banner
                  _buildRedHeader(),
                  
                  // Main Content with Padding
                  Padding(
                    padding: DashboardStyles.getContainerPadding(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Welcome Text
                        _buildWelcomeText(),
                        const SizedBox(height: DashboardStyles.spacingMd),
                        
                        // NeoBank Statistics Cards (Active Users, Pending KYCs, Daily Transactions)
                        _buildNeoBankStatsGrid(),
                        const SizedBox(height: DashboardStyles.spacingXl),
                        
                        // Quick Actions (KYC Approvals, Transaction Reviews, Loan Applications)
                        _buildQuickActions(),
                        const SizedBox(height: DashboardStyles.spacingXl),
                        
                        // Bottom Section (Recent Transactions + System Alerts)
                        _buildNeoBankBottomSection(),
                        const SizedBox(height: DashboardStyles.spacingXl),
                        
                        // Original Statistics Cards
                        _buildStatisticsCards(),
                        const SizedBox(height: DashboardStyles.spacingLg),
                        
                        // Recent Activity & Quick Actions
                        _buildBottomSection(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================
  // Red Header Banner
  // ============================================
  
  Widget _buildRedHeader() {
    return Container(
      width: double.infinity,
      padding: DashboardStyles.getHeaderPadding(context),
      decoration: DashboardStyles.headerDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome to NeoBank Dashboard !!',
            style: DashboardStyles.headerTitleStyle(context),
          ),
          const SizedBox(height: 4),
          Text(
            'Manage everything faster with NeoBank',
            style: DashboardStyles.headerSubtitleStyle(context),
          ),
        ],
      ),
    );
  }

  // Welcome Text
  Widget _buildWelcomeText() {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(
          style: DashboardStyles.welcomeTextStyle,
          children: [
            TextSpan(text: 'Welcome back! Here\'s an overview of your '),
            TextSpan(
              text: 'Neo-Bank',
              style: DashboardStyles.highlightTextStyle,
            ),
            TextSpan(text: ' operations.'),
          ],
        ),
      ),
    );
  }

  // ============================================
  // NeoBank Statistics Grid (3 Cards)
  // ============================================

  Widget _buildNeoBankStatsGrid() {
    final stats = [
      _NeoBankStatData(
        title: 'Active Users',
        value: '24,531',
        change: '+12% from last month',
        route: '/admin/users',
      ),
      _NeoBankStatData(
        title: 'Pending KYCs',
        value: '147',
        change: '+5 since yesterday',
        route: '/admin/kyc',
      ),
      _NeoBankStatData(
        title: 'Daily Transactions',
        value: '\$2.4M',
        change: '+8.2% from yesterday',
        route: '/admin/transactions',
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = 1;
        if (constraints.maxWidth >= 768) {
          crossAxisCount = 3;
        } else if (constraints.maxWidth >= 480) {
          crossAxisCount = 2;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: DashboardStyles.spacingMd,
            mainAxisSpacing: DashboardStyles.spacingMd,
            childAspectRatio: DashboardStyles.isMobile(context) ? 2.5 : 1.8,
          ),
          itemCount: stats.length,
          itemBuilder: (context, index) => _buildNeoBankStatCard(stats[index]),
        );
      },
    );
  }

  Widget _buildNeoBankStatCard(_NeoBankStatData stat) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, stat.route);
        },
        child: Container(
          padding: const EdgeInsets.all(DashboardStyles.spacingMd),
          decoration: DashboardStyles.statCardDecoration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                stat.title,
                style: DashboardStyles.sectionTitleStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: DashboardStyles.spacingSm),
              Text(
                stat.value,
                style: DashboardStyles.statValueStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: DashboardStyles.spacingSm),
              Text(
                stat.change,
                style: DashboardStyles.statChangeStyle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================
  // Quick Actions Section
  // ============================================

  Widget _buildQuickActions() {
    final actions = [
      _QuickActionCardData(
        title: 'KYC Approvals',
        badge: '147 pending',
        description: 'Review and approve pending user verifications',
        buttonText: 'Review KYCs',
        route: '/admin/kyc',
      ),
      _QuickActionCardData(
        title: 'Transaction Reviews',
        badge: '23 pending',
        description: 'Check flagged high-value transactions',
        buttonText: 'Review Transactions',
        route: '/admin/transactions',
      ),
      _QuickActionCardData(
        title: 'Loan Applications',
        badge: '56 pending',
        description: 'Process new loan requests and approvals',
        buttonText: 'Review Loans',
        route: '/admin/loans',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: DashboardStyles.sectionTitleStyle,
        ),
        const SizedBox(height: DashboardStyles.spacingMd),
        LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = 1;
            if (constraints.maxWidth >= 768) {
              crossAxisCount = 3;
            } else if (constraints.maxWidth >= 480) {
              crossAxisCount = 2;
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: DashboardStyles.spacingMd,
                mainAxisSpacing: DashboardStyles.spacingMd,
                childAspectRatio: DashboardStyles.isSmallMobile(context) ? 1.3 : 1.5,
              ),
              itemCount: actions.length,
              itemBuilder: (context, index) => _buildQuickActionCard(actions[index]),
            );
          },
        ),
      ],
    );
  }

  Widget _buildQuickActionCard(_QuickActionCardData action) {
    return Container(
      padding: const EdgeInsets.all(DashboardStyles.spacingMd),
      decoration: DashboardStyles.actionCardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  action.title,
                  style: DashboardStyles.sectionTitleStyle,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: DashboardStyles.badgeDecoration,
                child: Text(
                  action.badge,
                  style: DashboardStyles.badgeTextStyle,
                ),
              ),
            ],
          ),
          const SizedBox(height: DashboardStyles.spacingSm),
          Text(
            action.description,
            style: DashboardStyles.sectionSubStyle,
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, action.route);
              },
              style: DashboardStyles.actionButtonStyle,
              child: Text(action.buttonText),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================
  // Recent Transactions + System Alerts
  // ============================================

  Widget _buildNeoBankBottomSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 768) {
          return Column(
            children: [
              _buildRecentTransactions(),
              const SizedBox(height: DashboardStyles.spacingMd),
              _buildSystemAlerts(),
            ],
          );
        } else {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildRecentTransactions()),
              const SizedBox(width: DashboardStyles.spacingMd),
              Expanded(child: _buildSystemAlerts()),
            ],
          );
        }
      },
    );
  }

  Widget _buildRecentTransactions() {
    final transactions = [
      _TransactionData(
        id: 'TXN001',
        name: 'Alice Johnson',
        amount: '\$50,000',
        time: '2 min ago',
        status: 'pending',
      ),
      _TransactionData(
        id: 'TXN002',
        name: 'Bob Smith',
        amount: '\$25,000',
        time: '5 min ago',
        status: 'flagged',
      ),
      _TransactionData(
        id: 'TXN003',
        name: 'Carol Davis',
        amount: '\$15,000',
        time: '12 min ago',
        status: 'approved',
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(DashboardStyles.spacingMd),
      decoration: DashboardStyles.actionCardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Transactions',
            style: DashboardStyles.sectionTitleStyle,
          ),
          const SizedBox(height: 4),
          const Text(
            'Latest high-value transactions requiring attention',
            style: DashboardStyles.sectionSubStyle,
          ),
          const SizedBox(height: DashboardStyles.spacingMd),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final txn = transactions[index];
              return Container(
                decoration: index < transactions.length - 1
                    ? DashboardStyles.transactionItemDecoration
                    : null,
                padding: const EdgeInsets.symmetric(
                  vertical: DashboardStyles.spacing10,
                  horizontal: DashboardStyles.spacing6,
                ),
                child: DashboardStyles.isSmallMobile(context)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                txn.id,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: DashboardStyles.fontSize095,
                                ),
                              ),
                              const SizedBox(width: 8),
                              _buildStatusTag(txn.status),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            txn.name,
                            style: const TextStyle(
                              fontSize: DashboardStyles.fontSize095,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                txn.amount,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: DashboardStyles.fontSize095,
                                ),
                              ),
                              Text(
                                txn.time,
                                style: const TextStyle(
                                  color: DashboardColors.textLight,
                                  fontSize: DashboardStyles.fontSize085,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          SizedBox(
                            width: 80,
                            child: Text(
                              txn.id,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: DashboardStyles.fontSize095,
                              ),
                            ),
                          ),
                          _buildStatusTag(txn.status),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              txn.name,
                              style: const TextStyle(
                                fontSize: DashboardStyles.fontSize095,
                              ),
                            ),
                          ),
                          Text(
                            txn.amount,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: DashboardStyles.fontSize095,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            txn.time,
                            style: const TextStyle(
                              color: DashboardColors.textLight,
                              fontSize: DashboardStyles.fontSize085,
                            ),
                          ),
                        ],
                      ),
              );
            },
          ),
          const SizedBox(height: DashboardStyles.spacingMd),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/admin/transactions');
              },
              style: DashboardStyles.viewAllButtonStyle,
              child: const Text('View All Transactions'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusTag(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: DashboardStyles.getTagDecoration(status),
      child: Text(
        status,
        style: DashboardStyles.getTagTextStyle(),
      ),
    );
  }

  Widget _buildSystemAlerts() {
    final alerts = [
      _AlertData(
        message: 'AML compliance check failed for 3 users',
        time: '10 min ago',
        buttonText: 'Review Now',
        dotColor: DashboardColors.dotRed,
        route: '/admin/users',
      ),
      _AlertData(
        message: 'High transaction volume detected',
        time: '25 min ago',
        buttonText: 'Monitor',
        dotColor: DashboardColors.dotOrange,
        route: '/admin/transactions',
      ),
      _AlertData(
        message: 'Daily backup completed successfully',
        time: '1 hour ago',
        buttonText: 'View Report',
        dotColor: DashboardColors.dotGreen,
        route: '/admin/reports',
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(DashboardStyles.spacingMd),
      decoration: DashboardStyles.actionCardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'System Alerts',
            style: DashboardStyles.sectionTitleStyle,
          ),
          const SizedBox(height: 4),
          const Text(
            'Critical notifications and system status',
            style: DashboardStyles.sectionSubStyle,
          ),
          const SizedBox(height: DashboardStyles.spacingMd),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: alerts.length,
            itemBuilder: (context, index) {
              final alert = alerts[index];
              return Padding(
                padding: EdgeInsets.only(
                  bottom: index < alerts.length - 1 ? DashboardStyles.spacing12 : 0,
                ),
                child: Container(
                  decoration: DashboardStyles.alertItemDecoration,
                  padding: const EdgeInsets.all(DashboardStyles.spacing14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            margin: const EdgeInsets.only(top: 4, right: 10),
                            decoration: BoxDecoration(
                              color: alert.dotColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              alert.message,
                              style: const TextStyle(
                                fontSize: DashboardStyles.fontSize095,
                                color: DashboardColors.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: DashboardStyles.spacing6),
                      Text(
                        alert.time,
                        style: const TextStyle(
                          fontSize: DashboardStyles.fontSize085,
                          color: DashboardColors.textLight,
                        ),
                      ),
                      const SizedBox(height: DashboardStyles.spacing10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, alert.route);
                          },
                          style: DashboardStyles.alertButtonStyle,
                          child: Text(alert.buttonText),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ============================================
  // Original Statistics Cards (4 Cards)
  // ============================================

  Widget _buildStatisticsCards() {
    final stats = [
      _StatData(
        title: 'Total Users',
        value: '12,543',
        icon: FontAwesomeIcons.users,
        color: DashboardColors.info,
        change: '+12.5%',
        isPositive: true,
      ),
      _StatData(
        title: 'Total Revenue',
        value: '₹2.4M',
        icon: FontAwesomeIcons.indianRupeeSign,
        color: DashboardColors.success,
        change: '+8.2%',
        isPositive: true,
      ),
      _StatData(
        title: 'Active Accounts',
        value: '8,234',
        icon: FontAwesomeIcons.wallet,
        color: DashboardColors.warning,
        change: '+5.1%',
        isPositive: true,
      ),
      _StatData(
        title: 'Pending KYC',
        value: '342',
        icon: FontAwesomeIcons.fileLines,
        color: DashboardColors.error,
        change: '-2.4%',
        isPositive: false,
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: DashboardStyles.getGridColumns(context),
        crossAxisSpacing: DashboardStyles.spacingMd,
        mainAxisSpacing: DashboardStyles.spacingMd,
        childAspectRatio: DashboardStyles.isMobile(context) ? 2.5 : 2.2,
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) => _buildStatCard(stats[index]),
    );
  }

  Widget _buildStatCard(_StatData data) {
    return Container(
      decoration: DashboardStyles.statCardDecoration,
      padding: const EdgeInsets.all(DashboardStyles.spacingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: DashboardStyles.iconContainerDecoration(data.color),
                child: FaIcon(data.icon, color: data.color, size: 20),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: DashboardStyles.badgeDecorationDynamic(
                  data.isPositive ? DashboardColors.success : DashboardColors.error,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      data.isPositive ? Icons.trending_up : Icons.trending_down,
                      size: 12,
                      color: data.isPositive ? DashboardColors.success : DashboardColors.error,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      data.change,
                      style: DashboardStyles.badgeTextStyleDynamic(
                        data.isPositive ? DashboardColors.success : DashboardColors.error,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.value, style: DashboardStyles.statValueStyle),
              const SizedBox(height: 4),
              Text(data.title, style: DashboardStyles.statLabelStyle),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================
  // Recent Activity & Quick Actions (Bottom)
  // ============================================

  Widget _buildBottomSection() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: DashboardStyles.getChartGridColumns(context),
      crossAxisSpacing: DashboardStyles.spacingMd,
      mainAxisSpacing: DashboardStyles.spacingMd,
      childAspectRatio: DashboardStyles.isMobile(context) ? 0.9 : 1.2,
      children: [
        _buildRecentActivityCard(),
        _buildQuickActionsCard(),
      ],
    );
  }

  Widget _buildRecentActivityCard() {
    final activities = [
      _ActivityData(
        title: 'New user registration',
        subtitle: 'John Doe registered',
        time: '5 min ago',
        icon: FontAwesomeIcons.userPlus,
        color: DashboardColors.success,
      ),
      _ActivityData(
        title: 'Transaction completed',
        subtitle: '₹50,000 transferred',
        time: '15 min ago',
        icon: FontAwesomeIcons.moneyBillTransfer,
        color: DashboardColors.info,
      ),
      _ActivityData(
        title: 'KYC approved',
        subtitle: 'Jane Smith verified',
        time: '1 hour ago',
        icon: FontAwesomeIcons.circleCheck,
        color: DashboardColors.success,
      ),
      _ActivityData(
        title: 'New complaint',
        subtitle: 'Support ticket #1234',
        time: '2 hours ago',
        icon: FontAwesomeIcons.circleExclamation,
        color: DashboardColors.warning,
      ),
    ];

    return Container(
      decoration: DashboardStyles.cardDecoration,
      padding: const EdgeInsets.all(DashboardStyles.spacingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent Activity', style: DashboardStyles.subheadingStyle),
              TextButton(
                onPressed: () {},
                style: DashboardStyles.viewAllButtonStyleActivity,
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: DashboardStyles.spacingMd),
          Expanded(
            child: ListView.separated(
              itemCount: activities.length,
              separatorBuilder: (context, index) => const Divider(
                height: DashboardStyles.spacingMd,
                color: DashboardColors.borderLight,
              ),
              itemBuilder: (context, index) {
                final activity = activities[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: DashboardStyles.iconContainerDecoration(activity.color),
                    child: FaIcon(activity.icon, color: activity.color, size: 16),
                  ),
                  title: Text(
                    activity.title,
                    style: DashboardStyles.bodyStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      color: DashboardColors.textPrimary,
                    ),
                  ),
                  subtitle: Text(activity.subtitle, style: DashboardStyles.captionStyle),
                  trailing: Text(activity.time, style: DashboardStyles.captionStyle),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsCard() {
    final actions = [
      _QuickActionData(
        title: 'Add New User',
        icon: FontAwesomeIcons.userPlus,
        color: DashboardColors.info,
        route: '/admin/users',
      ),
      _QuickActionData(
        title: 'Approve KYC',
        icon: FontAwesomeIcons.checkCircle,
        color: DashboardColors.success,
        route: '/admin/kyc',
      ),
      _QuickActionData(
        title: 'View Transactions',
        icon: FontAwesomeIcons.receipt,
        color: DashboardColors.warning,
        route: '/admin/transactions',
      ),
      _QuickActionData(
        title: 'Generate Report',
        icon: FontAwesomeIcons.fileContract,
        color: DashboardColors.primary,
        route: '/admin/reports',
      ),
    ];

    return Container(
      decoration: DashboardStyles.cardDecoration,
      padding: const EdgeInsets.all(DashboardStyles.spacingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Quick Actions', style: DashboardStyles.subheadingStyle),
          const SizedBox(height: DashboardStyles.spacingMd),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: DashboardStyles.spacingMd,
                mainAxisSpacing: DashboardStyles.spacingMd,
                childAspectRatio: 1.3,
              ),
              itemCount: actions.length,
              itemBuilder: (context, index) {
                final action = actions[index];
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, action.route);
                  },
                  borderRadius: BorderRadius.circular(DashboardStyles.radiusMd),
                  child: Container(
                    decoration: BoxDecoration(
                      color: action.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(DashboardStyles.radiusMd),
                      border: Border.all(color: action.color.withOpacity(0.2), width: 1),
                    ),
                    padding: const EdgeInsets.all(DashboardStyles.spacingMd),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(action.icon, color: action.color, size: 32),
                        const SizedBox(height: DashboardStyles.spacingSm),
                        Text(
                          action.title,
                          textAlign: TextAlign.center,
                          style: DashboardStyles.bodyStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            color: DashboardColors.textPrimary,
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
    );
  }
}

// ============================================
// Data Models
// ============================================

class _NeoBankStatData {
  final String title;
  final String value;
  final String change;
  final String route;

  _NeoBankStatData({
    required this.title,
    required this.value,
    required this.change,
    required this.route,
  });
}

class _QuickActionCardData {
  final String title;
  final String badge;
  final String description;
  final String buttonText;
  final String route;

  _QuickActionCardData({
    required this.title,
    required this.badge,
    required this.description,
    required this.buttonText,
    required this.route,
  });
}

class _TransactionData {
  final String id;
  final String name;
  final String amount;
  final String time;
  final String status;

  _TransactionData({
    required this.id,
    required this.name,
    required this.amount,
    required this.time,
    required this.status,
  });
}

class _AlertData {
  final String message;
  final String time;
  final String buttonText;
  final Color dotColor;
  final String route;

  _AlertData({
    required this.message,
    required this.time,
    required this.buttonText,
    required this.dotColor,
    required this.route,
  });
}

class _StatData {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String change;
  final bool isPositive;

  _StatData({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.change,
    required this.isPositive,
  });
}

class _ActivityData {
  final String title;
  final String subtitle;
  final String time;
  final IconData icon;
  final Color color;

  _ActivityData({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.icon,
    required this.color,
  });
}

class _QuickActionData {
  final String title;
  final IconData icon;
  final Color color;
  final String route;

  _QuickActionData({
    required this.title,
    required this.icon,
    required this.color,
    required this.route,
  });
}
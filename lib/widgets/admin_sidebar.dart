import 'package:flutter/material.dart';
import '../models/admin_menu_item_model.dart';

class AdminSidebar extends StatefulWidget {
  const AdminSidebar({super.key});

  @override
  State<AdminSidebar> createState() => _AdminSidebarState();
}

class _AdminSidebarState extends State<AdminSidebar> {
  String? _expandedItem;

  final List<MenuItemModel> menuItems = [
    MenuItemModel(
      name: 'Dashboard',
      icon: Icons.dashboard_outlined,
      path: '/admin/',
    ),
    MenuItemModel(
      name: 'Users',
      icon: Icons.people_outline,
      path: '/admin/users',
    ),
    MenuItemModel(
      name: 'KYC',
      icon: Icons.description_outlined,
      path: '/admin/kyc',
    ),
    MenuItemModel(
      name: 'Accounts & Wallets',
      icon: Icons.account_balance_wallet_outlined,
      path: '/admin/accountsdashboard',
    ),
    MenuItemModel(
      name: 'Transactions',
      icon: Icons.swap_horiz_outlined,
      path: '/admin/transactions',
    ),
    MenuItemModel(
      name: 'Money Transfer Request',
      icon: Icons.send_outlined,
      path: '/admin/moneyrequest',
    ),
    MenuItemModel(
      name: 'Deposit Management',
      icon: Icons.account_balance_outlined,
      path: '/admin/depositmanagement',
    ),
    MenuItemModel(
      name: 'Investment Products',
      icon: Icons.trending_up_outlined,
      path: '/admin/investment_products',
    ),
    MenuItemModel(
      name: 'Complaints & Support',
      icon: Icons.support_agent_outlined,
      path: '/admin/complaints&support',
    ),
    MenuItemModel(
      name: 'Reports & Analytics',
      icon: Icons.analytics_outlined,
      path: '/admin/reports',
    ),
    MenuItemModel(
      name: 'Loans',
      icon: Icons.request_quote_outlined,
      path: '/admin/loans',
    ),
    MenuItemModel(
      name: 'Cards',
      icon: Icons.credit_card_outlined,
      path: '/admin/cards',
    ),
    MenuItemModel(
      name: 'Setting',
      icon: Icons.settings_outlined,
      path: '/admin/settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;

    return Container(
      width: isMobile ? width * 0.78 : 280,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          // 🔴 Header with Logo (Updated to match AppLayout style)
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.white),
            child: Center(
              child: Image.asset(
                'assets/neobank02.png',
                height: 140,
              ),
            ),
          ),

          // 🧾 Menu List
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ...menuItems.map((item) {
                  if (item.hasDropdown) {
                    return _buildDropdownItem(item, isMobile);
                  }
                  return _buildMenuItem(item, isMobile);
                }).toList(),
                const Divider(),
              ],
            ),
          ),

          // 👤 Footer Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
              color: Colors.grey.shade50,
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 22,
                  backgroundColor: Color(0xFF900603),
                  child: Icon(Icons.person, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Admin',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        'Administrator',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    switch (value) {
                      case 'profile':
                        Navigator.pushNamed(context, '/admin/adminprofile');
                        break;
                      case 'settings':
                        Navigator.pushNamed(context, '/admin/adminsettings');
                        break;
                      case 'logout':
                        _showLogoutDialog(context);
                        break;
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'profile',
                      child: Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 18,
                            color: Color(0xFF900603),
                          ),
                          SizedBox(width: 10),
                          Text('My Profile'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'settings',
                      child: Row(
                        children: [
                          Icon(
                            Icons.settings,
                            size: 18,
                            color: Color(0xFF900603),
                          ),
                          SizedBox(width: 10),
                          Text('Settings'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'logout',
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            size: 18,
                            color: Color(0xFF900603),
                          ),
                          SizedBox(width: 10),
                          Text('Logout'),
                        ],
                      ),
                    ),
                  ],
                  icon: const Icon(
                    Icons.more_vert,
                    size: 20,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🎯 Menu Item Builder (Updated with darker colors)
  Widget _buildMenuItem(MenuItemModel item, bool isMobile) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    final isActive = currentRoute == item.path;

    return ListTile(
      leading: Icon(
        item.icon,
        color: isActive ? const Color(0xFF900603) : Colors.black87,
        size: isMobile ? 20 : 24,
      ),
      title: Text(
        item.name,
        style: TextStyle(
          fontSize: isMobile ? 14 : 16,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          color: isActive ? const Color(0xFF900603) : Colors.black87,
        ),
      ),
      selected: isActive,
      selectedTileColor: const Color(0xFF900603).withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      onTap: () {
        if (item.path != null) {
          Navigator.pop(context);
          Navigator.pushNamed(context, item.path!);
        }
      },
    );
  }

  Widget _buildDropdownItem(MenuItemModel item, bool isMobile) {
    final isExpanded = _expandedItem == item.name;
    final currentRoute = ModalRoute.of(context)?.settings.name;
    final hasActiveChild =
        item.dropdown?.any((subItem) => subItem.path == currentRoute) ?? false;

    return Column(
      children: [
        ListTile(
          leading: Icon(
            item.icon,
            color: hasActiveChild ? const Color(0xFF900603) : Colors.black87,
            size: isMobile ? 20 : 24,
          ),
          title: Text(
            item.name,
            style: TextStyle(
              fontSize: isMobile ? 14 : 16,
              fontWeight: hasActiveChild ? FontWeight.w600 : FontWeight.w500,
              color: hasActiveChild ? const Color(0xFF900603) : Colors.black87,
            ),
          ),
          trailing: AnimatedRotation(
            turns: isExpanded ? 0.5 : 0,
            duration: const Duration(milliseconds: 200),
            child: Icon(
              Icons.keyboard_arrow_down,
              size: isMobile ? 18 : 20,
              color: isExpanded ? const Color(0xFF900603) : Colors.black87,
            ),
          ),
          selected: hasActiveChild,
          selectedTileColor: const Color(0xFF900603).withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          onTap: () {
            setState(() {
              _expandedItem = isExpanded ? null : item.name;
            });
          },
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Container(
            margin: EdgeInsets.only(left: isMobile ? 40 : 48),
            child: Column(
              children: item.dropdown!.map((subItem) {
                return _buildSubMenuItem(subItem, isMobile);
              }).toList(),
            ),
          ),
          crossFadeState: isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
      ],
    );
  }

  Widget _buildSubMenuItem(MenuItemModel subItem, bool isMobile) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    final isActive = currentRoute == subItem.path;

    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: isMobile ? 8 : 16,
        vertical: 0,
      ),
      leading: Icon(
        subItem.icon,
        size: isMobile ? 16 : 18,
        color: isActive ? const Color(0xFF900603) : Colors.black87,
      ),
      title: Text(
        subItem.name,
        style: TextStyle(
          fontSize: isMobile ? 12 : 14,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          color: isActive ? const Color(0xFF900603) : Colors.black87,
        ),
      ),
      selected: isActive,
      selectedTileColor: const Color(0xFF900603).withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      onTap: () {
        if (subItem.path != null) {
          Navigator.pop(context);
          Navigator.pushNamed(context, subItem.path!);
        }
      },
    );
  }

  // 🚪 Logout Dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF900603),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              
              // Show beautiful logout message
              showDialog(
                context: context,
                barrierDismissible: false,
                barrierColor: Colors.black.withOpacity(0.7),
                builder: (_) => Center(
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF900603), Color(0xFFB91C1C)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF900603).withOpacity(0.4),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Animated Icon
                          TweenAnimationBuilder(
                            tween: Tween<double>(begin: 0.0, end: 1.0),
                            duration: const Duration(milliseconds: 600),
                            builder: (context, double value, child) {
                              return Transform.scale(
                                scale: value,
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.25),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.3),
                                        blurRadius: 15,
                                        spreadRadius: 3,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                    size: 60,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 24),
                          // Thank You with fade-in
                          TweenAnimationBuilder(
                            tween: Tween<double>(begin: 0.0, end: 1.0),
                            duration: const Duration(milliseconds: 800),
                            builder: (context, double value, child) {
                              return Opacity(
                                opacity: value,
                                child: const Text(
                                  'Thank You!',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1.5,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black26,
                                        offset: Offset(0, 2),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          // Hope message
                          TweenAnimationBuilder(
                            tween: Tween<double>(begin: 0.0, end: 1.0),
                            duration: const Duration(milliseconds: 1000),
                            builder: (context, double value, child) {
                              return Opacity(
                                opacity: value,
                                child: const Text(
                                  'We Hope You Enjoyed\nOur Banking Services! 🏦',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    height: 1.6,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          // Decorative line with animation
                          TweenAnimationBuilder(
                            tween: Tween<double>(begin: 0.0, end: 60.0),
                            duration: const Duration(milliseconds: 800),
                            builder: (context, double width, child) {
                              return Container(
                                width: width,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(2),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.4),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 12),
                          // See you soon message
                          const Text(
                            'See You Soon! 👋',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );

              // Navigate after 2 seconds
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/');
              });
            },
            child: const Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
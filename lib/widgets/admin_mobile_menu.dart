// lib/widgets/admin_mobile_menu.dart
import 'package:flutter/material.dart';
import '../models/admin_menu_item_model.dart';
import '../styles/admin_tnb_styles.dart';

class MobileMenu extends StatefulWidget {
  final List<MenuItemModel> menuItems;
  final VoidCallback onClose;

  const MobileMenu({
    super.key,
    required this.menuItems,
    required this.onClose,
  });

  @override
  State<MobileMenu> createState() => _MobileMenuState();
}

class _MobileMenuState extends State<MobileMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  String? _expandedItem;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _slideAnimation = Tween<double>(begin: -1, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _closeMenu() {
    _controller.reverse().then((_) => widget.onClose());
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.75;
    final height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        // Dim overlay
        GestureDetector(
          onTap: _closeMenu,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                color: Colors.black.withOpacity(0.4 * _controller.value),
              );
            },
          ),
        ),

        // Slide-in Menu
        AnimatedBuilder(
          animation: _slideAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(_slideAnimation.value * width, 0),
              child: child,
            );
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: width,
              height: height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFF9FAFB), Color(0xFFF3F4F6)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  // 🔹 Header - directly below top navbar
                  Container(
                    height: 100,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [TnbColors.primary, Color(0xFF911515)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                      ),
                    ),
                    padding: const EdgeInsets.only(
                      top: 8, // reduced drastically (was 30)
                      left: 20,
                      right: 20,
                      bottom: 10,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.account_circle_rounded,
                          color: Colors.white,
                          size: 36,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Admin Panel",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "neobank.admin@app",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // 🔹 Menu Items
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      children: widget.menuItems.map((item) {
                        return item.hasDropdown
                            ? _buildDropdownItem(item)
                            : _buildMenuItem(item);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // --- Menu Item ---
  Widget _buildMenuItem(MenuItemModel item) {
    final isActive = ModalRoute.of(context)?.settings.name == item.path;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isActive ? const Color(0xFFFFF5F5) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: Icon(
          item.icon,
          color: isActive ? TnbColors.primary : Colors.grey[700],
          size: 22,
        ),
        title: Text(
          item.name,
          style: TextStyle(
            fontSize: 15.5,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            color: isActive ? TnbColors.primary : Colors.grey[900],
          ),
        ),
        onTap: () {
          if (item.path != null) {
            Navigator.pushNamed(context, item.path!);
            _closeMenu();
          }
        },
      ),
    );
  }

  // --- Dropdown Item ---
  Widget _buildDropdownItem(MenuItemModel item) {
    final isExpanded = _expandedItem == item.name;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              item.icon,
              color: isExpanded ? TnbColors.primary : Colors.grey[700],
              size: 22,
            ),
            title: Text(
              item.name,
              style: TextStyle(
                fontSize: 15.5,
                fontWeight: isExpanded ? FontWeight.w600 : FontWeight.w500,
                color: isExpanded ? TnbColors.primary : Colors.grey[900],
              ),
            ),
            trailing: AnimatedRotation(
              turns: isExpanded ? 0.5 : 0,
              duration: const Duration(milliseconds: 200),
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: isExpanded ? TnbColors.primary : Colors.grey[600],
              ),
            ),
            onTap: () {
              setState(() {
                _expandedItem = isExpanded ? null : item.name;
              });
            },
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            child: isExpanded
                ? Container(
                    margin: const EdgeInsets.only(
                        left: 20, right: 12, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children:
                          item.dropdown!.map(_buildSubMenuItem).toList(),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  // --- Sub Menu Item ---
  Widget _buildSubMenuItem(MenuItemModel subItem) {
    final isActive = ModalRoute.of(context)?.settings.name == subItem.path;

    return ListTile(
      dense: true,
      leading: Icon(
        subItem.icon,
        size: 18,
        color: isActive ? TnbColors.primary : Colors.grey[700],
      ),
      title: Text(
        subItem.name,
        style: TextStyle(
          fontSize: 14.5,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          color: isActive ? TnbColors.primary : Colors.grey[900],
        ),
      ),
      onTap: () {
        if (subItem.path != null) {
          Navigator.pushNamed(context, subItem.path!);
          _closeMenu();
        }
      },
    );
  }
}

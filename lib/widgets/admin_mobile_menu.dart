// lib/widgets/mobile_menu.dart
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
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  String? _expandedItem;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final maxHeight = screenHeight * 0.75; // 75% of screen height

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          decoration: TnbStyles.mobileMenuDecoration,
          constraints: BoxConstraints(
            maxHeight: maxHeight,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: widget.menuItems.map((item) {
                if (item.hasDropdown) {
                  return _buildDropdownItem(item);
                } else {
                  return _buildMenuItem(item);
                }
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(MenuItemModel item) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    final isActive = currentRoute == item.path;

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (item.path != null) {
              Navigator.pushNamed(context, item.path!);
              widget.onClose();
            }
          },
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isActive 
                  ? TnbColors.primary.withOpacity(0.1)
                  : Colors.transparent,
              border: isActive
                  ? Border.all(color: TnbColors.primary.withOpacity(0.3))
                  : null,
            ),
            child: Row(
              children: [
                Icon(
                  item.icon,
                  size: 20,
                  color: isActive ? TnbColors.primary : TnbColors.grey,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    item.name,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                      color: isActive ? TnbColors.primary : TnbColors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownItem(MenuItemModel item) {
    final isExpanded = _expandedItem == item.name;

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                setState(() {
                  _expandedItem = isExpanded ? null : item.name;
                });
              },
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: isExpanded
                      ? TnbColors.primary.withOpacity(0.05)
                      : Colors.transparent,
                ),
                child: Row(
                  children: [
                    Icon(
                      item.icon,
                      size: 20,
                      color: isExpanded ? TnbColors.primary : TnbColors.grey,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        item.name,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: isExpanded ? TnbColors.primary : TnbColors.grey,
                        ),
                      ),
                    ),
                    AnimatedRotation(
                      turns: isExpanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        size: 20,
                        color: isExpanded ? TnbColors.primary : TnbColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Dropdown Items with Animation
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Container(
              margin: const EdgeInsets.only(left: 16, top: 6),
              padding: const EdgeInsets.only(left: 12),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: TnbColors.primary.withOpacity(0.3),
                    width: 2,
                  ),
                ),
              ),
              child: Column(
                children: item.dropdown!.map((subItem) {
                  return _buildSubMenuItem(subItem);
                }).toList(),
              ),
            ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }

  Widget _buildSubMenuItem(MenuItemModel subItem) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    final isActive = currentRoute == subItem.path;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (subItem.path != null) {
              Navigator.pushNamed(context, subItem.path!);
              widget.onClose();
            }
          },
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: isActive
                  ? TnbColors.primary.withOpacity(0.1)
                  : Colors.transparent,
            ),
            child: Row(
              children: [
                Icon(
                  subItem.icon,
                  size: 18,
                  color: isActive ? TnbColors.primary : Colors.grey[600],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    subItem.name,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                      color: isActive ? TnbColors.primary : Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
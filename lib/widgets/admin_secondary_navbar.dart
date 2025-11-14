import 'package:flutter/material.dart';
import '../models/admin_menu_item_model.dart';
import '../styles/admin_tnb_styles.dart';

class SecondaryNavbar extends StatefulWidget {
  final List<MenuItemModel> menuItems;

  const SecondaryNavbar({super.key, required this.menuItems});

  @override
  State<SecondaryNavbar> createState() => _SecondaryNavbarState();
}

class _SecondaryNavbarState extends State<SecondaryNavbar> {
  String? _currentPath;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _currentPath = ModalRoute.of(context)?.settings.name;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: TnbStyles.secondaryNavbarDecoration,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Center(
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: widget.menuItems.map((item) {
            if (item.hasDropdown) {
              return _buildDropdownItem(item);
            } else {
              return _buildNavItem(item);
            }
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildNavItem(MenuItemModel item) {
    final isActive = _currentPath == item.path;

    return TextButton.icon(
      onPressed: () {
        if (item.path != null) {
          Navigator.pushNamed(context, item.path!);
        }
      },
      icon: Icon(item.icon, size: 18),
      label: Text(
        item.name,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      style: isActive ? TnbStyles.activeNavItemStyle : TnbStyles.navItemStyle,
    );
  }

  Widget _buildDropdownItem(MenuItemModel item) {
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) {
        return item.dropdown!.map((subItem) {
          return PopupMenuItem<String>(
            value: subItem.path,
            child: Row(
              children: [
                Icon(subItem.icon, size: 16, color: TnbColors.grey),
                const SizedBox(width: 12),
                Text(subItem.name),
              ],
            ),
          );
        }).toList();
      },
      onSelected: (String path) {
        Navigator.pushNamed(context, path);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(item.icon, size: 18, color: TnbColors.grey),
            const SizedBox(width: 8),
            Text(
              item.name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: TnbColors.grey,
              ),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.keyboard_arrow_down, size: 14),
          ],
        ),
      ),
    );
  }
}

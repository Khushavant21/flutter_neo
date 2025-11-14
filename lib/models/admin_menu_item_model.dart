import 'package:flutter/material.dart';

class MenuItemModel {
  final String name;
  final IconData icon;
  final String? path;
  final List<MenuItemModel>? dropdown;

  MenuItemModel({
    required this.name,
    required this.icon,
    this.path,
    this.dropdown,
  });

  bool get hasDropdown => dropdown != null && dropdown!.isNotEmpty;
}

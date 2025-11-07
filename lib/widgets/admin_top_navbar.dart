//  lib/widgets/top_navbar.dart
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import '../models/admin_menu_item_model.dart';
// import '../styles/admin_tnb_styles.dart';
// import 'admin_secondary_navbar.dart';
// import 'admin_mobile_menu.dart';

// class TopNavbar extends StatefulWidget {
//   const TopNavbar({super.key});

//   @override
//   State<TopNavbar> createState() => _TopNavbarState();
// }

// class _TopNavbarState extends State<TopNavbar> {
//   bool mobileMenuOpen = false;
//   final TextEditingController _searchController = TextEditingController();

//   final List<MenuItemModel> menuItems = [
//     MenuItemModel(
//       name: 'Dashboard',
//       icon: Icons.dashboard_outlined,
//       path: '/admin/',
//     ),
//     MenuItemModel(
//       name: 'Users',
//       icon: Icons.people_outline,
//       path: '/admin/users',
//     ),
//     MenuItemModel(
//       name: 'KYC',
//       icon: Icons.description_outlined,
//       path: '/admin/kyc',
//     ),
//     MenuItemModel(
//       name: 'Accounts & Wallets',
//       icon: Icons.account_balance_wallet_outlined,
//       path: '/admin/accountsdashboard',
//     ),
//     MenuItemModel(
//       name: 'Transactions',
//       icon: Icons.credit_card_outlined,
//       path: '/admin/transactions',
//     ),
//     MenuItemModel(
//       name: 'Money Transfer Request',
//       icon: Icons.send_outlined,
//       path: '/admin/moneyrequest',
//     ),
//     MenuItemModel(
//       name: 'Deposit Management',
//       icon: Icons.account_balance_outlined,
//       path: '/admin/depositmanagement',
//     ),
//     MenuItemModel(
//       name: 'Services',
//       icon: Icons.settings_outlined,
//       dropdown: [
//         MenuItemModel(
//           name: 'Investment Products',
//           icon: Icons.bar_chart_outlined,
//           path: '/admin/investment_products',
//         ),
//         MenuItemModel(
//           name: 'Complaints & Support',
//           icon: Icons.support_agent_outlined,
//           path: '/admin/complaints',
//         ),
//         MenuItemModel(
//           name: 'Reports & Analytics',
//           icon: Icons.analytics_outlined,
//           path: '/admin/reports',
//         ),
//         MenuItemModel(
//           name: 'Loans',
//           icon: Icons.attach_money_outlined,
//           path: '/admin/loans',
//         ),
//         MenuItemModel(
//           name: 'Cards',
//           icon: Icons.credit_card,
//           path: '/admin/cards',
//         ),
//         MenuItemModel(
//           name: 'Setting',
//           icon: Icons.settings,
//           path: '/admin/settings',
//         ),
//       ],
//     ),
//   ];

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   void _toggleMobileMenu() {
//     setState(() {
//       mobileMenuOpen = !mobileMenuOpen;
//     });
//   }

//   void _showProfileMenu(BuildContext context) {
//     final RenderBox button = context.findRenderObject() as RenderBox;
//     final RenderBox overlay =
//         Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;
//     final RelativeRect position = RelativeRect.fromRect(
//       Rect.fromPoints(
//         button.localToGlobal(
//           button.size.bottomLeft(Offset.zero),
//           ancestor: overlay,
//         ),
//         button.localToGlobal(
//           button.size.bottomRight(Offset.zero),
//           ancestor: overlay,
//         ),
//       ),
//       Offset.zero & overlay.size,
//     );

//     showMenu<String>(
//       context: context,
//       position: position,
//       items: [
//         const PopupMenuItem<String>(
//           value: 'profile',
//           child: Row(
//             children: [
//               Icon(Icons.person, size: 20, color: Color(0xFF900603)),
//               SizedBox(width: 12),
//               Text('My Profile'),
//             ],
//           ),
//         ),
//         const PopupMenuItem<String>(
//           value: 'settings',
//           child: Row(
//             children: [
//               Icon(Icons.settings, size: 20, color: Color(0xFF900603)),
//               SizedBox(width: 12),
//               Text('Settings'),
//             ],
//           ),
//         ),
//         const PopupMenuItem<String>(
//           value: 'logout',
//           child: Row(
//             children: [
//               Icon(Icons.logout, size: 20, color: Color(0xFF900603)),
//               SizedBox(width: 12),
//               Text('Logout'),
//             ],
//           ),
//         ),
//       ],
//       elevation: 8,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//     ).then((value) {
//       if (value != null) {
//         switch (value) {
//           case 'profile':
//             Navigator.pushNamed(context, '/admin/adminprofile');
//             break;
//           case 'settings':
//             Navigator.pushNamed(context, '/admin/adminsettings');
//             break;
//           case 'logout':
//             _showLogoutDialog(context);
//             break;
//         }
//       }
//     });
//   }

//   void _showLogoutDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Logout'),
//           content: const Text('Are you sure you want to logout?'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 Navigator.pushReplacementNamed(context, '/');
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text('Logged out successfully'),
//                     duration: Duration(seconds: 2),
//                   ),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF900603),
//                 foregroundColor: Colors.white,
//               ),
//               child: const Text('Logout'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isMobile = screenWidth < 992;
//     final isSmallMobile = screenWidth < 600;

//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         // Top Navbar
//         Container(
//           decoration: TnbStyles.navbarDecoration,
//           padding: EdgeInsets.only(
//             left: isSmallMobile ? 16 : 20,
//             right: isSmallMobile ? 16 : 20,
//             top: isSmallMobile ? 16 : 18,
//             bottom: isSmallMobile ? 16 : 18,
//           ),
//           child: SafeArea(
//             bottom: false,
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // Logo
//                 InkWell(
//                   onTap: () {
//                     Navigator.pushNamed(context, '/');
//                   },
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Image.asset(
//                         'assets/logo.png',
//                         height: TnbStyles.getLogoSize(context),
//                         width: TnbStyles.getLogoSize(context),
//                       ),
//                       SizedBox(width: isSmallMobile ? 8 : 10),
//                       Text(
//                         'NEOBANK ADMIN',
//                         style: TnbStyles.getLogoTextStyle(context),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const Spacer(),

//                 // Search (hidden on mobile)
//                 if (!isMobile) ...[
//                   Flexible(
//                     child: Container(
//                       constraints: const BoxConstraints(maxWidth: 400),
//                       child: TextField(
//                         controller: _searchController,
//                         decoration: TnbStyles.searchInputDecoration,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 20),
//                 ],

//                 // Right Side: Notification + Profile + Menu
//                 Row(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     // Notification Button
//                     SizedBox(
//                       width: 44,
//                       height: 44,
//                       child: Stack(
//                         clipBehavior: Clip.none,
//                         alignment: Alignment.center,
//                         children: [
//                           IconButton(
//                             icon: FaIcon(
//                               FontAwesomeIcons.bell,
//                               color: TnbColors.primary,
//                               size: isSmallMobile ? 20 : 22,
//                             ),
//                             padding: EdgeInsets.zero,
//                             constraints: const BoxConstraints(),
//                             onPressed: () {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                   content: Text('3 new notifications'),
//                                   duration: Duration(seconds: 2),
//                                 ),
//                               );
//                             },
//                           ),
//                           Positioned(
//                             top: 6,
//                             right: 6,
//                             child: Container(
//                               padding: const EdgeInsets.all(5),
//                               decoration: TnbStyles.badgeDecoration,
//                               constraints: const BoxConstraints(
//                                 minWidth: 18,
//                                 minHeight: 18,
//                               ),
//                               child: const Text(
//                                 '3',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(width: isSmallMobile ? 10 : 12),

//                     // Profile Button with Dropdown Menu
//                     Builder(
//                       builder: (BuildContext context) {
//                         return InkWell(
//                           onTap: () => _showProfileMenu(context),
//                           borderRadius: BorderRadius.circular(20),
//                           child: Container(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: isSmallMobile ? 10 : 12,
//                               vertical: 10,
//                             ),
//                             decoration: TnbStyles.profileButtonDecoration,
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Icon(
//                                   Icons.person_outline,
//                                   color: TnbColors.primary,
//                                   size: isSmallMobile ? 20 : 22,
//                                 ),
//                                 if (!isSmallMobile) ...[
//                                   const SizedBox(width: 8),
//                                   const Text(
//                                     'Admin',
//                                     style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                   const SizedBox(width: 4),
//                                   const Icon(
//                                     Icons.arrow_drop_down,
//                                     size: 20,
//                                     color: Color(0xFF900603),
//                                   ),
//                                 ],
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                     SizedBox(width: isSmallMobile ? 10 : 12),

//                     // Mobile Menu Button
//                     if (isMobile)
//                       Material(
//                         color: Colors.transparent,
//                         child: InkWell(
//                           onTap: _toggleMobileMenu,
//                           borderRadius: BorderRadius.circular(8),
//                           child: Container(
//                             width: 44,
//                             height: 44,
//                             alignment: Alignment.center,
//                             child: Icon(
//                               mobileMenuOpen ? Icons.close : Icons.menu,
//                               color: TnbColors.primary,
//                               size: isSmallMobile ? 26 : 28,
//                             ),
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),

//         // Secondary Navbar (Desktop)
//         if (!isMobile) SecondaryNavbar(menuItems: menuItems),

//         // Mobile Menu (FIXED - Now with proper constraints)
//         if (isMobile && mobileMenuOpen)
//           ConstrainedBox(
//             constraints: BoxConstraints(
//               maxHeight: MediaQuery.of(context).size.height * 0.6,
//             ),
//             child: MobileMenu(
//               menuItems: menuItems,
//               onClose: () {
//                 setState(() {
//                   mobileMenuOpen = false;
//                 });
//               },
//             ),
//           ),
//       ],
//     );
//   }
// }

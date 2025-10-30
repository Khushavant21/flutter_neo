// lib/widgets/profile_page.dart
import 'package:flutter/material.dart';
import '../admin_profile/admin_profile_styles.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool twoFactorEnabled = true;
  
  Map<String, bool> notifications = {
    'transactionAlerts': true,
    'systemNotifications': true,
    'newDeviceLogin': true,
    'monthlyStatements': false,
  };

  final Map<String, String> adminData = {
    'name': 'Khushavant Wagh',
    'employeeId': 'EMP009874',
    'role': 'Branch Manager',
    'department': 'Retail Banking',
    'email': 'Khushavant.Wagh@neobank.com',
    'phone': '+91-7420813082',
    'branch': 'Kharadi, Pune',
    'profileImage': 'https://drive.google.com/uc?export=view&id=1faMupFQ6sJPXg-feLK0oBAQMNCDASOf1',
  };

  final List<Map<String, dynamic>> accessLogs = [
    {
      'date': '2025-10-09',
      'time': '09:15 AM',
      'device': 'Windows Chrome',
      'ip': '192.168.1.45',
      'location': 'Mumbai, MH',
      'status': 'success'
    },
    {
      'date': '2025-10-08',
      'time': '02:30 PM',
      'device': 'MacBook Safari',
      'ip': '192.168.1.45',
      'location': 'Mumbai, MH',
      'status': 'success'
    },
    {
      'date': '2025-10-07',
      'time': '10:45 AM',
      'device': 'Android App',
      'ip': '103.212.45.89',
      'location': 'Thane, MH',
      'status': 'success'
    },
    {
      'date': '2025-10-06',
      'time': '08:20 PM',
      'device': 'Windows Firefox',
      'ip': '103.212.45.90',
      'location': 'Unknown',
      'status': 'failed'
    },
  ];

  void handleNotificationToggle(String key) {
    setState(() {
      notifications[key] = !notifications[key]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    
    return Scaffold(
      backgroundColor: ProfileStyles.backgroundColor,
      body: Stack(
        children: [
          // Main Content
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: 90,
                left: isMobile ? 16 : 32,
                right: isMobile ? 16 : 32,
                bottom: isMobile ? 16 : 32,
              ),
              child: Column(
                children: [
                  // Profile Card
                  _buildProfileCard(),
                  const SizedBox(height: 32),
                  
                  // Access Logs
                  _buildAccessLogs(),
                  const SizedBox(height: 32),
                  
                  // Notification Preferences
                  _buildNotificationPreferences(),
                  const SizedBox(height: 32),
                  
                  // Security Note
                  _buildSecurityNote(),
                ],
              ),
            ),
          ),
          
          // Fixed Header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildHeader(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: ProfileStyles.headerDecoration,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isSmallScreen = constraints.maxWidth < 600;
              
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo Section
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: ProfileStyles.logoBoxDecoration,
                          child: const Icon(
                            Icons.shield_outlined,
                            size: 22,
                            color: ProfileStyles.primaryColor,
                          ),
                        ),
                        const SizedBox(width: 10),
                        if (!isSmallScreen)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('NeoBank', style: ProfileStyles.logoText),
                              Text('Admin Profile', style: ProfileStyles.logoSub),
                            ],
                          ),
                      ],
                    ),
                  ),
                  
                  // Header Actions
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Notification Button
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.notifications_outlined, color: Colors.white, size: 22),
                            onPressed: () {},
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFFF9C74F),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: isSmallScreen ? 12 : 16),
                      
                      // Profile Chip (hidden on small screens)
                      if (!isSmallScreen)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: ProfileStyles.profileChipDecoration,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF750505),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.person,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(adminData['name']!, style: ProfileStyles.chipName),
                                  Text(adminData['role']!, style: ProfileStyles.chipRole),
                                ],
                              ),
                            ],
                          ),
                        ),
                      SizedBox(width: isSmallScreen ? 0 : 16),
                      
                      // Logout Button
                      IconButton(
                        icon: const Icon(Icons.logout, color: Colors.white, size: 22),
                        onPressed: () {
                          Navigator.pushNamed(context, '/admin/');
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    
    return Container(
      decoration: ProfileStyles.cardDecoration,
      child: Column(
        children: [
          // Profile Header (Red Gradient)
          Container(
            height: 80,
            decoration: ProfileStyles.profileHeaderDecoration,
          ),
          
          // Profile Body
          Padding(
            padding: EdgeInsets.all(isMobile ? 16 : 24),
            child: Column(
              children: [
                // Top Section with Profile Pic and Actions
                isMobile ? _buildMobileProfileTop() : _buildDesktopProfileTop(),
                
                const SizedBox(height: 24),
                
                // Info Grid
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: isMobile ? 1 : 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: isMobile ? 4.5 : 3.5,
                  children: [
                    _buildInfoCard(Icons.person_outline, 'Employee ID', adminData['employeeId']!, Colors.blue),
                    _buildInfoCard(Icons.email_outlined, 'Email Address', adminData['email']!, const Color(0xFF6F42C1)),
                    _buildInfoCard(Icons.phone_outlined, 'Phone Number', adminData['phone']!, Colors.green),
                    _buildInfoCard(Icons.work_outline, 'Department', adminData['department']!, Colors.orange),
                    _buildInfoCard(Icons.location_city_outlined, 'Branch Location', adminData['branch']!, const Color(0xFF20C997)),
                    _buildTwoFactorCard(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopProfileTop() {
    return Transform.translate(
      offset: const Offset(0, -60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Picture
          Column(
            children: [
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  color: ProfileStyles.primaryColor,
                ),
                child: ClipOval(
                  child: Image.network(
                    adminData['profileImage']!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback widget when image fails to load
                      return Container(
                        color: ProfileStyles.primaryColor,
                        child: const Center(
                          child: Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.camera_alt, size: 16),
                label: const Text('Change Photo'),
                style: ProfileStyles.changePhotoButtonStyle,
              ),
            ],
          ),
          
          // Action Buttons
          Column(
            children: [
              const SizedBox(height: 72),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.edit, size: 16),
                    label: const Text('Edit Profile'),
                    style: ProfileStyles.editButtonStyle,
                  ),
                  const SizedBox(width: 10),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.lock_outline, size: 16),
                    label: const Text('Change Password'),
                    style: ProfileStyles.outlineButtonStyle,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMobileProfileTop() {
    return Transform.translate(
      offset: const Offset(0, -55),
      child: Column(
        children: [
          // Profile Picture
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
              color: ProfileStyles.primaryColor,
            ),
            child: ClipOval(
              child: Image.network(
                adminData['profileImage']!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback widget when image fails to load
                  return Container(
                    color: ProfileStyles.primaryColor,
                    child: const Center(
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.camera_alt, size: 14),
            label: const Text('Change Photo'),
            style: ProfileStyles.changePhotoButtonStyle,
          ),
          const SizedBox(height: 16),
          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit, size: 14),
                  label: const Text('Edit'),
                  style: ProfileStyles.editButtonStyle,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.lock_outline, size: 14),
                  label: const Text('Password'),
                  style: ProfileStyles.outlineButtonStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value, Color iconColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: ProfileStyles.infoCardDecoration,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: iconColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(label, style: ProfileStyles.infoLabel),
                Text(value, style: ProfileStyles.infoValue, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTwoFactorCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: ProfileStyles.infoCardDecoration,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.shield_outlined, size: 20, color: Colors.red),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Two-Factor Authentication', style: ProfileStyles.infoLabel),
                Text('Extra security layer', style: ProfileStyles.infoDesc),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                twoFactorEnabled = !twoFactorEnabled;
              });
            },
            child: Container(
              width: 42,
              height: 22,
              decoration: BoxDecoration(
                color: twoFactorEnabled ? const Color(0xFFCCE3D0) : const Color(0xFFF0F0F0),
                borderRadius: BorderRadius.circular(14),
              ),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 300),
                alignment: twoFactorEnabled ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: 18,
                  height: 18,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: twoFactorEnabled
                      ? const Center(
                          child: Icon(
                            Icons.check_circle,
                            size: 14,
                            color: ProfileStyles.primaryColor,
                          ),
                        )
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccessLogs() {
    return Container(
      decoration: ProfileStyles.cardDecoration,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.access_time, size: 18),
              const SizedBox(width: 8),
              Text('Access Log', style: ProfileStyles.sectionTitle),
            ],
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: accessLogs.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final log = accessLogs[index];
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: ProfileStyles.logItemDecoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.computer,
                            color: ProfileStyles.primaryColor,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(log['device']!, style: ProfileStyles.logDevice),
                                Text(log['location']!, style: ProfileStyles.logLocation),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('${log['date']} • ${log['time']}', style: ProfileStyles.logTime),
                        Row(
                          children: [
                            Text(log['ip']!, style: ProfileStyles.logIp),
                            const SizedBox(width: 6),
                            Icon(
                              log['status'] == 'success'
                                  ? Icons.check_circle
                                  : Icons.cancel,
                              size: 14,
                              color: log['status'] == 'success' ? Colors.green : Colors.red,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationPreferences() {
    final notificationItems = [
      {'key': 'transactionAlerts', 'label': 'Transaction Alerts', 'desc': 'Get notified about all transactions'},
      {'key': 'systemNotifications', 'label': 'System Notifications', 'desc': 'Important system updates'},
      {'key': 'newDeviceLogin', 'label': 'New Device Login', 'desc': 'Alert when logging from new device'},
      {'key': 'monthlyStatements', 'label': 'Monthly Statement Emails', 'desc': 'Receive monthly reports via email'},
    ];

    return Container(
      decoration: ProfileStyles.cardDecoration,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.notifications_outlined, size: 18),
              const SizedBox(width: 8),
              Text('Notification Preferences', style: ProfileStyles.sectionTitle),
            ],
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: notificationItems.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = notificationItems[index];
              final key = item['key']!;
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: ProfileStyles.notifItemDecoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item['label']!, style: ProfileStyles.notifLabel),
                          Text(item['desc']!, style: ProfileStyles.notifDesc),
                        ],
                      ),
                    ),
                    Switch(
                      value: notifications[key]!,
                      onChanged: (value) => handleNotificationToggle(key),
                      activeThumbColor: ProfileStyles.primaryColor,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityNote() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: ProfileStyles.securityNoteDecoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, size: 18, color: ProfileStyles.primaryColor),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Security Reminder', style: ProfileStyles.noteTitle),
                const SizedBox(height: 4),
                Text(
                  'Never share your login credentials with anyone. Bank administrators will never ask for your password.',
                  style: ProfileStyles.noteText,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
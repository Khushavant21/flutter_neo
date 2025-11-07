// lib/widgets/admin_setting_page.dart
import 'package:flutter/material.dart';
// import '../admin_top_navbar.dart';
import '../admin_setting/admin_setting_styles.dart';

class AdminSettingPage extends StatefulWidget {
  const AdminSettingPage({super.key});

  @override
  State<AdminSettingPage> createState() => _AdminSettingPageState();
}

class _AdminSettingPageState extends State<AdminSettingPage> {
  // Form visibility states
  bool showGeneralForm = false;
  bool showPersonalForm = false;
  bool showSecurityForm = false;
  String? activeSecurityRec;

  // Quick settings state
  Map<String, bool> quickSettings = {
    'biometricLogin': true,
    'transactionAlerts': true,
    'accountVisibility': false,
    'autoLock': true,
  };

  // Photo upload state
  String? photoPreview;

  // Security features state
  Map<String, dynamic> securityFeatures = {
    'twoFactorAuth': false,
    'biometricLogin': false,
    'passwordLastUpdated': null,
  };

  // Password form controllers
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // Success/error messages
  Map<String, String> securityMessage = {'type': '', 'text': ''};

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleToggle(String key, bool value) {
    setState(() {
      quickSettings[key] = value;
    });
  }

  void _handlePhotoUpload() {
    setState(() {
      photoPreview = 'assets/logo.png';
    });
    _showSnackBar('Photo uploaded successfully!');
  }

  void _removePhoto() {
    setState(() {
      photoPreview = null;
    });
  }

  void _handleEnable2FA() {
    setState(() {
      securityFeatures['twoFactorAuth'] = true;
      securityMessage = {
        'type': 'success',
        'text': 'Two-Factor Authentication has been enabled successfully!'
      };
    });
    _clearMessageAfterDelay();
  }

  void _handleDisable2FA() {
    setState(() {
      securityFeatures['twoFactorAuth'] = false;
      securityMessage = {
        'type': 'success',
        'text': 'Two-Factor Authentication has been disabled.'
      };
    });
    _clearMessageAfterDelay();
  }

  void _handleEnableBiometric() {
    setState(() {
      securityFeatures['biometricLogin'] = true;
      securityMessage = {
        'type': 'success',
        'text': 'Biometric Login has been enabled successfully!'
      };
    });
    _clearMessageAfterDelay();
  }

  void _handleDisableBiometric() {
    setState(() {
      securityFeatures['biometricLogin'] = false;
      securityMessage = {
        'type': 'success',
        'text': 'Biometric Login has been disabled.'
      };
    });
    _clearMessageAfterDelay();
  }

  void _handlePasswordUpdate() {
    if (newPasswordController.text != confirmPasswordController.text) {
      setState(() {
        securityMessage = {
          'type': 'error',
          'text': 'New passwords do not match!'
        };
      });
      _clearMessageAfterDelay();
      return;
    }

    if (newPasswordController.text.length < 8) {
      setState(() {
        securityMessage = {
          'type': 'error',
          'text': 'Password must be at least 8 characters long!'
        };
      });
      _clearMessageAfterDelay();
      return;
    }

    setState(() {
      securityFeatures['passwordLastUpdated'] = DateTime.now().toIso8601String();
      currentPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
      securityMessage = {
        'type': 'success',
        'text': 'Password updated successfully!'
      };
    });
    _clearMessageAfterDelay();
  }

  void _clearMessageAfterDelay() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          securityMessage = {'type': '', 'text': ''};
        });
      }
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: AdminSettingStyles.primaryRed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdminSettingStyles.bgLight,
      body: Column(
        children: [
          // const TopNavbar(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: AdminSettingStyles.containerPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAdminHeader(),
                    const SizedBox(height: 24),
                    _buildSettingsGrid(),
                    const SizedBox(height: 30),
                    _buildQuickSettings(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdminHeader() {
    return Container(
      decoration: AdminSettingStyles.adminHeaderDecoration,
      child: Stack(
        children: [
          Container(
            decoration: AdminSettingStyles.adminHeaderOverlay,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              children: [
                Text(
                  'Admin Settings',
                  style: AdminSettingStyles.adminTitle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  'Manage your preferences and security',
                  style: AdminSettingStyles.adminSubtitle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth <= 768;
        
        if (isMobile) {
          return Column(
            children: [
              _buildSettingsCard(
                title: 'General Settings',
                description: 'App preferences, language, and display settings',
                icon: '⚙️',
                iconColor: AdminSettingStyles.generalIconColor,
                isExpanded: showGeneralForm,
                onTap: () => setState(() => showGeneralForm = !showGeneralForm),
                formWidget: _buildGeneralForm(),
              ),
              const SizedBox(height: 16),
              _buildSettingsCard(
                title: 'Personal Details',
                description: 'Update your profile information and contact details',
                icon: '👤',
                iconColor: AdminSettingStyles.userIconColor,
                isExpanded: showPersonalForm,
                onTap: () => setState(() => showPersonalForm = !showPersonalForm),
                formWidget: _buildPersonalForm(),
              ),
              const SizedBox(height: 16),
              _buildSettingsCard(
                title: 'Security',
                description: 'Password, 2FA, and security preferences',
                icon: '🛡️',
                iconColor: AdminSettingStyles.shieldIconColor,
                isExpanded: showSecurityForm,
                onTap: () => setState(() => showSecurityForm = !showSecurityForm),
                formWidget: _buildSecurityForm(),
              ),
            ],
          );
        }
        
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.2,
          children: [
            _buildSettingsCard(
              title: 'General Settings',
              description: 'App preferences, language, and display settings',
              icon: '⚙️',
              iconColor: AdminSettingStyles.generalIconColor,
              isExpanded: showGeneralForm,
              onTap: () => setState(() => showGeneralForm = !showGeneralForm),
              formWidget: _buildGeneralForm(),
            ),
            _buildSettingsCard(
              title: 'Personal Details',
              description: 'Update your profile information and contact details',
              icon: '👤',
              iconColor: AdminSettingStyles.userIconColor,
              isExpanded: showPersonalForm,
              onTap: () => setState(() => showPersonalForm = !showPersonalForm),
              formWidget: _buildPersonalForm(),
            ),
            _buildSettingsCard(
              title: 'Security',
              description: 'Password, 2FA, and security preferences',
              icon: '🛡️',
              iconColor: AdminSettingStyles.shieldIconColor,
              isExpanded: showSecurityForm,
              onTap: () => setState(() => showSecurityForm = !showSecurityForm),
              formWidget: _buildSecurityForm(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSettingsCard({
    required String title,
    required String description,
    required String icon,
    required Color iconColor,
    required bool isExpanded,
    required VoidCallback onTap,
    required Widget formWidget,
  }) {
    return Container(
      decoration: AdminSettingStyles.settingsCardDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AdminSettingStyles.cardPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: AdminSettingStyles.cardIconDecoration(iconColor),
                      child: Center(
                        child: Text(icon, style: const TextStyle(fontSize: 18)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(title, style: AdminSettingStyles.cardTitle),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(description, style: AdminSettingStyles.cardDescription),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: onTap,
                  style: AdminSettingStyles.primaryButtonStyle,
                  child: Text('Configure', style: AdminSettingStyles.buttonText),
                ),
              ],
            ),
          ),
          if (isExpanded) formWidget,
        ],
      ),
    );
  }

  Widget _buildGeneralForm() {
    return Container(
      padding: AdminSettingStyles.formPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Edit General Settings', style: AdminSettingStyles.cardTitle),
          const SizedBox(height: 16),
          _buildFormField('Username / Display Name', 'Enter username'),
          _buildDropdownField('Language Preferences', ['English', 'Hindi', 'Spanish']),
          _buildDropdownField('Timezone / Region', ['India Standard Time (UTC+5:30)', 'Pacific Standard Time (UTC-8:00)', 'Greenwich Mean Time (UTC+0:00)']),
          _buildDropdownField('Notifications Preferences', ['All Notifications', 'Important Only', 'None']),
          _buildDropdownField('App/Theme Preferences', ['Light Mode', 'Dark Mode', 'System Default']),
          _buildFormActions(),
        ],
      ),
    );
  }

  Widget _buildPersonalForm() {
    return Container(
      padding: AdminSettingStyles.formPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Edit Personal Details', style: AdminSettingStyles.cardTitle),
          const SizedBox(height: 16),
          _buildPhotoUpload(),
          _buildFormField('Full Name', 'Enter full name'),
          _buildFormField('Email ID', 'Enter email', keyboardType: TextInputType.emailAddress),
          _buildFormField('Phone Number', 'Enter phone number', keyboardType: TextInputType.phone),
          _buildFormField('Date of Birth', 'Select date'),
          _buildFormField('Address (Optional)', 'Enter address', maxLines: 3),
          _buildFormActions(),
        ],
      ),
    );
  }

  Widget _buildSecurityForm() {
    return Container(
      padding: AdminSettingStyles.formPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Edit Security Settings', style: AdminSettingStyles.cardTitle),
          const SizedBox(height: 16),
          _buildFormField('Password Reset / Change Password', 'Enter new password', isPassword: true),
          _buildFormField('Confirm New Password', 'Confirm new password', isPassword: true),
          _buildDropdownField('Two-Factor Authentication (2FA)', ['Enabled', 'Disabled']),
          _buildDropdownField('Security Questions', ['What is your pet\'s name?', 'What is your favorite book?', 'What is your mother\'s maiden name?']),
          _buildFormField('Answer', 'Enter answer'),
          const SizedBox(height: 16),
          Text('Login Activity / Sessions', style: AdminSettingStyles.formLabel),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => _showSnackBar('Session management feature coming soon'),
            style: AdminSettingStyles.primaryButtonStyle,
            child: Text('View Sessions', style: AdminSettingStyles.buttonText),
          ),
          const SizedBox(height: 16),
          Text('Account Recovery Options', style: AdminSettingStyles.formLabel),
          _buildFormField('Recovery Email', 'Recovery email', keyboardType: TextInputType.emailAddress),
          _buildFormField('Recovery Phone Number', 'Recovery phone number', keyboardType: TextInputType.phone),
          _buildFormActions(),
        ],
      ),
    );
  }

  Widget _buildPhotoUpload() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Profile Photo', style: AdminSettingStyles.formLabel),
        const SizedBox(height: 8),
        Row(
          children: [
            InkWell(
              onTap: _handlePhotoUpload,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: AdminSettingStyles.photoUploadButtonDecoration,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('📷', style: TextStyle(fontSize: 18)),
                    const SizedBox(width: 8),
                    Text(
                      'Upload Photo',
                      style: AdminSettingStyles.formLabel.copyWith(color: AdminSettingStyles.primaryRed),
                    ),
                  ],
                ),
              ),
            ),
            if (photoPreview != null) ...[
              const SizedBox(width: 16),
              Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: AdminSettingStyles.photoPreviewDecoration.copyWith(
                      image: DecorationImage(
                        image: AssetImage(photoPreview!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: InkWell(
                      onTap: _removePhoto,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: AdminSettingStyles.removePhotoButtonDecoration,
                        child: const Center(
                          child: Text('✕', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildFormField(String label, String hint, {bool isPassword = false, int maxLines = 1, TextInputType? keyboardType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AdminSettingStyles.formLabel),
        const SizedBox(height: 4),
        TextField(
          obscureText: isPassword,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: AdminSettingStyles.inputDecoration(hint, label: null),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDropdownField(String label, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AdminSettingStyles.formLabel),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          decoration: AdminSettingStyles.inputDecoration('', label: null),
          items: options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? value) {},
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildFormActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              showGeneralForm = false;
              showPersonalForm = false;
              showSecurityForm = false;
            });
          },
          child: const Text('Cancel'),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () => _showSnackBar('Settings saved successfully!'),
          style: AdminSettingStyles.primaryButtonStyle,
          child: Text('Save', style: AdminSettingStyles.buttonText),
        ),
      ],
    );
  }

  Widget _buildQuickSettings() {
    return Container(
      padding: AdminSettingStyles.cardPadding,
      decoration: AdminSettingStyles.quickSettingsDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Quick Settings', style: AdminSettingStyles.sectionTitle),
          const SizedBox(height: 8),
          Text('Frequently used settings for quick access', style: AdminSettingStyles.sectionDescription),
          const SizedBox(height: 24),
          _buildToggleItem('👆', 'Biometric Login', 'biometricLogin'),
          _buildToggleItem('🔔', 'Transaction Alerts', 'transactionAlerts'),
          _buildToggleItem('👁️', 'Account Visibility', 'accountVisibility'),
          _buildToggleItem('🔒', 'Auto Lock', 'autoLock'),
          const SizedBox(height: 24),
          _buildAccountInfo(),
          const SizedBox(height: 24),
          _buildSecurityRecommendations(),
          if (securityMessage['text']!.isNotEmpty) ...[
            const SizedBox(height: 16),
            _buildSecurityMessage(),
          ],
        ],
      ),
    );
  }

  Widget _buildToggleItem(String icon, String label, String key) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: AdminSettingStyles.toggleItemDecoration,
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: AdminSettingStyles.toggleIconDecoration(AdminSettingStyles.primaryRed),
            child: Center(
              child: Text(icon, style: const TextStyle(fontSize: 14)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label, style: AdminSettingStyles.toggleLabel),
          ),
          Switch(
            value: quickSettings[key] ?? false,
            onChanged: (value) => _handleToggle(key, value),
            activeThumbColor: AdminSettingStyles.toggleActive,
          ),
        ],
      ),
    );
  }

  Widget _buildAccountInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Account Information and Status', style: AdminSettingStyles.sectionTitle),
        const SizedBox(height: 8),
        Text('Overview of your account settings and status', style: AdminSettingStyles.sectionDescription),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: constraints.maxWidth > 600 ? 2 : 1,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: constraints.maxWidth > 600 ? 4 : 6,
              children: [
                _buildStatusRow('Account Status', 'Active', AdminSettingStyles.enabledBlue),
                _buildStatusRow('Last Login', 'Today 10:30 AM', null),
                _buildStatusRow('KYC Status', 'Verified', AdminSettingStyles.verifiedGreen),
                _buildStatusRow('Mobile Verified', 'Yes', AdminSettingStyles.verifiedGreen),
                _buildStatusRow('Two-Factor Auth', 'Enabled', AdminSettingStyles.enabledBlue),
                _buildStatusRow('Email Verified', 'Yes', AdminSettingStyles.verifiedGreen),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildStatusRow(String label, String value, Color? valueColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: AdminSettingStyles.statusRowDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(label, style: AdminSettingStyles.statusLabel),
          ),
          Text(
            value,
            style: AdminSettingStyles.statusValue.copyWith(
              color: valueColor ?? AdminSettingStyles.textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityRecommendations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Security Recommendations', style: AdminSettingStyles.sectionTitle),
        const SizedBox(height: 8),
        Text('Improve your account security with these suggestions', style: AdminSettingStyles.sectionDescription),
        const SizedBox(height: 16),
        _buildSecurityRecItem(
          '2fa',
          '🔐',
          'Enable Two-Factor Authentication',
          'Add an extra layer of security to your account',
          _build2FAPanel(),
        ),
        _buildSecurityRecItem(
          'password',
          '🔑',
          'Update Password',
          'Use a strong, unique password and change it regularly',
          _buildPasswordPanel(),
        ),
        _buildSecurityRecItem(
          'biometric',
          '👆',
          'Enable Biometric Login',
          'Use fingerprint or face recognition for secure access',
          _buildBiometricPanel(),
        ),
      ],
    );
  }

  Widget _buildSecurityRecItem(String key, String icon, String title, String description, Widget panel) {
    final isActive = activeSecurityRec == key;
    return Column(
      children: [
        InkWell(
          onTap: () => setState(() => activeSecurityRec = isActive ? null : key),
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: AdminSettingStyles.recItemDecoration(isActive),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: AdminSettingStyles.recIconDecoration,
                  child: Center(
                    child: Text(icon, style: const TextStyle(fontSize: 16)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AdminSettingStyles.recTitle),
                      const SizedBox(height: 4),
                      Text(description, style: AdminSettingStyles.recDescription),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isActive)
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(20),
            decoration: AdminSettingStyles.recPanelDecoration,
            child: panel,
          ),
      ],
    );
  }

  Widget _build2FAPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Two-Factor Authentication', style: AdminSettingStyles.panelTitle),
        const SizedBox(height: 8),
        Text(
          'Add an extra layer of security to your account by enabling 2FA. You\'ll receive a verification code via SMS or authenticator app when signing in.',
          style: AdminSettingStyles.panelDescription,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Text('Status: ', style: AdminSettingStyles.formLabel),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: AdminSettingStyles.statusBadgeDecoration(securityFeatures['twoFactorAuth'] == true),
              child: Text(
                securityFeatures['twoFactorAuth'] == true ? 'ENABLED' : 'DISABLED',
                style: AdminSettingStyles.statusBadgeText.copyWith(
                  color: AdminSettingStyles.getStatusBadgeTextColor(securityFeatures['twoFactorAuth'] == true),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: securityFeatures['twoFactorAuth'] == true ? _handleDisable2FA : _handleEnable2FA,
          style: securityFeatures['twoFactorAuth'] == true
              ? AdminSettingStyles.dangerButtonStyle
              : AdminSettingStyles.primaryButtonStyle,
          child: Text(
            securityFeatures['twoFactorAuth'] == true ? 'Disable 2FA' : 'Enable 2FA',
            style: AdminSettingStyles.buttonText,
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Update Your Password', style: AdminSettingStyles.panelTitle),
        const SizedBox(height: 8),
        Text(
          'Use a strong, unique password and change it regularly. Avoid reusing passwords across services. Consider using a password manager to keep credentials secure.',
          style: AdminSettingStyles.panelDescription,
        ),
        if (securityFeatures['passwordLastUpdated'] != null) ...[
          const SizedBox(height: 12),
          Row(
            children: [
              Text('Last Updated: ', style: AdminSettingStyles.formLabel),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: AdminSettingStyles.statusBadgeDecoration(true),
                child: Text(
                  DateTime.parse(securityFeatures['passwordLastUpdated']).toLocal().toString().split(' ')[0],
                  style: AdminSettingStyles.statusBadgeText.copyWith(
                    color: AdminSettingStyles.getStatusBadgeTextColor(true),
                  ),
                ),
              ),
            ],
          ),
        ],
        const SizedBox(height: 16),
        TextField(
          controller: currentPasswordController,
          obscureText: true,
          decoration: AdminSettingStyles.inputDecoration('Enter current password', label: 'Current Password'),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: newPasswordController,
          obscureText: true,
          decoration: AdminSettingStyles.inputDecoration('Enter new password', label: 'New Password'),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: confirmPasswordController,
          obscureText: true,
          decoration: AdminSettingStyles.inputDecoration('Confirm new password', label: 'Confirm New Password'),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _handlePasswordUpdate,
          style: AdminSettingStyles.primaryButtonStyle,
          child: Text('Update Password', style: AdminSettingStyles.buttonText),
        ),
      ],
    );
  }

  Widget _buildBiometricPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Biometric Login', style: AdminSettingStyles.panelTitle),
        const SizedBox(height: 8),
        Text(
          'Turn on fingerprint or face recognition to sign in quickly and securely. Your biometric data never leaves your device; we store only a token to verify you.',
          style: AdminSettingStyles.panelDescription,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Text('Status: ', style: AdminSettingStyles.formLabel),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: AdminSettingStyles.statusBadgeDecoration(securityFeatures['biometricLogin'] == true),
              child: Text(
                securityFeatures['biometricLogin'] == true ? 'ENABLED' : 'DISABLED',
                style: AdminSettingStyles.statusBadgeText.copyWith(
                  color: AdminSettingStyles.getStatusBadgeTextColor(securityFeatures['biometricLogin'] == true),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: securityFeatures['biometricLogin'] == true ? _handleDisableBiometric : _handleEnableBiometric,
          style: securityFeatures['biometricLogin'] == true
              ? AdminSettingStyles.dangerButtonStyle
              : AdminSettingStyles.primaryButtonStyle,
          child: Text(
            securityFeatures['biometricLogin'] == true ? 'Disable Biometric' : 'Enable Biometric',
            style: AdminSettingStyles.buttonText,
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityMessage() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: AdminSettingStyles.securityMessageDecoration(securityMessage['type']!),
      child: Text(
        securityMessage['text']!,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AdminSettingStyles.getSecurityMessageTextColor(securityMessage['type']!),
        ),
      ),
    );
  }
}
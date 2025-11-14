import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'user_management_page.dart';

class UserProfileModal extends StatefulWidget {
  final UserData user;
  final Function(UserData) onUpdate;

  const UserProfileModal({
    super.key,
    required this.user,
    required this.onUpdate,
  });

  @override
  State<UserProfileModal> createState() => _UserProfileModalState();
}

class _UserProfileModalState extends State<UserProfileModal> {
  late UserData editableUser;
  Map<String, dynamic>? previewDoc;

  @override
  void initState() {
    super.initState();
    editableUser = UserData(
      id: widget.user.id,
      name: widget.user.name,
      fatherName: widget.user.fatherName,
      email: widget.user.email,
      phone: widget.user.phone,
      address: widget.user.address,
      account: widget.user.account,
      type: widget.user.type,
      balance: widget.user.balance,
      status: widget.user.status,
      frozen: widget.user.frozen,
      lastLogin: widget.user.lastLogin,
      photo: widget.user.photo,
      aadhaar: widget.user.aadhaar,
      aadhaarFront: widget.user.aadhaarFront,
      aadhaarBack: widget.user.aadhaarBack,
      pan: widget.user.pan,
      panCard: widget.user.panCard,
      signature: widget.user.signature,
      documents: List.from(widget.user.documents),
    );
  }

  void _handleChange(String field, dynamic value) {
    setState(() {
      switch (field) {
        case 'name':
          editableUser.name = value;
          break;
        case 'fatherName':
          editableUser.fatherName = value;
          break;
        case 'address':
          editableUser.address = value;
          break;
        case 'type':
          editableUser.type = value;
          break;
        case 'balance':
          editableUser.balance = double.tryParse(value.toString()) ?? editableUser.balance;
          break;
      }
    });
  }

  void _handleSaveChanges() {
    widget.onUpdate(editableUser);
    Navigator.of(context).pop();
  }

  String _formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_IN', symbol: '₹').format(amount);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 992;
    
    final docsArray = [
      {
        'title': 'Aadhaar',
        'imgs': [editableUser.aadhaarFront, editableUser.aadhaarBack]
      },
      {'title': 'PAN Card', 'img': editableUser.panCard},
      {'title': 'Signature', 'img': editableUser.signature},
      ...editableUser.documents.map((doc) => {'title': doc['name']!, 'img': doc['url']!}),
    ];

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(10),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: const BoxDecoration(
                color: Color(0xFF950606),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '${editableUser.name} — Profile',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: 24),
                    onPressed: () => Navigator.of(context).pop(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),

            // Body
            Flexible(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: isMobile
                      ? Column(
                          children: [
                            _buildProfileColumn(docsArray),
                            const SizedBox(height: 20),
                            _buildDetailsColumn(),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildProfileColumn(docsArray)),
                            const SizedBox(width: 20),
                            Expanded(flex: 2, child: _buildDetailsColumn()),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileColumn(List<Map<String, dynamic>> docsArray) {
    return Column(
      children: [
        // Profile Card
        InkWell(
          onTap: () {
            setState(() {
              previewDoc = {'title': 'Profile Photo', 'img': editableUser.photo};
            });
            _showPreviewModal();
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFA),
              border: Border.all(color: const Color(0xFFEEEEEE)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(editableUser.photo),
                  radius: 55,
                ),
                const SizedBox(height: 10),
                Text(
                  editableUser.name,
                  style: const TextStyle(fontSize: 17, color: Color(0xFF333333)),
                ),
                const SizedBox(height: 4),
                Text(
                  editableUser.email,
                  style: const TextStyle(fontSize: 13, color: Color(0xFF666666)),
                ),
                Text(
                  editableUser.phone,
                  style: const TextStyle(fontSize: 13, color: Color(0xFF666666)),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Status: ${editableUser.status}',
                      style: const TextStyle(fontSize: 12, color: Color(0xFF444444)),
                    ),
                    Text(
                      'Frozen: ${editableUser.frozen ? "Yes" : "No"}',
                      style: const TextStyle(fontSize: 12, color: Color(0xFF444444)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        // KYC Documents
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            border: Border.all(color: const Color(0xFFEEEEEE)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 6),
                decoration: const BoxDecoration(
                  border: Border(
                    left: BorderSide(color: Color(0xFF950606), width: 4),
                  ),
                ),
                child: const Text(
                  'KYC Documents',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 8),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.9,
                ),
                itemCount: docsArray.length,
                itemBuilder: (context, index) {
                  final doc = docsArray[index];
                  return _buildDocCard(doc);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDocCard(Map<String, dynamic> doc) {
    return InkWell(
      onTap: () {
        if (doc['img'] != null || doc['imgs'] != null) {
          setState(() {
            previewDoc = doc;
          });
          _showPreviewModal();
        }
      },
      child: Container(
        height: 160,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFDDDDDD)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: doc['imgs'] != null
                  ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: (doc['imgs'] as List).map((img) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.network(
                                img,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  : doc['img'] != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            doc['img'],
                            width: double.infinity,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Center(
                          child: Text(
                            '${doc['title']} not uploaded',
                            style: const TextStyle(fontSize: 12, color: Color(0xFF888888)),
                            textAlign: TextAlign.center,
                          ),
                        ),
            ),
            const SizedBox(height: 6),
            Text(
              doc['title'],
              style: const TextStyle(fontSize: 13, color: Color(0xFF333333), fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsColumn() {
    final fields = [
      {'label': 'Name', 'field': 'name', 'editable': true},
      {'label': "Father's Name", 'field': 'fatherName', 'editable': true},
      {'label': 'Address', 'field': 'address', 'editable': true},
      {'label': 'Aadhaar Number', 'field': 'aadhaar', 'editable': false},
      {'label': 'PAN Number', 'field': 'pan', 'editable': false},
      {'label': 'Account Number', 'field': 'account', 'editable': false},
      {'label': 'Account Type', 'field': 'type', 'editable': true},
      {'label': 'Balance', 'field': 'balance', 'editable': true},
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        border: Border.all(color: const Color(0xFFEEEEEE)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...fields.map((field) {
            String value;
            switch (field['field']) {
              case 'name':
                value = editableUser.name;
                break;
              case 'fatherName':
                value = editableUser.fatherName;
                break;
              case 'address':
                value = editableUser.address;
                break;
              case 'aadhaar':
                value = editableUser.aadhaar;
                break;
              case 'pan':
                value = editableUser.pan;
                break;
              case 'account':
                value = editableUser.account;
                break;
              case 'type':
                value = editableUser.type;
                break;
              case 'balance':
                value = _formatCurrency(editableUser.balance);
                break;
              default:
                value = '';
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    field['label'] as String,
                    style: const TextStyle(fontSize: 12, color: Color(0xFF444444)),
                  ),
                  const SizedBox(height: 4),
                  TextFormField(
                    initialValue: value,
                    readOnly: !(field['editable'] as bool),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Color(0xFFCCCCCC)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Color(0xFFCCCCCC)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Color(0xFF950606)),
                      ),
                      contentPadding: const EdgeInsets.all(7),
                      filled: !(field['editable'] as bool),
                      fillColor: !(field['editable'] as bool) ? const Color(0xFFF5F5F5) : Colors.white,
                    ),
                    style: const TextStyle(fontSize: 13),
                    onChanged: (newValue) {
                      if (field['editable'] as bool) {
                        _handleChange(field['field'] as String, newValue);
                      }
                    },
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEEEEEE),
                  foregroundColor: const Color(0xFF333333),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text('Close', style: TextStyle(fontSize: 13)),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _handleSaveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF950606),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text('Save Changes', style: TextStyle(fontSize: 13)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showPreviewModal() {
    if (previewDoc == null) return;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${previewDoc!['title']} Preview',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              if (previewDoc!['imgs'] != null)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: (previewDoc!['imgs'] as List).map((img) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            img,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                )
              else if (previewDoc!['img'] != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    previewDoc!['img'],
                    fit: BoxFit.contain,
                  ),
                ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        previewDoc = null;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEEEEEE),
                      foregroundColor: const Color(0xFF333333),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text('Close', style: TextStyle(fontSize: 13)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ).then((_) {
      setState(() {
        previewDoc = null;
      });
    });
  }
}

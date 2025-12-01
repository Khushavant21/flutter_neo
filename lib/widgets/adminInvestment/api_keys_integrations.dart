import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class APIKeysIntegrationsScreen extends StatefulWidget {
  final VoidCallback? onBack; // ✅ Added back callback for tab navigation

  const APIKeysIntegrationsScreen({super.key, this.onBack});

  @override
  State<APIKeysIntegrationsScreen> createState() =>
      _APIKeysIntegrationsScreenState();
}

class _APIKeysIntegrationsScreenState extends State<APIKeysIntegrationsScreen> {
  List<Map<String, dynamic>> keys = [
    {
      "id": 1,
      "name": "Payment Gateway Key",
      "status": "Active",
      "created": "2025-09-01",
      "value": "abc123xyz",
    },
    {
      "id": 2,
      "name": "Biller Integration Key",
      "status": "Disabled",
      "created": "2025-08-25",
      "value": "def456uvw",
    },
  ];

  bool showModal = false;
  String newKeyName = "";

  Color getStatusColor(String status) {
    if (status == "Active") return Colors.green;
    if (status == "Disabled") return Colors.red;
    return Colors.grey;
  }

  void toggleStatus(int id) {
    setState(() {
      for (var key in keys) {
        if (key["id"] == id) {
          key["status"] = key["status"] == "Active" ? "Disabled" : "Active";
        }
      }
    });
  }

  void handleCopyKey(String value) {
    Clipboard.setData(ClipboardData(text: value));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("API Key copied to clipboard!")),
    );
  }

  void handleRevokeKey(int id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Revoke API Key"),
        content: const Text("Are you sure you want to revoke this API key?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF900603),
            ),
            onPressed: () {
              setState(() {
                keys.removeWhere((e) => e["id"] == id);
              });
              Navigator.pop(ctx);
            },
            child: const Text("Revoke", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void handleGenerateKey() {
    if (newKeyName.trim().isEmpty) return;

    setState(() {
      final random = Random();
      final newKey = List.generate(
        12,
        (_) => String.fromCharCode(random.nextInt(26) + 97),
      ).join();

      keys.add({
        "id": keys.length + 1,
        "name": newKeyName,
        "status": "Active",
        "created": DateTime.now().toString().substring(0, 10),
        "value": newKey,
      });

      newKeyName = "";
      showModal = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return WillPopScope(
      onWillPop: () async {
        if (widget.onBack != null) {
          widget.onBack!(); // ✅ Use tab back instead of Navigator.pop
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: AppBar(
          automaticallyImplyLeading: widget.onBack != null,
          leading: widget.onBack != null
              ? IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: widget.onBack, // ✅ Back works now
                )
              : null,
          title: const Text(
            "API Keys & Integrations",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          backgroundColor: const Color(0xFF900603),
          centerTitle: true,
          elevation: 4,
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: const Color(0xFF900603),
          onPressed: () => setState(() => showModal = true),
          label: const Text(
            "Generate API Key",
            style: TextStyle(color: Colors.white),
          ),
          icon: const Icon(Icons.add, color: Colors.white),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: isMobile ? _buildMobileView() : _buildDesktopView(),
              ),
            ),
            if (showModal) _buildNewKeyModal(),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileView() {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: keys.length,
      itemBuilder: (context, index) {
        final k = keys[index];
        final statusColor = getStatusColor(k["status"]);

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  k["name"],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text("Created: ${k["created"]}"),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    k["status"],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => handleCopyKey(k["value"]),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF900603),
                        ),
                        child: const Text(
                          "Copy",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => toggleStatus(k["id"]),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF900603),
                        ),
                        child: Text(
                          k["status"] == "Active" ? "Disable" : "Enable",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => handleRevokeKey(k["id"]),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF900603),
                        ),
                        child: const Text(
                          "Revoke",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDesktopView() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        headingRowColor: MaterialStateProperty.all(const Color(0xFF900603)),
        columns: const [
          DataColumn(label: Text("Key Name")),
          DataColumn(label: Text("Status")),
          DataColumn(label: Text("Created")),
          DataColumn(label: Text("Actions")),
        ],
        rows: keys.map((k) {
          return DataRow(
            cells: [
              DataCell(Text(k["name"])),
              DataCell(
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: getStatusColor(k["status"]),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    k["status"],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              DataCell(Text(k["created"])),
              DataCell(
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => handleCopyKey(k["value"]),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF900603),
                      ),
                      child: const Text(
                        "Copy",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 6),
                    ElevatedButton(
                      onPressed: () => toggleStatus(k["id"]),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF900603),
                      ),
                      child: Text(
                        k["status"] == "Active" ? "Disable" : "Enable",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 6),
                    ElevatedButton(
                      onPressed: () => handleRevokeKey(k["id"]),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF900603),
                      ),
                      child: const Text(
                        "Revoke",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildNewKeyModal() {
    return Container(
      color: Colors.black45,
      child: Center(
        child: Container(
          width: 380,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Generate New API Key",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 14),
              TextField(
                decoration: InputDecoration(
                  labelText: "Key Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (v) => setState(() => newKeyName = v),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => setState(() => showModal = false),
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: handleGenerateKey,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF900603),
                    ),
                    child: const Text(
                      "Generate",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

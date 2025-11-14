import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class APIKeysIntegrationsScreen extends StatefulWidget {
  final VoidCallback? onBack;
  
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

  void toggleStatus(int id) {
    setState(() {
      for (var key in keys) {
        if (key["id"] == id) {
          key["status"] = key["status"] == "Active" ? "Disabled" : "Active";
        }
      }
    });
  }

  void handleGenerateKey() {
    if (newKeyName.trim().isEmpty) return;

    setState(() {
      final random = Random();
      final randomValue = List.generate(
        10,
        (_) => String.fromCharCode(random.nextInt(26) + 97),
      ).join();

      keys.add({
        "id": keys.length + 1,
        "name": newKeyName,
        "status": "Active",
        "created": DateTime.now().toIso8601String().substring(0, 10),
        "value": randomValue,
      });

      newKeyName = "";
      showModal = false;
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
            onPressed: () {
              setState(() {
                keys.removeWhere((k) => k["id"] == id);
              });
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Revoke"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
        title: const Text("API Keys & Integrations"),
        backgroundColor: const Color(0xFF900603),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF900603),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                onPressed: () => setState(() => showModal = true),
                child: const Text("Generate New API Key"),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: isMobile
                    ? ListView.builder(
                        padding: const EdgeInsets.all(10),
                        itemCount: keys.length,
                        itemBuilder: (context, index) {
                          final k = keys[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 4,
                            ),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    k["name"],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text("Status: ${k["status"]}"),
                                  Text("Created: ${k["created"]}"),
                                  const SizedBox(height: 10),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () =>
                                            handleCopyKey(k["value"]),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(
                                            0xFF28A745,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 14,
                                            vertical: 8,
                                          ),
                                        ),
                                        child: const Text("Copy"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () => toggleStatus(k["id"]),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              k["status"] == "Active"
                                              ? const Color(0xFFDC3545)
                                              : const Color(0xFF28A745),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 14,
                                            vertical: 8,
                                          ),
                                        ),
                                        child: Text(
                                          k["status"] == "Active"
                                              ? "Disable"
                                              : "Enable",
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () =>
                                            handleRevokeKey(k["id"]),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(
                                            0xFF6C757D,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 14,
                                            vertical: 8,
                                          ),
                                        ),
                                        child: const Text("Revoke"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          headingRowColor: WidgetStateColor.resolveWith(
                            (states) => const Color(0xFF900603),
                          ),
                          headingTextStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          columns: const [
                            DataColumn(label: Text("Key Name")),
                            DataColumn(label: Text("Status")),
                            DataColumn(label: Text("Created Date")),
                            DataColumn(label: Text("Actions")),
                          ],
                          rows: keys
                              .map(
                                (k) => DataRow(
                                  cells: [
                                    DataCell(Text(k["name"])),
                                    DataCell(Text(k["status"])),
                                    DataCell(Text(k["created"])),
                                    DataCell(
                                      Row(
                                        children: [
                                          ElevatedButton(
                                            onPressed: () =>
                                                handleCopyKey(k["value"]),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: const Color(
                                                0xFF28A745,
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 6,
                                                  ),
                                            ),
                                            child: const Text("Copy"),
                                          ),
                                          const SizedBox(width: 8),
                                          ElevatedButton(
                                            onPressed: () =>
                                                toggleStatus(k["id"]),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  k["status"] == "Active"
                                                  ? const Color(0xFFDC3545)
                                                  : const Color(0xFF28A745),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 6,
                                                  ),
                                            ),
                                            child: Text(
                                              k["status"] == "Active"
                                                  ? "Disable"
                                                  : "Enable",
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          ElevatedButton(
                                            onPressed: () =>
                                                handleRevokeKey(k["id"]),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: const Color(
                                                0xFF6C757D,
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 6,
                                                  ),
                                            ),
                                            child: const Text("Revoke"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: showModal
          ? Container(
              color: Colors.black54,
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Generate New API Key",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: () =>
                                  setState(() => showModal = false),
                              icon: const Icon(Icons.close),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          decoration: InputDecoration(
                            labelText: "Key Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFF900603),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onChanged: (v) => setState(() => newKeyName = v),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () =>
                                  setState(() => showModal = false),
                              child: const Text("Cancel"),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: handleGenerateKey,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF900603),
                              ),
                              child: const Text("Generate"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
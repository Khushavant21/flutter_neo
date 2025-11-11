import 'package:flutter/material.dart';

class ServicesMerchantScreen extends StatefulWidget {
  const ServicesMerchantScreen({super.key});

  @override
  State<ServicesMerchantScreen> createState() => _ServicesMerchantScreenState();
}

class _ServicesMerchantScreenState extends State<ServicesMerchantScreen> {
  List<Map<String, dynamic>> merchants = [
    {
      "id": 1,
      "name": "Merchant A",
      "service": "Payment Gateway",
      "serviceType": "UPI",
      "status": "Enabled",
      "merchantId": "M001",
    },
    {
      "id": 2,
      "name": "Merchant B",
      "service": "Bill Payment",
      "serviceType": "NetBanking",
      "status": "Disabled",
      "merchantId": "M002",
    },
    {
      "id": 3,
      "name": "Merchant C",
      "service": "Wallet Integration",
      "serviceType": "Wallet",
      "status": "Enabled",
      "merchantId": "M003",
    },
  ];

  bool showModal = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController merchantIdController = TextEditingController();
  final TextEditingController serviceController = TextEditingController();
  String? selectedServiceType;

  final List<String> serviceTypes = ["UPI", "NetBanking", "Cards", "Wallet"];

  void toggleStatus(int id) {
    setState(() {
      for (var m in merchants) {
        if (m["id"] == id) {
          m["status"] = m["status"] == "Enabled" ? "Disabled" : "Enabled";
        }
      }
    });
  }

  void addMerchant() {
    if (nameController.text.isEmpty ||
        merchantIdController.text.isEmpty ||
        serviceController.text.isEmpty ||
        selectedServiceType == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    setState(() {
      final nextId = merchants.length + 1;
      merchants.add({
        "id": nextId,
        "name": nameController.text,
        "merchantId": merchantIdController.text,
        "service": serviceController.text,
        "serviceType": selectedServiceType,
        "status": "Enabled",
      });
      nameController.clear();
      merchantIdController.clear();
      serviceController.clear();
      selectedServiceType = null;
      showModal = false;
    });
  }

  Widget statusBadge(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: status == "Enabled"
            ? const Color(0xFF28A745)
            : const Color(0xFFDC3545),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget buildTable(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: isSmallScreen ? 20 : 40,
        headingRowColor: MaterialStateColor.resolveWith(
          (_) => const Color(0xFF900603),
        ),
        headingTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        columns: const [
          DataColumn(label: Text("Name")),
          DataColumn(label: Text("ID")),
          DataColumn(label: Text("Service")),
          DataColumn(label: Text("Type")),
          DataColumn(label: Text("Status")),
          DataColumn(label: Text("Action")),
        ],
        rows: merchants
            .map(
              (m) => DataRow(
                cells: [
                  DataCell(
                    Text(m["name"], style: const TextStyle(fontSize: 13)),
                  ),
                  DataCell(
                    Text(m["merchantId"], style: const TextStyle(fontSize: 13)),
                  ),
                  DataCell(
                    Text(m["service"], style: const TextStyle(fontSize: 13)),
                  ),
                  DataCell(
                    Text(
                      m["serviceType"],
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  DataCell(statusBadge(m["status"])),
                  DataCell(
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: m["status"] == "Enabled"
                            ? const Color(0xFFDC3545)
                            : const Color(0xFF28A745),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        minimumSize: const Size(70, 35),
                      ),
                      onPressed: () => toggleStatus(m["id"]),
                      child: Text(
                        m["status"] == "Enabled" ? "Disable" : "Enable",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget buildModal(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Container(
      color: Colors.black54,
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            width: isSmallScreen ? screenWidth * 0.9 : 500,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(color: Colors.black26, blurRadius: 10),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Add Merchant / Service",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF900603),
                      ),
                    ),
                    IconButton(
                      onPressed: () => setState(() => showModal = false),
                      icon: const Icon(Icons.close, color: Color(0xFF900603)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Merchant Details
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Merchant Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: merchantIdController,
                  decoration: const InputDecoration(
                    labelText: "Merchant ID",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: serviceController,
                  decoration: const InputDecoration(
                    labelText: "Service Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: "Service Type",
                    border: OutlineInputBorder(),
                  ),
                  value: selectedServiceType,
                  items: serviceTypes
                      .map(
                        (type) =>
                            DropdownMenuItem(value: type, child: Text(type)),
                      )
                      .toList(),
                  onChanged: (val) => setState(() {
                    selectedServiceType = val;
                  }),
                ),
                const SizedBox(height: 20),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => setState(() => showModal = false),
                      child: const Text("Cancel"),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: addMerchant,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF900603),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                      child: const Text("Add Merchant"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text("Services & Merchant Integrations"),
        backgroundColor: const Color(0xFF900603),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add, size: 18, color: Colors.white),
                  label: const Text("Add Merchant / Service"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF900603),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                  ),
                  onPressed: () => setState(() => showModal = true),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: SingleChildScrollView(child: buildTable(context)),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: showModal ? buildModal(context) : null,
    );
  }
}

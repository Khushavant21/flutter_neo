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

  void toggleStatus(int id) {
    setState(() {
      merchants = merchants.map((m) {
        if (m["id"] == id) {
          return {
            ...m,
            "status": m["status"] == "Enabled" ? "Disabled" : "Enabled",
          };
        }
        return m;
      }).toList();
    });
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Enabled":
        return Colors.green;
      case "Disabled":
        return Colors.red;
      default:
        return Colors.amber;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        automaticallyImplyLeading: isMobile ? true : false,
        leading: isMobile
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        title: const Text(
          "Services & Merchant Integrations",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: const Color(0xFF900603),
        centerTitle: true,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: isMobile ? _buildMobileView() : _buildDesktopView(),
        ),
      ),
    );
  }

  /// 📱 Mobile Card Layout
  Widget _buildMobileView() {
    return ListView.builder(
      itemCount: merchants.length,
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, index) {
        final m = merchants[index];
        final statusColor = getStatusColor(m["status"]);

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                m["name"],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "ID: ${m["merchantId"]}",
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    "Type: ${m["serviceType"]}",
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                "Service: ${m["service"]}",
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 10),
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
                  m["status"],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF900603),
                      ),
                      onPressed: () => toggleStatus(m["id"]),
                      child: Text(
                        m["status"] == "Enabled" ? "Disable" : "Enable",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  /// 💻 Desktop / Tablet DataTable Layout
  Widget _buildDesktopView() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: WidgetStateProperty.all(const Color(0xFF900603)),
        headingTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        columnSpacing: 30,
        columns: const [
          DataColumn(label: Text("Merchant Name")),
          DataColumn(label: Text("Merchant ID")),
          DataColumn(label: Text("Service")),
          DataColumn(label: Text("Type")),
          DataColumn(label: Text("Status")),
          DataColumn(label: Text("Actions")),
        ],
        rows: merchants.map((m) {
          final statusColor = getStatusColor(m["status"]);

          return DataRow(
            cells: [
              DataCell(Text(m["name"])),
              DataCell(Text(m["merchantId"])),
              DataCell(Text(m["service"])),
              DataCell(Text(m["serviceType"])),
              DataCell(
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
                    m["status"],
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              DataCell(
                ElevatedButton(
                  onPressed: () => toggleStatus(m["id"]),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF900603),
                  ),
                  child: Text(
                    m["status"] == "Enabled" ? "Disable" : "Enable",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

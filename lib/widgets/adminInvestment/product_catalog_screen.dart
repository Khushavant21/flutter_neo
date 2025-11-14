import 'package:flutter/material.dart';

class ProductCatalogScreen extends StatefulWidget {
  const ProductCatalogScreen({super.key});

  @override
  State<ProductCatalogScreen> createState() => _ProductCatalogScreenState();
}

class _ProductCatalogScreenState extends State<ProductCatalogScreen> {
  List<Map<String, dynamic>> products = [
    {
      "id": 1,
      "name": "Mutual Fund A",
      "category": "Equity",
      "amount": "\$5000",
      "status": "Pending",
    },
    {
      "id": 2,
      "name": "Bond B",
      "category": "Debt",
      "amount": "\$3000",
      "status": "Approved",
    },
    {
      "id": 3,
      "name": "Mutual Fund C",
      "category": "Hybrid",
      "amount": "\$7000",
      "status": "Pending",
    },
  ];

  void handleApprove(int id) {
    setState(() {
      products = products.map((p) {
        if (p["id"] == id) return {...p, "status": "Approved"};
        return p;
      }).toList();
    });
  }

  void handleReject(int id) {
    setState(() {
      products = products.map((p) {
        if (p["id"] == id) return {...p, "status": "Rejected"};
        return p;
      }).toList();
    });
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Approved":
        return Colors.green;
      case "Rejected":
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

      /// 🚫 REMOVE BACK BUTTON
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Product Catalog",
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
                color: Colors.black.withOpacity(0.08),
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

  /// 📱 MOBILE VIEW (Card View)
  Widget _buildMobileView() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: products.length,
      itemBuilder: (context, index) {
        final p = products[index];
        final statusColor = getStatusColor(p["status"]);

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                p["name"],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Category: ${p["category"]}",
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    "Amount: ${p["amount"]}",
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
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
                  p["status"],
                  style: TextStyle(
                    color: p["status"] == "Pending"
                        ? Colors.black
                        : Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              if (p["status"] == "Pending")
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => handleApprove(p["id"]),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF900603),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Approve",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => handleReject(p["id"]),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF900603),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Reject",
                          style: TextStyle(color: Colors.white),
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

  /// 💻 DESKTOP VIEW (Table)
  Widget _buildDesktopView() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: WidgetStateProperty.all(const Color(0xFF900603)),
        headingTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),

        columns: const [
          DataColumn(label: Text("Product Name")),
          DataColumn(label: Text("Category")),
          DataColumn(label: Text("Amount")),
          DataColumn(label: Text("Status")),
          DataColumn(label: Text("Actions")),
        ],

        rows: products.map((p) {
          final statusColor = getStatusColor(p["status"]);

          return DataRow(
            cells: [
              DataCell(Text(p["name"])),
              DataCell(Text(p["category"])),
              DataCell(Text(p["amount"])),

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
                    p["status"],
                    style: TextStyle(
                      color: p["status"] == "Pending"
                          ? Colors.black
                          : Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              DataCell(
                p["status"] == "Pending"
                    ? Row(
                        children: [
                          ElevatedButton(
                            onPressed: () => handleApprove(p["id"]),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF900603),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                            ),
                            child: const Text(
                              "Approve",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () => handleReject(p["id"]),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF900603),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                            ),
                            child: const Text(
                              "Reject",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      )
                    : const Text("-"),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

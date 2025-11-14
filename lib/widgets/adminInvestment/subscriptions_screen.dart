import 'package:flutter/material.dart';

class SubscriptionsScreen extends StatefulWidget {
  const SubscriptionsScreen({super.key});

  @override
  State<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  List<Map<String, dynamic>> subscriptions = [
    {
      "id": 1,
      "user": "Ram Kumar",
      "type": "Subscription",
      "amount": "\$1000",
      "status": "Pending",
    },
    {
      "id": 2,
      "user": "Sita Sharma",
      "type": "Redemption",
      "amount": "\$500",
      "status": "Pending",
    },
    {
      "id": 3,
      "user": "Amit Singh",
      "type": "Subscription",
      "amount": "\$2000",
      "status": "Approved",
    },
  ];

  void handleApprove(int id) {
    setState(() {
      subscriptions = subscriptions.map((sub) {
        if (sub["id"] == id) {
          return {...sub, "status": "Approved"};
        }
        return sub;
      }).toList();
    });
  }

  void handleReject(int id) {
    setState(() {
      subscriptions = subscriptions.map((sub) {
        if (sub["id"] == id) {
          return {...sub, "status": "Rejected"};
        }
        return sub;
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

      appBar: AppBar(
        automaticallyImplyLeading: false, // 🔥 REMOVE BACK BUTTON
        title: const Text(
          "Subscriptions / Redemptions",
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

  /// 📱 Mobile Layout
  Widget _buildMobileView() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: subscriptions.length,
      itemBuilder: (context, index) {
        final sub = subscriptions[index];
        final statusColor = getStatusColor(sub["status"]);

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sub["user"],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Type: ${sub["type"]}",
                      style: const TextStyle(fontSize: 14),
                    ),
                    Text(
                      "Amount: ${sub["amount"]}",
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
                    sub["status"],
                    style: TextStyle(
                      color: sub["status"] == "Pending"
                          ? Colors.black
                          : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                if (sub["status"] == "Pending")
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => handleApprove(sub["id"]),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF900603),
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
                          onPressed: () => handleReject(sub["id"]),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF900603),
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
          ),
        );
      },
    );
  }

  /// 💻 Desktop Layout
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
          DataColumn(label: Text("User")),
          DataColumn(label: Text("Type")),
          DataColumn(label: Text("Amount")),
          DataColumn(label: Text("Status")),
          DataColumn(label: Text("Actions")),
        ],
        rows: subscriptions.map((sub) {
          final statusColor = getStatusColor(sub["status"]);
          return DataRow(
            cells: [
              DataCell(Text(sub["user"])),
              DataCell(Text(sub["type"])),
              DataCell(Text(sub["amount"])),
              DataCell(
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    sub["status"],
                    style: TextStyle(
                      color: sub["status"] == "Pending"
                          ? Colors.black
                          : Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              DataCell(
                sub["status"] == "Pending"
                    ? Row(
                        children: [
                          ElevatedButton(
                            onPressed: () => handleApprove(sub["id"]),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF900603),
                            ),
                            child: const Text(
                              "Approve",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () => handleReject(sub["id"]),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF900603),
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

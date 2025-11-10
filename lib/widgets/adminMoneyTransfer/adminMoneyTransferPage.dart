import 'package:flutter/material.dart';
import '../adminMoneyTransfer/adminMoneyTransferStyles.dart';

class MoneyTransferRequests extends StatefulWidget {
  const MoneyTransferRequests({Key? key}) : super(key: key);

  @override
  State<MoneyTransferRequests> createState() => _MoneyTransferRequestsState();
}

class _MoneyTransferRequestsState extends State<MoneyTransferRequests> {
  String activeTab = "transfers";
  String search = "";
  String statusFilter = "All";

  List<Map<String, dynamic>> requests = [];
  List<Map<String, dynamic>> outgoing = [];
  List<Map<String, dynamic>> incoming = [];
  List<Map<String, dynamic>> beneficiaries = [];
  List<Map<String, dynamic>> bills = [];

  @override
  void initState() {
    super.initState();
    // mock data
    requests = [
      {
        "id": "REQ001",
        "date": "2025-09-16 10:32 AM",
        "senderName": "Amit Sharma",
        "senderAcc": "1234567890",
        "receiverName": "Rahul Verma",
        "receiverAcc": "9876543210",
        "amount": 25000,
        "currency": "INR",
        "method": "NEFT",
        "status": "Pending"
      },
      {
        "id": "REQ002",
        "date": "2025-09-15 02:45 PM",
        "senderName": "Sanya Kapoor",
        "senderAcc": "2223334445",
        "receiverName": "Arjun Mehta",
        "receiverAcc": "9998887776",
        "amount": 5000,
        "currency": "INR",
        "method": "UPI",
        "status": "Approved"
      }
    ];

    outgoing = [
      {
        "id": "OUT001",
        "date": "2025-09-20",
        "beneficiary": "Neha Singh",
        "amount": 12000,
        "currency": "INR",
        "type": "Scheduled"
      },
      {
        "id": "OUT002",
        "date": "2025-09-21",
        "beneficiary": "Vikram Rao",
        "amount": 7500,
        "currency": "INR",
        "type": "Queued"
      }
    ];

    incoming = [
      {
        "id": "IN001",
        "date": "2025-09-19",
        "sender": "Global Corp Ltd.",
        "amount": 500000,
        "currency": "INR",
        "review": "Pending"
      },
      {
        "id": "IN002",
        "date": "2025-09-18",
        "sender": "Overseas Bank",
        "amount": 250000,
        "currency": "INR",
        "review": "Approved"
      }
    ];

    beneficiaries = [
      {
        "id": "BENE001",
        "name": "Ravi Sharma",
        "account": "5551112223",
        "bank": "HDFC Bank",
        "status": "Pending"
      },
      {
        "id": "BENE002",
        "name": "Meena Kumari",
        "account": "7778889991",
        "bank": "ICICI Bank",
        "status": "Approved"
      }
    ];

    bills = [
      {
        "id": "BILL001",
        "date": "2025-09-17",
        "biller": "Electricity Board",
        "amount": 3500,
        "currency": "INR",
        "status": "Pending"
      },
      {
        "id": "BILL002",
        "date": "2025-09-16",
        "biller": "Mobile Operator",
        "amount": 899,
        "currency": "INR",
        "status": "Approved"
      }
    ];
  }

  void handleAction(String id, String action, String type) {
    setState(() {
      if (type == "request") {
        requests = requests
            .map((r) => r["id"] == id ? {...r, "status": action} : r)
            .toList();
      } else if (type == "incoming") {
        incoming = incoming
            .map((r) => r["id"] == id ? {...r, "review": action} : r)
            .toList();
      } else if (type == "beneficiary") {
        beneficiaries = beneficiaries
            .map((r) => r["id"] == id ? {...r, "status": action} : r)
            .toList();
      } else if (type == "bill") {
        bills =
            bills.map((r) => r["id"] == id ? {...r, "status": action} : r).toList();
      }
    });
  }

  List<Map<String, dynamic>> get filteredRequests {
    final q = search.toLowerCase();
    return requests.where((req) {
      final matchesSearch = req["senderName"].toLowerCase().contains(q) ||
          req["receiverName"].toLowerCase().contains(q) ||
          req["id"].toLowerCase().contains(q);
      final matchesStatus =
          statusFilter == "All" || req["status"] == statusFilter;
      return matchesSearch && matchesStatus;
    }).toList();
  }

  Widget buildTabButton(String label, String key) {
    final isActive = activeTab == key;
    return GestureDetector(
      onTap: () => setState(() => activeTab = key),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppTheme.primaryColor : const Color(0xFFE5E5E5),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget buildActionButton(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 2,
              offset: const Offset(0, 1),
            )
          ],
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.black87),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                width: double.infinity,
                color: AppTheme.primaryColor,
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 12 : 16,
                  vertical: isMobile ? 16 : 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Money Transfer Request",
                      style: TextStyle(
                        fontSize: isMobile ? 18 : 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: isMobile ? 4 : 6),
                    Text(
                      "Review and approve pending money transfer requests from users.",
                      style: TextStyle(
                        fontSize: isMobile ? 11 : 13,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Tabs
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    buildTabButton("Money Transfers", "transfers"),
                    const SizedBox(width: 6),
                    buildTabButton("Outgoing", "outgoing"),
                    const SizedBox(width: 6),
                    buildTabButton("Incoming", "incoming"),
                    const SizedBox(width: 6),
                    buildTabButton("Beneficiary", "beneficiaries"),
                    const SizedBox(width: 6),
                    buildTabButton("Bill Payments", "bills"),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              if (activeTab == "transfers") buildTransfersTab(isMobile),
              if (activeTab == "outgoing") buildOutgoingTab(isMobile),
              if (activeTab == "incoming") buildIncomingTab(isMobile),
              if (activeTab == "beneficiaries") buildBeneficiariesTab(isMobile),
              if (activeTab == "bills") buildBillsTab(isMobile),
            ],
          ),
        ),
      ),
    );
  }

  // ---- Tab Builders ----
  Widget buildTransfersTab(bool isMobile) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // filters
          Column(
            children: [
              TextField(
                decoration: AppTheme.inputDecoration(
                    hint: "Search by ID, Sender..."),
                onChanged: (v) => setState(() => search = v),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.white,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: statusFilter,
                    isExpanded: true,
                    onChanged: (val) => setState(() => statusFilter = val!),
                    items: const [
                      DropdownMenuItem(value: "All", child: Text("All Status")),
                      DropdownMenuItem(value: "Pending", child: Text("Pending")),
                      DropdownMenuItem(value: "Approved", child: Text("Approved")),
                      DropdownMenuItem(value: "Rejected", child: Text("Rejected")),
                      DropdownMenuItem(value: "On Hold", child: Text("On Hold")),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Cards for mobile, table for desktop
          if (isMobile)
            Column(
              children: filteredRequests.isNotEmpty
                  ? filteredRequests.map((req) => _buildMobileCard(req, "request")).toList()
                  : [const Center(child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text("No requests found"),
                    ))],
            )
          else
            AppTheme.tableCard(
              title: "Money Transfers",
              child: Column(
                children: filteredRequests.isNotEmpty
                    ? filteredRequests.map((req) {
                        return AppTheme.tableRow([
                          req["id"],
                          req["date"],
                          "${req["senderName"]}\n${req["senderAcc"]}",
                          "${req["receiverName"]}\n${req["receiverAcc"]}",
                          "${req["currency"]} ${req["amount"]}",
                          req["method"],
                          AppTheme.statusBadge(req["status"]),
                          Row(
                            children: [
                              buildActionButton("Approve", () {
                                handleAction(req["id"], "Approved", "request");
                              }),
                              buildActionButton("Reject", () {
                                handleAction(req["id"], "Rejected", "request");
                              }),
                              buildActionButton("Hold", () {
                                handleAction(req["id"], "On Hold", "request");
                              }),
                              buildActionButton("Pending", () {
                                handleAction(req["id"], "Pending", "request");
                              }),
                            ],
                          )
                        ]);
                      }).toList()
                    : [AppTheme.noDataRow("No requests found")],
              ),
            ),
        ],
      ),
    );
  }

  Widget buildOutgoingTab(bool isMobile) {
    if (isMobile) {
      return Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Queued / Scheduled Outgoing Transfers",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 12),
            ...outgoing.map((o) => _buildSimpleCard([
              {"label": "ID", "value": o["id"]},
              {"label": "Date", "value": o["date"]},
              {"label": "Beneficiary", "value": o["beneficiary"]},
              {"label": "Amount", "value": "${o["currency"]} ${o["amount"]}"},
              {"label": "Type", "value": o["type"]},
            ])),
          ],
        ),
      );
    }
    
    return AppTheme.tableCard(
      title: "Queued / Scheduled Outgoing Transfers",
      child: Column(
        children: outgoing
            .map((o) => AppTheme.tableRow([
                  o["id"],
                  o["date"],
                  o["beneficiary"],
                  "${o["currency"]} ${o["amount"]}",
                  o["type"],
                ]))
            .toList(),
      ),
    );
  }

  Widget buildIncomingTab(bool isMobile) {
    if (isMobile) {
      return Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Large Incoming Transfers",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 12),
            ...incoming.map((i) => _buildMobileCard(i, "incoming")),
          ],
        ),
      );
    }
    
    return AppTheme.tableCard(
      title: "Large Incoming Transfers Requiring Review",
      child: Column(
        children: incoming
            .map((i) => AppTheme.tableRow([
                  i["id"],
                  i["date"],
                  i["sender"],
                  "${i["currency"]} ${i["amount"]}",
                  AppTheme.statusBadge(i["review"]),
                  Row(
                    children: [
                      buildActionButton("Approve",
                          () => handleAction(i["id"], "Approved", "incoming")),
                      buildActionButton("Reject",
                          () => handleAction(i["id"], "Rejected", "incoming")),
                      buildActionButton("Hold",
                          () => handleAction(i["id"], "On Hold", "incoming")),
                      buildActionButton("Pending",
                          () => handleAction(i["id"], "Pending", "incoming")),
                    ],
                  )
                ]))
            .toList(),
      ),
    );
  }

  Widget buildBeneficiariesTab(bool isMobile) {
    if (isMobile) {
      return Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Beneficiary Management",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 12),
            ...beneficiaries.map((b) => _buildMobileCard(b, "beneficiary")),
          ],
        ),
      );
    }
    
    return AppTheme.tableCard(
      title: "Beneficiary Management",
      child: Column(
        children: beneficiaries
            .map((b) => AppTheme.tableRow([
                  b["id"],
                  b["name"],
                  b["account"],
                  b["bank"],
                  AppTheme.statusBadge(b["status"]),
                  Row(
                    children: [
                      buildActionButton("Approve",
                          () => handleAction(b["id"], "Approved", "beneficiary")),
                      buildActionButton("Blacklist",
                          () => handleAction(b["id"], "Rejected", "beneficiary")),
                    ],
                  )
                ]))
            .toList(),
      ),
    );
  }

  Widget buildBillsTab(bool isMobile) {
    if (isMobile) {
      return Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Bill Payments & Reconciliation",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 12),
            ...bills.map((b) => _buildMobileCard(b, "bill")),
          ],
        ),
      );
    }
    
    return AppTheme.tableCard(
      title: "Bill Payments & Reconciliation",
      child: Column(
        children: bills
            .map((b) => AppTheme.tableRow([
                  b["id"],
                  b["date"],
                  b["biller"],
                  "${b["currency"]} ${b["amount"]}",
                  AppTheme.statusBadge(b["status"]),
                  Row(
                    children: [
                      buildActionButton("Approve",
                          () => handleAction(b["id"], "Approved", "bill")),
                      buildActionButton("Reject",
                          () => handleAction(b["id"], "Rejected", "bill")),
                      buildActionButton(
                          "Hold", () => handleAction(b["id"], "On Hold", "bill")),
                      buildActionButton("Pending",
                          () => handleAction(b["id"], "Pending", "bill")),
                    ],
                  )
                ]))
            .toList(),
      ),
    );
  }

  Widget _buildMobileCard(Map<String, dynamic> data, String type) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data["id"] ?? "",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Color(0xFF900603),
                  ),
                ),
                if (data["status"] != null)
                  AppTheme.statusBadge(data["status"])
                else if (data["review"] != null)
                  AppTheme.statusBadge(data["review"]),
              ],
            ),
            const SizedBox(height: 8),
            if (type == "request") ...[
              _buildInfoRow("Sender", "${data["senderName"]} (${data["senderAcc"]})"),
              _buildInfoRow("Receiver", "${data["receiverName"]} (${data["receiverAcc"]})"),
              _buildInfoRow("Amount", "${data["currency"]} ${data["amount"]}"),
              _buildInfoRow("Method", data["method"]),
              _buildInfoRow("Date", data["date"]),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  _buildSmallButton("Approve", Colors.green, () {
                    handleAction(data["id"], "Approved", "request");
                  }),
                  _buildSmallButton("Reject", Colors.red, () {
                    handleAction(data["id"], "Rejected", "request");
                  }),
                  _buildSmallButton("Hold", Colors.orange, () {
                    handleAction(data["id"], "On Hold", "request");
                  }),
                ],
              ),
            ],
            if (type == "incoming") ...[
              _buildInfoRow("Sender", data["sender"]),
              _buildInfoRow("Amount", "${data["currency"]} ${data["amount"]}"),
              _buildInfoRow("Date", data["date"]),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  _buildSmallButton("Approve", Colors.green, () {
                    handleAction(data["id"], "Approved", "incoming");
                  }),
                  _buildSmallButton("Reject", Colors.red, () {
                    handleAction(data["id"], "Rejected", "incoming");
                  }),
                  _buildSmallButton("Hold", Colors.orange, () {
                    handleAction(data["id"], "On Hold", "incoming");
                  }),
                ],
              ),
            ],
            if (type == "beneficiary") ...[
              _buildInfoRow("Name", data["name"]),
              _buildInfoRow("Account", data["account"]),
              _buildInfoRow("Bank", data["bank"]),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  _buildSmallButton("Approve", Colors.green, () {
                    handleAction(data["id"], "Approved", "beneficiary");
                  }),
                  _buildSmallButton("Blacklist", Colors.red, () {
                    handleAction(data["id"], "Rejected", "beneficiary");
                  }),
                ],
              ),
            ],
            if (type == "bill") ...[
              _buildInfoRow("Biller", data["biller"]),
              _buildInfoRow("Amount", "${data["currency"]} ${data["amount"]}"),
              _buildInfoRow("Date", data["date"]),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  _buildSmallButton("Approve", Colors.green, () {
                    handleAction(data["id"], "Approved", "bill");
                  }),
                  _buildSmallButton("Reject", Colors.red, () {
                    handleAction(data["id"], "Rejected", "bill");
                  }),
                  _buildSmallButton("Hold", Colors.orange, () {
                    handleAction(data["id"], "On Hold", "bill");
                  }),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSimpleCard(List<Map<String, String>> items) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items.map((item) => _buildInfoRow(item["label"]!, item["value"]!)).toList(),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              "$label:",
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallButton(String label, Color color, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        minimumSize: const Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
      ),
    );
  }
}
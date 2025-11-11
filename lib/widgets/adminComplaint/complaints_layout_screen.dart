import 'package:flutter/material.dart';

// ===== Models =====
class Ticket {
  final int id;
  final String ticketId;
  final String user;
  final String subject;
  String priority;
  String status;
  DateTime lastUpdate;
  List<Message> messages;
  String? assigned;

  Ticket({
    required this.id,
    required this.ticketId,
    required this.user,
    required this.subject,
    required this.priority,
    required this.status,
    required this.lastUpdate,
    required this.messages,
    this.assigned,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'ticketId': ticketId,
    'user': user,
    'subject': subject,
    'priority': priority,
    'status': status,
    'lastUpdate': lastUpdate,
    'messages': messages,
    'assigned': assigned,
  };
}

class Message {
  final String sender;
  final String text;
  final String time;

  Message({required this.sender, required this.text, required this.time});
}

// ===== Mock Data =====
List<Ticket> ticketsData = [
  Ticket(
    id: 1,
    ticketId: "TCKT001",
    user: "John Doe",
    subject: "Issue with login",
    priority: "High",
    status: "Open",
    lastUpdate: DateTime.now(),
    messages: [
      Message(sender: "User", text: "Cannot login", time: "2:30 PM"),
      Message(
        sender: "Agent",
        text: "Please reset your password",
        time: "2:35 PM",
      ),
    ],
  ),
  Ticket(
    id: 2,
    ticketId: "TCKT002",
    user: "Jane Smith",
    subject: "Payment not processed",
    priority: "Medium",
    status: "Closed",
    lastUpdate: DateTime.now(),
    messages: [
      Message(sender: "User", text: "Payment failed", time: "10:15 AM"),
    ],
  ),
  Ticket(
    id: 3,
    ticketId: "TCKT003",
    user: "Mike Johnson",
    subject: "App crashes on startup",
    priority: "High",
    status: "Open",
    lastUpdate: DateTime.now(),
    messages: [],
  ),
  Ticket(
    id: 4,
    ticketId: "TCKT004",
    user: "Sarah Wilson",
    subject: "Account verification needed",
    priority: "Normal",
    status: "Open",
    lastUpdate: DateTime.now(),
    messages: [],
  ),
  Ticket(
    id: 5,
    ticketId: "TCKT005",
    user: "Tom Brown",
    subject: "Feature request",
    priority: "Normal",
    status: "Closed",
    lastUpdate: DateTime.now(),
    messages: [],
  ),
];

// ===== Main App =====
void main() {
  runApp(const ComplaintsApp());
}

class ComplaintsApp extends StatelessWidget {
  const ComplaintsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Complaints & Support',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ComplaintsLayoutScreen(),
    );
  }
}

// ===== Main Layout Screen =====
class ComplaintsLayoutScreen extends StatefulWidget {
  const ComplaintsLayoutScreen({super.key});

  @override
  State<ComplaintsLayoutScreen> createState() => _ComplaintsLayoutScreenState();
}

class _ComplaintsLayoutScreenState extends State<ComplaintsLayoutScreen> {
  String activeTab = "queue";
  String search = "";
  int currentPage = 1;
  static const int pageSize = 10;
  String? selectedTicketId;

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF900603);
    final Color accentColor = const Color(0xFFFF9800);

    final total = ticketsData.length;
    final open = ticketsData.where((t) => t.status == "Open").length;
    final highPriority = ticketsData.where((t) => t.priority == "High").length;
    final closed = ticketsData.where((t) => t.status == "Closed").length;

    final filteredTickets = ticketsData.where((t) {
      bool matchesSearch =
          t.ticketId.toLowerCase().contains(search.toLowerCase()) ||
          t.user.toLowerCase().contains(search.toLowerCase());
      bool matchesTab = activeTab == "queue" || t.priority == "High";
      return matchesSearch && matchesTab;
    }).toList();

    final totalPages = (filteredTickets.length / pageSize).ceil();
    final start = (currentPage - 1) * pageSize;
    final end = (start + pageSize).clamp(0, filteredTickets.length);
    final pagedTickets = filteredTickets.sublist(start, end);

    final summaryCards = [
      {
        "title": "Total Tickets",
        "value": total,
        "color": primaryColor,
        "icon": Icons.people_alt_rounded,
      },
      {
        "title": "Open Tickets",
        "value": open,
        "color": Colors.green,
        "icon": Icons.folder_open_rounded,
      },
      {
        "title": "High Priority",
        "value": highPriority,
        "color": accentColor,
        "icon": Icons.error_rounded,
      },
      {
        "title": "Closed Tickets",
        "value": closed,
        "color": Colors.grey,
        "icon": Icons.check_circle_rounded,
      },
    ];

    if (selectedTicketId != null) {
      final ticket = ticketsData.firstWhere(
        (t) => t.ticketId == selectedTicketId,
        orElse: () => ticketsData[0],
      );
      return TicketDetailsScreen(
        ticket: ticket,
        onBack: () => setState(() => selectedTicketId = null),
        onUpdate: (updated) {
          setState(() {
            final index = ticketsData.indexWhere((t) => t.id == updated.id);
            if (index != -1) {
              ticketsData[index] = updated;
            }
          });
        },
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Container(
              color: primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Complaints & Supports",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _buildTabButton("Ticket Queue", "queue", primaryColor),
                      const SizedBox(width: 10),
                      _buildTabButton(
                        "Escalations",
                        "escalations",
                        primaryColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1.6,
                          ),
                      itemCount: summaryCards.length,
                      itemBuilder: (context, index) {
                        final card = summaryCards[index];
                        return _buildSummaryCard(card);
                      },
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Search by Ticket ID / Username...",
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: primaryColor.withOpacity(0.4),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: primaryColor, width: 2),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          search = value;
                          currentPage = 1;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: pagedTickets.length,
                            separatorBuilder: (_, __) =>
                                const Divider(height: 1),
                            itemBuilder: (context, index) {
                              final ticket = pagedTickets[index];
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: primaryColor.withOpacity(
                                    0.1,
                                  ),
                                  child: Icon(
                                    Icons.confirmation_num_outlined,
                                    color: primaryColor,
                                  ),
                                ),
                                title: Text(
                                  "Ticket #${ticket.ticketId}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  "${ticket.user} • ${ticket.status}",
                                ),
                                trailing: Text(
                                  ticket.priority,
                                  style: TextStyle(
                                    color: ticket.priority == "High"
                                        ? Colors.red
                                        : Colors.black54,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    selectedTicketId = ticket.ticketId;
                                  });
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          if (totalPages > 1)
                            Wrap(
                              spacing: 6,
                              children: List.generate(totalPages, (index) {
                                final page = index + 1;
                                final bool isActive = page == currentPage;
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currentPage = page;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isActive
                                          ? primaryColor
                                          : Colors.white,
                                      border: Border.all(color: primaryColor),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      "$page",
                                      style: TextStyle(
                                        color: isActive
                                            ? Colors.white
                                            : primaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String text, String tab, Color color) {
    final bool isActive = activeTab == tab;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          activeTab = tab;
          currentPage = 1;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive
            ? const Color(0xFF6E0102)
            : Colors.transparent,
        side: const BorderSide(color: Colors.white),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 0,
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 13),
      ),
    );
  }

  Widget _buildSummaryCard(Map<String, dynamic> card) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: card["color"], width: 5)),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 3)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  card["title"],
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
                const SizedBox(height: 6),
                Text(
                  card["value"].toString(),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            CircleAvatar(
              backgroundColor: card["color"],
              radius: 20,
              child: Icon(card["icon"], color: Colors.white, size: 22),
            ),
          ],
        ),
      ),
    );
  }
}

// ===== Ticket Details Screen =====
class TicketDetailsScreen extends StatefulWidget {
  final Ticket ticket;
  final VoidCallback onBack;
  final Function(Ticket) onUpdate;

  const TicketDetailsScreen({
    super.key,
    required this.ticket,
    required this.onBack,
    required this.onUpdate,
  });

  @override
  State<TicketDetailsScreen> createState() => _TicketDetailsScreenState();
}

class _TicketDetailsScreenState extends State<TicketDetailsScreen> {
  bool showActions = false;
  final TextEditingController _messageController = TextEditingController();
  late Ticket currentTicket;

  @override
  void initState() {
    super.initState();
    currentTicket = widget.ticket;
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    setState(() {
      currentTicket.messages.add(
        Message(
          sender: "Agent",
          text: _messageController.text.trim(),
          time: TimeOfDay.now().format(context),
        ),
      );
      currentTicket.lastUpdate = DateTime.now();
    });
    widget.onUpdate(currentTicket);
    _messageController.clear();
  }

  void _handleAssign(String agentName) {
    setState(() {
      currentTicket.assigned = agentName;
      currentTicket.lastUpdate = DateTime.now();
    });
    widget.onUpdate(currentTicket);
    setState(() => showActions = false);
  }

  void _handleCloseTicket() {
    setState(() {
      currentTicket.status = "Closed";
      currentTicket.lastUpdate = DateTime.now();
    });
    widget.onUpdate(currentTicket);
    setState(() => showActions = false);
  }

  void _handleEscalate() {
    setState(() {
      currentTicket.priority = "High";
      currentTicket.lastUpdate = DateTime.now();
    });
    widget.onUpdate(currentTicket);
    setState(() => showActions = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFF950606),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(currentTicket.subject, style: const TextStyle(fontSize: 18)),
            Text(
              "ID: ${currentTicket.ticketId} | ${currentTicket.user}",
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: widget.onBack,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => setState(() => showActions = true),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: currentTicket.messages.length,
              itemBuilder: (context, index) {
                final msg = currentTicket.messages[index];
                final isUser = msg.sender == "User";
                return Align(
                  alignment: isUser
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    constraints: const BoxConstraints(maxWidth: 300),
                    decoration: BoxDecoration(
                      color: isUser
                          ? Colors.grey[300]
                          : const Color(0xFF950606).withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          msg.text,
                          style: TextStyle(
                            color: isUser ? Colors.black : Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "${msg.sender} | ${msg.time}",
                            style: TextStyle(
                              color: isUser
                                  ? Colors.grey[600]
                                  : Colors.grey[200],
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Type a reply...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF950606),
                  ),
                  onPressed: _sendMessage,
                  child: const Text("Send"),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: showActions
          ? FloatingActionButton(
              backgroundColor: Colors.black87,
              onPressed: () => setState(() => showActions = false),
              child: const Icon(Icons.close),
            )
          : null,
      endDrawer: showActions ? _buildActionsDrawer() : null,
    );
  }

  Drawer _buildActionsDrawer() {
    final agentController = TextEditingController(
      text: currentTicket.assigned ?? "",
    );

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFF950606)),
            child: const Text(
              "Manage Ticket",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  "Assign to Agent",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: agentController,
                  decoration: InputDecoration(
                    hintText: "Agent Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _handleAssign(agentController.text.trim()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      "Assign",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleCloseTicket,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text(
                      "Close Ticket",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleEscalate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    child: const Text(
                      "Escalate",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

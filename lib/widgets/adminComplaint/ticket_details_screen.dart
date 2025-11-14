import 'package:flutter/material.dart';

class TicketDetailsScreen extends StatefulWidget {
  final String ticketId;
  final VoidCallback onBack;
  final Function(Map<String, dynamic>) onUpdate;

  const TicketDetailsScreen({
    super.key,
    required this.ticketId,
    required this.onBack,
    required this.onUpdate,
  });

  @override
  State<TicketDetailsScreen> createState() => _TicketDetailsScreenState();
}

class _TicketDetailsScreenState extends State<TicketDetailsScreen> {
  bool loading = true;
  bool showActions = false;
  Map<String, dynamic>? ticket;
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTicket();
  }

  Future<void> _loadTicket() async {
    await Future.delayed(const Duration(seconds: 1)); // simulate backend
    setState(() {
      ticket = {
        "ticketId": widget.ticketId,
        "subject": "Account not credited",
        "user": "Amit Rajput",
        "messages": [
          {"sender": "User", "text": "My transaction failed."},
          {"sender": "Admin", "text": "We are checking this issue."},
        ],
      };
      loading = false;
    });
  }

  void _handleTicketUpdate(String type, Map<String, dynamic> payload) {
    if (type == "reply") {
      setState(() {
        ticket!["messages"].add({"sender": "Admin", "text": payload["text"]});
      });
    }
    widget.onUpdate(ticket!);
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFF950606),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(ticket!["subject"], style: const TextStyle(fontSize: 18)),
            Text(
              "Ticket ID: ${ticket!["ticketId"]} | User: ${ticket!["user"]}",
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
              itemCount: ticket!["messages"].length,
              itemBuilder: (context, index) {
                final msg = ticket!["messages"][index];
                final isUser = msg["sender"] == "User";
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
                    decoration: BoxDecoration(
                      color: isUser
                          ? Colors.grey[300]
                          : const Color(0xFF950606).withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      msg["text"],
                      style: TextStyle(
                        color: isUser ? Colors.black : Colors.white,
                        fontSize: 14,
                      ),
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
                    decoration: const InputDecoration(
                      hintText: "Type a reply...",
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF950606),
                  ),
                  onPressed: () {
                    if (_messageController.text.isNotEmpty) {
                      _handleTicketUpdate("reply", {
                        "text": _messageController.text.trim(),
                      });
                      _messageController.clear();
                    }
                  },
                  child: const Text("Send"),
                ),
              ],
            ),
          ),
        ],
      ),
      // Actions modal
      floatingActionButton: showActions
          ? FloatingActionButton(
              backgroundColor: Colors.black.withValues(alpha: 0.7),
              onPressed: () => setState(() => showActions = false),
              child: const Icon(Icons.close),
            )
          : null,
    );
  }
}


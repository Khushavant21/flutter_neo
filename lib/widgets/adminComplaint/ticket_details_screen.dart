import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFF950606),
        foregroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              currentTicket.subject,
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            Text(
              "ID: ${currentTicket.ticketId} | ${currentTicket.user}",
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: widget.onBack,
        ),
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
                          : const Color(0xFF950606).withValues(alpha: 0.9),
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
                  child: const Text(
                    "Send",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
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

// Models
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
}

class Message {
  final String sender;
  final String text;
  final String time;

  Message({required this.sender, required this.text, required this.time});
}
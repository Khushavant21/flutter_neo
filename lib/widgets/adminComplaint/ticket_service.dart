import 'dart:async';

// ===== Mock Ticket Model =====
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

// ===== Mock Data =====
final List<Ticket> ticketsData = [
  Ticket(
    id: 1,
    ticketId: "TCKT001",
    user: "John Doe",
    subject: "Issue with login",
    priority: "High",
    status: "Open",
    lastUpdate: DateTime.now(),
    messages: [
      Message(
        sender: "User",
        text: "Cannot login",
        time: DateTime.now().toString(),
      ),
      Message(
        sender: "Agent",
        text: "Please reset your password",
        time: DateTime.now().toString(),
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
    messages: [],
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
  // Add remaining mock tickets as needed...
];

// ====== Mock Service Methods ======

Future<List<Ticket>> getTickets() async {
  // Simulate API delay
  await Future.delayed(const Duration(milliseconds: 300));
  return ticketsData;
}

Future<Ticket?> getTicketDetails(int ticketId) async {
  await Future.delayed(const Duration(milliseconds: 200));
  try {
    return ticketsData.firstWhere((t) => t.id == ticketId);
  } catch (_) {
    return null;
  }
}

Future<Ticket?> updateTicket(
  int ticketId,
  String action, {
  Map<String, dynamic>? payload,
}) async {
  await Future.delayed(const Duration(milliseconds: 200));

  final ticket = ticketsData.firstWhere(
    (t) => t.id == ticketId,
    orElse: () => Ticket(
      id: -1,
      ticketId: '',
      user: '',
      subject: '',
      priority: '',
      status: '',
      lastUpdate: DateTime.now(),
      messages: [],
    ),
  );

  if (ticket.id == -1) return null;

  switch (action) {
    case "assign":
      ticket.assigned = payload?['agent'];
      break;
    case "close":
      ticket.status = "Closed";
      break;
    case "escalate":
      ticket.priority = "High";
      break;
    case "reply":
      ticket.messages.add(
        Message(
          sender: "Agent",
          text: payload?['text'] ?? '',
          time: DateTime.now().toString(),
        ),
      );
      break;
    default:
      break;
  }

  ticket.lastUpdate = DateTime.now();
  return ticket;
}


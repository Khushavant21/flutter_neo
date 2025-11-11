import 'package:flutter/material.dart';
import 'ticket_queue_screen.dart';

class EscalationsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> tickets;
  final String search;
  final Function(String) onView;

  const EscalationsScreen({
    super.key,
    required this.tickets,
    required this.search,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    // Filter high-priority tickets
    final highPriorityTickets = tickets
        .where((t) => t['priority']?.toString().toLowerCase() == 'high')
        .toList();

    return TicketQueueScreen(
      tickets: highPriorityTickets,
      search: search,
      onView: onView,
    );
  }
}

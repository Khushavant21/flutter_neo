import 'package:flutter/material.dart';

class TicketQueueScreen extends StatefulWidget {
  final List<Map<String, dynamic>> tickets;
  final String search;
  final Function(String) onView;

  const TicketQueueScreen({
    super.key,
    required this.tickets,
    required this.search,
    required this.onView,
  });

  @override
  State<TicketQueueScreen> createState() => _TicketQueueScreenState();
}

class _TicketQueueScreenState extends State<TicketQueueScreen> {
  int currentPage = 1;
  final int pageSize = 10;

  List<Map<String, dynamic>> get filteredTickets {
    final text = widget.search.toLowerCase();
    return widget.tickets
        .where(
          (t) =>
              t['user'].toString().toLowerCase().contains(text) ||
              t['ticketId'].toString().toLowerCase().contains(text),
        )
        .toList();
  }

  List<Map<String, dynamic>> get pagedTickets {
    final start = (currentPage - 1) * pageSize;
    final end = start + pageSize;
    return filteredTickets.sublist(
      start,
      end > filteredTickets.length ? filteredTickets.length : end,
    );
  }

  int get totalPages => (filteredTickets.length / pageSize).ceil();

  Color getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return Colors.red.shade600;
      case "Medium":
        return Colors.orange.shade600;
      default:
        return Colors.green.shade600;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff9fafb),
      appBar: AppBar(
        title: const Text('Support Tickets'),
        backgroundColor: const Color(0xff950606),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: constraints.maxWidth,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        headingRowColor: WidgetStateProperty.all(
                          const Color(0xff950606),
                        ),
                        headingTextStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        columns: const [
                          DataColumn(label: Text("Ticket ID")),
                          DataColumn(label: Text("User")),
                          DataColumn(label: Text("Subject")),
                          DataColumn(label: Text("Priority")),
                          DataColumn(label: Text("Status")),
                          DataColumn(label: Text("Last Update")),
                          DataColumn(label: Text("Actions")),
                        ],
                        rows: pagedTickets.map((ticket) {
                          return DataRow(
                            cells: [
                              DataCell(Text(ticket['ticketId'].toString())),
                              DataCell(Text(ticket['user'].toString())),
                              DataCell(Text(ticket['subject'].toString())),
                              DataCell(
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: getPriorityColor(ticket['priority']),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    ticket['priority'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(Text(ticket['status'])),
                              DataCell(Text(ticket['lastUpdate'])),
                              DataCell(
                                ElevatedButton(
                                  onPressed: () => widget.onView(ticket['id']),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.teal,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 6,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  child: const Text(
                                    "View",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),

              // Pagination
              if (totalPages > 1)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    alignment: WrapAlignment.center,
                    children: List.generate(totalPages, (i) {
                      final page = i + 1;
                      final isActive = currentPage == page;
                      return OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: isActive
                              ? const Color(0xff950606)
                              : Colors.white,
                          side: const BorderSide(color: Color(0xff950606)),
                        ),
                        onPressed: () {
                          setState(() => currentPage = page);
                        },
                        child: Text(
                          "$page",
                          style: TextStyle(
                            color: isActive
                                ? Colors.white
                                : const Color(0xff950606),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

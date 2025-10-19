import 'package:flutter/material.dart';

class DrivesPage extends StatelessWidget {
  final List<Map<String, String>> drives = const [
    {"company": "Google", "date": "25 Sep 2025", "status": "Completed"},
    {"company": "Amazon", "date": "28 Sep 2025", "status": "Ongoing"},
    {"company": "Microsoft", "date": "1 Oct 2025", "status": "Upcoming"},
    {"company": "Infosys", "date": "5 Oct 2025", "status": "Upcoming"},
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return Colors.green;
      case "Ongoing":
        return Colors.orange;
      default:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Placement Drives'),
        backgroundColor: const Color(0xFF2C3E50),
      ),
      body: Container(
        color: const Color(0xFFF5F7FA),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: drives.length,
          itemBuilder: (context, index) {
            final drive = drives[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFF2980B9),
                  child: const Icon(Icons.business, color: Colors.white),
                ),
                title: Text(
                  drive["company"]!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                subtitle: Text("Date: ${drive["date"]}"),
                trailing: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor(drive["status"]!),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    drive["status"]!,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

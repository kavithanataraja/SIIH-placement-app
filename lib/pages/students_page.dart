import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentsPage extends StatelessWidget {
  const StudentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> students = [
      {"name": "Nivedha", "department": "CSE", "status": "Placed"},
      {"name": "Karthik", "department": "IT", "status": "Eligible"},
      {"name": "Aishwarya", "department": "ECE", "status": "Pending"},
      {"name": "Rahul", "department": "EEE", "status": "Placed"},
      {"name": "Meena", "department": "Mechanical", "status": "Eligible"},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C3E50),
        title: Text(
          'Students',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: DataTable(
            headingRowColor: MaterialStateProperty.all(const Color(0xFF2980B9)),
            headingTextStyle: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            columns: const [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Department')),
              DataColumn(label: Text('Status')),
            ],
            rows: students.map((student) {
              Color statusColor;
              switch (student['status']) {
                case 'Placed':
                  statusColor = const Color(0xFF27AE60);
                  break;
                case 'Eligible':
                  statusColor = const Color(0xFFF39C12);
                  break;
                default:
                  statusColor = const Color(0xFF95A5A6);
              }

              return DataRow(
                cells: [
                  DataCell(Text(student['name']!)),
                  DataCell(Text(student['department']!)),
                  DataCell(
                    Row(
                      children: [
                        Icon(Icons.circle, color: statusColor, size: 12),
                        const SizedBox(width: 6),
                        Text(
                          student['status']!,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: statusColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

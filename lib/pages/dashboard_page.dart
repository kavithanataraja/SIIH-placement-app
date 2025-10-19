import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const SIIHDashboardApp());
}

class SIIHDashboardApp extends StatelessWidget {
  const SIIHDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SIIH Dashboard',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2C3E50)),
        useMaterial3: true,
      ),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int selectedDrawerIndex = 0;

  int totalStudents = 560;
  int placedStudents = 420;
  int ongoingDrives = 5;
  int upcomingInterviews = 8;

  final List<Map<String, dynamic>> departments = [
    {'dept': 'CSE', 'count': 45},
    {'dept': 'ECE', 'count': 65},
    {'dept': 'ME', 'count': 40},
    {'dept': 'EE', 'count': 30},
    {'dept': 'CE', 'count': 10},
  ];

  final List<Map<String, String>> students = [
    {'name': 'Sarah Johnson', 'dept': 'CSE', 'status': 'Placed'},
    {'name': 'Michael Smith', 'dept': 'ME', 'status': 'Pending'},
    {'name': 'Emily Davis', 'dept': 'EE', 'status': 'Placed'},
    {'name': 'Daniel Brown', 'dept': 'CSE', 'status': 'Pending'},
  ];

  final List<Map<String, dynamic>> companies = [
    {'company': 'Google', 'offers': 15},
    {'company': 'Microsoft', 'offers': 12},
    {'company': 'Amazon', 'offers': 10},
    {'company': 'IBM', 'offers': 8},
    {'company': 'TCS', 'offers': 20},
  ];

  final List<Map<String, String>> recentActivity = [
    {
      'activity': 'Upcoming Interview',
      'student': 'Sarah Johnson',
      'dept': 'CSE',
      'status': 'Scheduled'
    },
    {
      'activity': 'Application Submitted',
      'student': 'Michael Smith',
      'dept': 'ME',
      'status': 'In Review'
    },
    {
      'activity': 'Application Reviewed',
      'student': 'Emily Davis',
      'dept': 'EE',
      'status': 'In Review'
    },
    {
      'activity': 'Upcoming Interview',
      'student': 'Daniel Brown',
      'dept': 'CSE',
      'status': 'Scheduled'
    },
  ];

  final List<Map<String, dynamic>> topRecruiters = [
    {'recruiter': 'Google', 'placements': 75},
    {'recruiter': 'Microsoft', 'placements': 60},
    {'recruiter': 'Amazon', 'placements': 50},
    {'recruiter': 'IBM', 'placements': 45},
  ];

  @override
  Widget build(BuildContext context) {
    Widget pageContent;

    switch (selectedDrawerIndex) {
      case 1:
        pageContent = _buildStudentsPage();
        break;
      case 2:
        pageContent = _buildCompaniesPage();
        break;
      default:
        pageContent = _buildDashboard();
    }

    return Scaffold(
      drawer: Drawer(
        backgroundColor: const Color(0xFF2C3E50),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF2C3E50)),
              child: Text(
                'SIIH',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
            ),
            DrawerItem(
                title: 'Dashboard',
                icon: Icons.dashboard,
                isSelected: selectedDrawerIndex == 0,
                onTap: () => _onDrawerSelect(0)),
            DrawerItem(
                title: 'Students',
                icon: Icons.school,
                isSelected: selectedDrawerIndex == 1,
                onTap: () => _onDrawerSelect(1)),
            DrawerItem(
                title: 'Companies',
                icon: Icons.business_center,
                isSelected: selectedDrawerIndex == 2,
                onTap: () => _onDrawerSelect(2)),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: const [
            Text('Dashboard',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            SizedBox(width: 10),
            Text('Smart Institutional Intelligence Hub',
                style: TextStyle(color: Colors.grey, fontSize: 13)),
          ],
        ),
        actions: const [
          Icon(Icons.notifications_none, color: Colors.black),
          SizedBox(width: 15),
          Icon(Icons.account_circle, color: Colors.black),
          SizedBox(width: 20),
        ],
      ),
      body: pageContent,
    );
  }

  void _onDrawerSelect(int index) {
    setState(() => selectedDrawerIndex = index);
    Navigator.pop(context);
  }

  // 📊 Dashboard page content
  Widget _buildDashboard() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            runSpacing: 10,
            children: [
              SummaryCard(
                  title: 'Total Students',
                  value: totalStudents.toString(),
                  color: Colors.black),
              SummaryCard(
                  title: 'Placed Students',
                  value: placedStudents.toString(),
                  color: const Color(0xFF27AE60)),
              SummaryCard(
                  title: 'Ongoing Drives',
                  value: ongoingDrives.toString(),
                  color: Colors.orange),
              SummaryCard(
                  title: 'Upcoming Interviews',
                  value: upcomingInterviews.toString(),
                  color: Colors.purple),
            ],
          ),
          const SizedBox(height: 20),
          // Charts row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: _buildBarChartCard()),
              const SizedBox(width: 20),
              Expanded(flex: 2, child: _buildPieChartCard()),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: _buildRecentActivityTable()),
              const SizedBox(width: 20),
              Expanded(flex: 2, child: _buildRecruitersTable()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBarChartCard() => _card(
        title: 'Placements by Department',
        height: 300,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    if (value.toInt() < departments.length) {
                      return Text(departments[value.toInt()]['dept']);
                    }
                    return const Text('');
                  },
                ),
              ),
            ),
            gridData: FlGridData(show: false),
            barGroups: departments
                .asMap()
                .entries
                .map((e) => BarChartGroupData(x: e.key, barRods: [
                      BarChartRodData(
                          toY: e.value['count'].toDouble(),
                          color: const Color(0xFF2980B9))
                    ]))
                .toList(),
          ),
        ),
      );

  Widget _buildPieChartCard() => _card(
        title: 'Placement Status',
        height: 300,
        child: Column(
          children: [
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                        value: placedStudents.toDouble(),
                        color: const Color(0xFF27AE60),
                        title: 'Placed'),
                    PieChartSectionData(
                        value: (totalStudents - placedStudents).toDouble(),
                        color: const Color(0xFFF39C12),
                        title: 'Pending'),
                  ],
                  centerSpaceRadius: 40,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.circle, color: Color(0xFF27AE60), size: 10),
                SizedBox(width: 5),
                Text('Placed'),
                SizedBox(width: 15),
                Icon(Icons.circle, color: Color(0xFFF39C12), size: 10),
                SizedBox(width: 5),
                Text('Pending'),
              ],
            )
          ],
        ),
      );

  Widget _buildRecentActivityTable() => _card(
        title: 'Recent Activity',
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Activity')),
            DataColumn(label: Text('Student')),
            DataColumn(label: Text('Department')),
            DataColumn(label: Text('Status')),
          ],
          rows: recentActivity
              .map((item) => DataRow(cells: [
                    DataCell(Text(item['activity']!)),
                    DataCell(Text(item['student']!)),
                    DataCell(Text(item['dept']!)),
                    DataCell(Text(
                      item['status']!,
                      style: TextStyle(
                          color: item['status'] == 'Scheduled'
                              ? const Color(0xFF27AE60)
                              : const Color(0xFFF39C12)),
                    )),
                  ]))
              .toList(),
        ),
      );

  Widget _buildRecruitersTable() => _card(
        title: 'Top Recruiters',
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Recruiter')),
            DataColumn(label: Text('Placements')),
          ],
          rows: topRecruiters
              .map((item) => DataRow(cells: [
                    DataCell(Text(item['recruiter'])),
                    DataCell(Text(item['placements'].toString())),
                  ]))
              .toList(),
        ),
      );

  Widget _buildStudentsPage() => _simpleListPage(
        title: "Students",
        items: students
            .map((e) => "${e['name']}  •  ${e['dept']}  •  ${e['status']}")
            .toList(),
      );

  Widget _buildCompaniesPage() => _simpleListPage(
        title: "Companies",
        items: companies
            .map((e) => "${e['company']}  —  ${e['offers']} offers")
            .toList(),
      );

  Widget _simpleListPage({required String title, required List<String> items}) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          );
        }
        return Card(
          child: ListTile(
            title: Text(items[index - 1]),
          ),
        );
      },
    );
  }

  Widget _card({required String title, required Widget child, double? height}) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 10),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const DrawerItem({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: isSelected ? Colors.amber : Colors.white),
      title: Text(title,
          style: TextStyle(
              color: isSelected ? Colors.amber : Colors.white,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
      onTap: onTap,
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  const SummaryCard(
      {super.key,
      required this.title,
      required this.value,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(fontSize: 13, color: Colors.grey)),
            const SizedBox(height: 6),
            Text(value,
                style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatefulWidget {
   final AnimationController animationController;
  const DashboardScreen({super.key, required this.animationController});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    // Screen width and check for tablet-like screens
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text('Today Overview', style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(height: 16),

              // Dashboard Cards (Bookings, Available Tables)
              isTablet
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DashboardCard(title: 'Bookings', value: '32'),
                        DashboardCard(title: 'Available Tables', value: '12'),
                      ],
                    )
                  : Column(
                      children: [
                        DashboardCard(title: 'Bookings', value: '32'),
                        SizedBox(height: 16),
                        DashboardCard(title: 'Available Tables', value: '12'),
                      ],
                    ),

              SizedBox(height: 16),

              // Bar Chart for Reservations Overview
              Container(
                height: 250,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
                ),
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 100,
                    barTouchData: BarTouchData(enabled: true),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) => Text(
                            ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][value.toInt()],
                          ),
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    barGroups: List.generate(6, (i) {
                      return BarChartGroupData(x: i, barRods: [
                        BarChartRodData(toY: (i + 1) * 15.0, color: Colors.deepOrange, width: 16),
                      ]);
                    }),
                  ),
                ),
              ),

              SizedBox(height: 16),

              // Current Reservations Section (Dynamic List)
              Text('Current Reservations', style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(height: 10),
              Column(
                children: List.generate(3, (index) {
                  return ReservationTile(
                    name: 'Customer ${index + 1}',
                    time: '7:00 PM',
                    onTap: () {
                      // Handle interaction (e.g., navigate to reservation details)
                    },
                  );
                }),
              ),

              SizedBox(height: 16),

              // Earnings Overview Section
              Text('Earnings Overview', style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(height: 10),
              EarningsCard(
                total: '₹1500',
                today: '₹500',
                onTap: () {
                  // Handle interaction (e.g., navigate to earnings details)
                },
              ),

              SizedBox(height: 16),

              // Customer Feedback Section
              Text('Customer Feedback', style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(height: 10),
              Column(
                children: List.generate(2, (index) {
                  return FeedbackTile(
                    customer: 'Customer ${index + 1}',
                    rating: 4.5,
                    onTap: () {
                      // Handle interaction (e.g., navigate to feedback details)
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Dashboard Card Widget
class DashboardCard extends StatelessWidget {
  final String title;
  final String value;

  const DashboardCard({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 24,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.grey[700])),
          SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// Reservation Tile Widget
class ReservationTile extends StatelessWidget {
  final String name;
  final String time;
  final Function onTap;

  const ReservationTile({
    required this.name,
    required this.time,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: ListTile(
        leading: Icon(Icons.person_outline, color: Colors.deepOrange),
        title: Text(name),
        subtitle: Text('Time: $time'),
        trailing: Icon(Icons.more_vert),
      ),
    );
  }
}

// Earnings Card Widget
class EarningsCard extends StatelessWidget {
  final String total;
  final String today;
  final Function onTap;

  const EarningsCard({
    required this.total,
    required this.today,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Earnings', style: TextStyle(color: Colors.grey[700])),
            SizedBox(height: 8),
            Text(total, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Today: $today', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

// Feedback Tile Widget
class FeedbackTile extends StatelessWidget {
  final String customer;
  final double rating;
  final Function onTap;

  const FeedbackTile({
    required this.customer,
    required this.rating,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: ListTile(
        leading: Icon(Icons.feedback, color: Colors.blue),
        title: Text(customer),
        subtitle: Text('Rating: $rating'),
        trailing: Icon(Icons.more_vert),
      ),
    );
  }
}

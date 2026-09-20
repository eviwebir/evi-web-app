import 'package:flutter/material.dart';
import 'api_service.dart';

class DashboardScreen extends StatelessWidget {
  final ApiService _api = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(title: Text("سفارش‌های ایوی وب"), backgroundColor: Color(0xFFFF6A00)),
      body: FutureBuilder<List<dynamic>>(
        future: _api.fetchOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          if (!snapshot.hasData || snapshot.data!.isEmpty)
            return Center(child: Text("سفارشی یافت نشد", style: TextStyle(color: Colors.white)));
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final order = snapshot.data![index];
              return Card(
                color: Colors.white10,
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text("سفارش #${order['id']}", style: TextStyle(color: Colors.white)),
                  subtitle: Text("وضعیت: ${order['status']}", style: TextStyle(color: Colors.grey)),
                  trailing: Icon(Icons.chevron_right, color: Colors.white),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

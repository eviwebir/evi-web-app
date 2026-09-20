import 'package:flutter/material.dart';
import 'api_service.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userController = TextEditingController();
  final _passController = TextEditingController();
  final ApiService _api = ApiService();
  bool _isLoading = false;

  void _doLogin() async {
    setState(() => _isLoading = true);
    String? token = await _api.login(_userController.text, _passController.text);
    setState(() => _isLoading = false);
    if (token != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashboardScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("ورود ناموفق. اطلاعات را چک کنید.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("ورود به پنل ایوی وب",
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 30),
            TextField(
              controller: _userController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "نام کاربری",
                hintStyle: TextStyle(color: Colors.grey),
                filled: true, fillColor: Colors.white10,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passController,
              obscureText: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "رمز عبور",
                hintStyle: TextStyle(color: Colors.grey),
                filled: true, fillColor: Colors.white10,
              ),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFF6A00),
                      minimumSize: Size(double.infinity, 50),
                    ),
                    onPressed: _doLogin,
                    child: Text("ورود", style: TextStyle(color: Colors.white)),
                  ),
          ],
        ),
      ),
    );
  }
}

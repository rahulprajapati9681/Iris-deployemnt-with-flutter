import 'package:flutter/material.dart';
import 'prediction_screen.dart';

class ApiKeyScreen extends StatefulWidget {
  @override
  _ApiKeyScreenState createState() => _ApiKeyScreenState();
}

class _ApiKeyScreenState extends State<ApiKeyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _urlController = TextEditingController();

  void _proceed() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      Future.delayed(Duration(milliseconds: 300), () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 600),
            pageBuilder: (_, __, ___) => PredictionScreen(apiUrl: _urlController.text),
            transitionsBuilder: (_, animation, __, child) {
              final curvedAnimation = CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOutCubic, // 👈 smoother than fastOutSlowIn
              );

              return ScaleTransition(
                scale: Tween<double>(
                  begin: 0.97,
                  end: 1.0,
                ).animate(curvedAnimation),
                child: FadeTransition(
                  opacity: curvedAnimation,
                  child: child,
                ),
              );
            },
          ),
        );
      });
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🌄 Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/YTBG.png',
              fit: BoxFit.cover,
            ),
          ),

          // 🧾 Foreground Form
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 🌐 API URL Input
                    TextFormField(
                      controller: _urlController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: "Enter API URL",
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.9),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: BorderSide.none,
                        ),
                        errorStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Enter API URL';
                        if (!value.startsWith('http')) return 'Must start with http';
                        return null;
                      },
                    ),

                    SizedBox(height: 20),

                    // 🚀 Proceed Button
                    GestureDetector(
                      onTap: _proceed,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.deepPurple.withOpacity(0.3),
                              blurRadius: 12,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 28),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
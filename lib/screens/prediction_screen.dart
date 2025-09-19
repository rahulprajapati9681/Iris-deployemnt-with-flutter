import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PredictionScreen extends StatefulWidget {
  final String apiUrl;
  PredictionScreen({required this.apiUrl});

  @override
  _PredictionScreenState createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _sl = TextEditingController();
  final _sw = TextEditingController();
  final _pl = TextEditingController();
  final _pw = TextEditingController();

  String _result = ''; // Original API result for display
  String _normalizedResult = ''; // Normalized key for speciesInfo lookup
  bool _loading = false;

  // ✅ Species info data
  final Map<String, Map<String, String>> speciesInfo = {
    "setosa": {
      "title": "Iris Setosa",
      "description":
      "Iris Setosa is usually small with purple-blue flowers. It prefers cooler climates and is often found in northern regions.",
    },
    "versicolor": {
      "title": "Iris Versicolor",
      "description":
      "Also called the Blue Flag Iris, it has violet-blue flowers and grows in wetlands. Known for its vibrant colors.",
    },
    "virginica": {
      "title": "Iris Virginica",
      "description":
      "The Virginia Iris is taller, with deep purple-blue flowers. It’s common in marshy areas and has striking petals.",
    },
  };

  Future<void> predict() async {
    if (!_formKey.currentState!.validate()) return;

    // ✅ Hide keyboard
    FocusScope.of(context).unfocus();

    setState(() {
      _loading = true;
      _result = '';
      _normalizedResult = '';
    });

    final endpoint = Uri.parse('${widget.apiUrl}/predict');
    final response = await http.post(
      endpoint,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'features': [
          double.parse(_sl.text),
          double.parse(_sw.text),
          double.parse(_pl.text),
          double.parse(_pw.text),
        ]
      }),
    );

    await Future.delayed(Duration(milliseconds: 500)); // smoother UX

    setState(() {
      _loading = false;
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Original API result for button display
        _result = data['prediction'].toString();

        // Normalized key for speciesInfo lookup
        _normalizedResult =
            _result.toLowerCase().replaceAll('iris-', '').trim();
      } else {
        _result = 'error';
        _normalizedResult = '';
      }
    });
  }

  Widget buildInput(String hint, TextEditingController controller) {
    return Focus(
      child: Builder(
        builder: (context) {
          final isFocused = Focus.of(context).hasFocus;

          return AnimatedContainer(
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: isFocused
                      ? Colors.deepPurple.withOpacity(0.4)
                      : Colors.black.withOpacity(0.1),
                  blurRadius: isFocused ? 12 : 8,
                  offset: Offset(0, 4),
                ),
              ],
              borderRadius: BorderRadius.circular(40),
            ),
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey.shade400),
                filled: true,
                fillColor: Colors.white.withOpacity(0.85),
                contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide.none,
                ),
                errorStyle: TextStyle(color: Colors.white),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return 'Enter $hint';
                if (double.tryParse(value) == null) return 'Must be a number';
                return null;
              },
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final info = speciesInfo[_normalizedResult];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.deepPurple,
        title: Text("Iris Predictor", style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: Stack(
        children: [
          // 🌄 Fullscreen Background Image
          Positioned.fill(
            child: Container(
              color: Colors.white, // fallback color
              child: Image.asset(
                'assets/images/BG.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 🧾 Foreground Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    SizedBox(height: 20),
                    buildInput("Sepal Length", _sl),
                    SizedBox(height: 16),
                    buildInput("Sepal Width", _sw),
                    SizedBox(height: 16),
                    buildInput("Petal Length", _pl),
                    SizedBox(height: 16),
                    buildInput("Petal Width", _pw),
                    SizedBox(height: 28),

                    Center(
                      child: GestureDetector(
                        onTap: _loading ? null : predict,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          width: _result.isNotEmpty
                              ? MediaQuery.of(context).size.width * 0.6
                              : 65,
                          height: 65,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.deepPurple.withOpacity(0.3),
                                blurRadius: 12,
                                offset: Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Center(
                            child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 400),
                              transitionBuilder: (child, anim) => FadeTransition(
                                opacity: anim,
                                child: ScaleTransition(scale: anim, child: child),
                              ),
                              child: _loading
                                  ? SizedBox(
                                width: 26,
                                height: 26,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                ),
                              )
                                  : _result.isEmpty
                                  ? Image.asset(
                                'assets/icons/AImagic_white.png',
                                key: ValueKey("icon"),
                                width: 30,
                                height: 30,
                                color: Colors.white,
                              )
                                  : Text(
                                "🌸 $_result",
                                key: ValueKey(_result),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 28),

                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 400),
                      transitionBuilder: (child, anim) => FadeTransition(
                        opacity: anim,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: Offset(0, 0.2),
                            end: Offset.zero,
                          ).animate(anim),
                          child: child,
                        ),
                      ),
                      child: info != null
                          ? Card(
                        key: ValueKey(info['title']),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Colors.deepPurple.shade50.withOpacity(0.9),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                info['title']!,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple.shade700,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                info['description']!,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.deepPurple.shade600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      )
                          : SizedBox.shrink(),
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
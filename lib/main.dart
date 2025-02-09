import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green,
        scaffoldBackgroundColor: Colors.pink[100], 
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green, 
            foregroundColor: Colors.white, 
          ),
        ),
      ),
      home: CounterImageScreen(),
    );
  }
}

class CounterImageScreen extends StatefulWidget {
  @override
  _CounterImageScreenState createState() => _CounterImageScreenState();
}

class _CounterImageScreenState extends State<CounterImageScreen>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  bool _showFirstImage = true;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _toggleImage() {
    _animationController.forward(from: 0);
    setState(() {
      _showFirstImage = !_showFirstImage;
    });
  }

  void _reset() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.pink[50], 
        title: Text(
          "Confirm Reset",
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
        content: Text(
          "Are you sure you want to reset?",
          style: TextStyle(color: Colors.green[700]),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel", style: TextStyle(color: Colors.green)),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _counter = 0;
                _showFirstImage = true;
              });
              Navigator.pop(context);
            },
            child: Text("Reset", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CW1 MARIAM OMER",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green, 
        centerTitle: true,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
         
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Counter: $_counter",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[900], 
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _incrementCounter,
                  child: Text("Increment"),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _reset,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, 
                  ),
                  child: Text("Reset"),
                ),
              ],
            ),
            SizedBox(width: 50), 
      
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Image.asset(
                    _showFirstImage ? 'assets/image1.png' : 'assets/image2.png',
                    width: 200,
                    height: 200,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _toggleImage,
                  child: Text("Toggle Image"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 50),

              CustomButton(
                text: 'Login',
                textSize: 20,
                textColor: Colors.black,
                backgroundColor: Color.fromARGB(255, 224, 229, 232),
                borderRadius: 24,
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
              SizedBox(height: 20),

              CustomButton(
                text: 'Register',
                textSize: 20,
                textColor: Color.fromARGB(255, 224, 229, 232),
                backgroundColor: Colors.transparent,
                borderWidth: 3,
                borderRadius: 24,
                borderColor: Color.fromARGB(255, 224, 229, 232),
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
              ),
              SizedBox(height: 20),

              CustomButton(
                text: 'Use without login',
                textSize: 18,
                textColor: Color.fromARGB(255, 224, 229, 232),
                backgroundColor: Colors.transparent,
                onPressed: () {
                  Navigator.pushNamed(context, "/dashboard");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

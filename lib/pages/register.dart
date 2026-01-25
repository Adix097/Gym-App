import "package:flutter/material.dart";

import "../widgets/input_field.dart";
import "../widgets/custom_button.dart";

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          },
        ),
        title: const Text('Register', style: TextStyle(color: Colors.white)),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InputField(
                placeholder: "Username",
                placeholderColor: Colors.grey,
                backgroundColor: Colors.grey.shade900,
              ),
              const SizedBox(height: 16),

              InputField(
                placeholder: "Password",
                placeholderColor: Colors.grey,
                backgroundColor: Colors.grey.shade900,
              ),
              const SizedBox(height: 24),

              CustomButton(
                text: 'Register',
                textSize: 18,
                textColor: Colors.black,
                backgroundColor: Colors.teal,
                borderRadius: 24,
                onPressed: () {
                  print("Pressed!");
                },
              ),

              CustomButton(
                text: 'Already have an account? Login',
                textSize: 18,
                textColor: Colors.teal,
                backgroundColor: Colors.transparent,
                onPressed: () {
                  Navigator.pushNamed(context, "/login");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

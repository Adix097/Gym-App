import "package:flutter/material.dart";

import "../widgets/input_field.dart";
import "../widgets/custom_button.dart";
import "../services/api.dart";

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _loading = false;
  String? _error;

  void _register() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _loading = false;
        _error = "Username and password are required";
      });
      return;
    }

    try {
      final success = await ApiService.register(username, password);
      setState(() => _loading = false);

      if (success) {
        // Navigate to login page after successful registration
        Navigator.pushReplacementNamed(context, "/login");
      } else {
        setState(() => _error = "Registration failed. User may already exist.");
      }
    } catch (e) {
      setState(() {
        _loading = false;
        _error = "Registration failed. Check your connection.";
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                controller: _usernameController,
                placeholder: "Username",
                placeholderColor: Colors.grey,
                backgroundColor: Colors.grey.shade900,
              ),
              const SizedBox(height: 16),
              InputField(
                controller: _passwordController,
                placeholder: "Password",
                placeholderColor: Colors.grey,
                backgroundColor: Colors.grey.shade900,
              ),
              const SizedBox(height: 24),
              if (_error != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    _error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              CustomButton(
                text: _loading ? 'Registering...' : 'Register',
                textSize: 18,
                textColor: Colors.black,
                backgroundColor: Colors.teal,
                borderRadius: 24,
                onPressed: _loading ? null : _register,
              ),
              const SizedBox(height: 12),
              CustomButton(
                text: 'Already have an account? Login',
                textSize: 18,
                textColor: Colors.teal,
                backgroundColor: Colors.transparent,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/login");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

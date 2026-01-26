import "package:flutter/material.dart";
import "package:gym_app_flutter/services/auth_storage.dart";

import "../widgets/input_field.dart";
import "../widgets/custom_button.dart";
import '../services/api.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _loading = false;
  String? _error;

  void _login() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _loading = false;
        _error = "Username and Password are required!";
      });
      return;
    }

    try {
      final result = await ApiService.login(username, password);
      
      setState(() {
        _loading = false;
      });

      if (result != null && result.containsKey("user_id")) {
        await AuthStorage.saveUser(
          result["user_id"] as String,
          username,
        );

        Navigator.pushReplacementNamed(context, "/dashboard");
      } else {
        setState(() {
          _error = "Invalid username or password";
        });
      }
    } catch (error) {
      setState(() {
        _loading = false;
        _error = "Login failed: $error";
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
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 22),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/landing', (route) => false);
          },
        ),
        title: const Text('Login', style: TextStyle(color: Colors.white)),
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
                obscureText: true,
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
                text: _loading ? 'Logging in...' : 'Login',
                textSize: 18,
                textColor: Colors.black,
                backgroundColor: Color.fromARGB(255, 221, 217, 42),
                borderRadius: 24,
                onPressed: _loading ? null : _login,
              ),

              CustomButton(
                text: 'Create account',
                textSize: 18,
                textColor: Color.fromARGB(255, 221, 217, 42),
                backgroundColor: Colors.transparent,
                onPressed: () {
                  Navigator.pushNamed(context, "/register");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
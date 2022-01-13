import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef AuthenticateCallback = void Function({
  required String email,
  required String password,
});

class AuthenticationForm extends ConsumerStatefulWidget {
  const AuthenticationForm({
    Key? key,
    required this.authenticate,
    required this.title,
  }) : super(key: key);
  final AuthenticateCallback? authenticate;
  final String title;
  @override
  _AuthenticationFormState createState() => _AuthenticationFormState();
}

class _AuthenticationFormState extends ConsumerState<AuthenticationForm> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;

  @override
  void dispose() {
    if (_formKey.currentState != null) _formKey.currentState!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildEmailFormField(),
                const SizedBox(height: 20.0),
                _buildPasswordFormField(),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.authenticate!(
                        email: _email!,
                        password: _password!,
                      );
                    }
                  },
                  child: Text(widget.title),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    elevation: MaterialStateProperty.all(16.0),
                  ),
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _getDecoration({String? hint, String? label}) =>
      InputDecoration(
        fillColor: Colors.black,
        focusColor: Colors.black,
        floatingLabelStyle: const TextStyle(color: Colors.black),
        hintStyle: const TextStyle(color: Colors.black87),
        labelStyle: const TextStyle(color: Colors.black87),
        filled: false,
        hintText: hint,
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const Icon(Icons.email, color: Colors.black),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 3.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black54, width: 1.0),
        ),
      );
  TextFormField _buildEmailFormField() {
    return TextFormField(
      onSaved: (newValue) => setState(() => _email = newValue),
      onChanged: (value) => setState(() => _email = value),
      validator: (value) {
        if (value!.isEmpty) {
          return "Email Error";
        }
        return null;
      },
      style: const TextStyle(color: Colors.black),
      keyboardType: TextInputType.emailAddress,
      cursorColor: Colors.black,
      decoration: _getDecoration(hint: 'Email'),
    );
  }

  TextFormField _buildPasswordFormField() {
    return TextFormField(
      style: const TextStyle(color: Colors.black),
      obscureText: true,
      onSaved: (newValue) => setState(() => _password = newValue),
      onChanged: (value) {
        setState(() => _password = value);
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "Password Error";
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: _getDecoration(hint: 'Password'),
    );
  }
}
/**
 * widget.viewModel.isLoading
                      ? null
                      : _signInWithMailAndPassword,
 */
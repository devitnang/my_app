import 'package:flutter/material.dart';
import 'package:my_app/routes/app_route.dart';
import 'package:my_app/utils/dailog/dailog_error.dart';
import 'package:my_app/utils/dailog/dailog_success.dart';
import 'home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/models/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscureText = true;
  bool _isChecked = false;
  bool _isFormValid = false;

  void _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  FocusNode _emailNode = FocusNode();

  Future<void> saveCredential(User user) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    await preference.setString('sv8.16.pos.tokens', user.token ?? '');
  }

  void signIn() async {
    final email = 'devitnang@gmail.com';
    final password = 'Vit@1234';
    if (_formKey.currentState?.validate() == null) return;
    if (_formKey.currentState!.validate()) {
      if (_emailController.text == email &&
          _passwordController.text == password) {
        await saveCredential(
          User(
            token:
                'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyLCJleHAiOjI1MjQ2MDgwMDB9.S33_59_8Rj3_gB7y89uRE0C1q9T8B6W37_tYpD5f7_k',
            username: '',
            password: '',
          ),
        );
        if (!mounted) return;
        showDialog(
          context: context,
          builder: (context) => DialogSuccess(
            title: 'Success',
            message: 'Logged In successfully!',
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.home,
                (route) => false,
              );
            },
          ),
        );
      } else {
        if (!mounted) return;
        showDialog(
          context: context,
          builder: (context) => DialogError(
            title: 'Login Failed',
            message: 'Invalid Credential!',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        );
      }
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: LayoutBuilder(
          builder: (context, Constraints) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      onChanged: () {
                        setState(() {
                          _isFormValid =
                              _formKey.currentState?.validate() ?? false;
                        });
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/setec_logo.png',
                            width: 120,
                            height: 120,
                            fit: BoxFit.contain,
                          ),

                          SizedBox(height: 20),

                          Center(
                            child: Text(
                              'Welcome, BACK!',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ),

                          Center(
                            child: Text(
                              'Please login to continue',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ),

                          SizedBox(height: 30),

                          TextFormField(
                            controller: _emailController,
                            focusNode: _emailNode,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Colors.black,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null ||
                                  value.replaceAll(' ', '').isEmpty) {
                                return 'Please enter email address!';
                              }
                              RegExp emailRegex = RegExp(
                                r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]',
                              );
                              if (!emailRegex.hasMatch(value)) {
                                return 'Invalid email format!';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.grey.withValues(alpha: 0.25),
                              filled: true,
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.green),
                              hintText: 'example@gmail.com',
                              prefixIcon: Icon(Icons.alternate_email),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _emailController.clear();
                                  });
                                },
                                icon: Icon(Icons.clear),
                              ),
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.green),
                              ),
                            ),
                          ),

                          SizedBox(height: 20),

                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscureText,
                            cursorColor: Colors.black,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              }
                              // Strong password [a-z], [A-Z], [0-9], !@#%^&*()
                              RegExp passwordRegex = RegExp(
                                r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#%^&*()]).{8,}$',
                              );
                              if (!passwordRegex.hasMatch(value)) {
                                return 'Invalid password format!';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.grey.withValues(alpha: 0.25),
                              filled: true,
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.green),
                              hintText: 'Enter your password',
                              prefixIcon: Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                onPressed: _togglePassword,
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.green),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 5),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: _isChecked,
                              activeColor: Colors.green,
                              onChanged: (value) {
                                _isChecked = value ?? false;
                                setState(() {});
                                print(value);
                              },
                            ),
                            Text('Remember Me', style: TextStyle(fontSize: 14)),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            print('Forgot Password pressed');
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),

                    SizedBox(
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _isFormValid ? signIn : null,
                        // onPressed: signIn() {
                        //   // if (_isChecked) {
                        //   //   print('Save');
                        //   // } else {
                        //   //   print('Never save');
                        //   // }
                        //   // Navigator.pushAndRemoveUntil(
                        //   //   context,
                        //   //   MaterialPageRoute(
                        //   //     builder: (context) => const HomeScreen(),
                        //   //   ),
                        //   //   (route) => false,
                        //   // );
                        // },
                        style: ButtonStyle(
                          shadowColor: WidgetStateColor.resolveWith(
                            (states) => states.contains(WidgetState.disabled)
                                ? Colors.transparent
                                : Colors.black.withValues(alpha: 0.25),
                          ),
                          elevation: WidgetStatePropertyAll(10),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          backgroundColor: WidgetStateProperty.resolveWith(
                            (states) => states.contains(WidgetState.disabled)
                                ? Colors.green.withValues(alpha: 0.25)
                                : Colors.green,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Login',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 15),
                            Icon(Icons.login, color: Colors.white),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 25),

                    Row(
                      children: [
                        Expanded(child: Divider()), // Line -
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'OR',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),

                    SizedBox(height: 25),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 36,
                          height: 36,
                          child: OutlinedButton(
                            onPressed: () {
                              print('Google Login pressed');
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.grey.shade200),
                              shape: CircleBorder(),
                              padding: EdgeInsets.zero,
                            ),
                            child: Image.asset(
                              'assets/images/google.png',
                              width: 24,
                              height: 24,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        SizedBox(
                          width: 36,
                          height: 36,
                          child: OutlinedButton(
                            onPressed: () {
                              print('Facebook Login pressed');
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.grey.shade200),
                              shape: CircleBorder(),
                              padding: EdgeInsets.zero,
                            ),
                            child: Icon(
                              Icons.facebook,
                              color: Color(0xFF1877F2),
                              size: 28,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an account? '),
                        TextButton(
                          onPressed: () {
                            print('Register pressed');
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

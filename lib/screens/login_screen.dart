import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fitflick/screens/register_screen.dart';
import 'package:fitflick/screens/home_screen.dart';
import 'package:fitflick/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter both email and password.'),
          backgroundColor: Color(0xFFB71D3F),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authService.login(email: email, password: password);
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        String message = 'Login failed. Please try again.';
        if (e.toString().contains('user-not-found')) {
          message = 'No account found for that email.';
        } else if (e.toString().contains('wrong-password') ||
            e.toString().contains('invalid-credential')) {
          message = 'Incorrect password.';
        } else if (e.toString().contains('invalid-email')) {
          message = 'Invalid email address.';
        } else if (e.toString().contains('too-many-requests')) {
          message = 'Too many attempts. Please try again later.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: const Color(0xFFB71D3F),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9), // surface color
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1C1C)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'LOGIN',
          style: GoogleFonts.beVietnamPro(
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.5,
              color: Color(0xFF1A1C1C),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Decorative Background Element (Asymmetric Editorial Style)
          Positioned(
            bottom: -96,
            right: -96,
            child: Container(
              width: 256,
              height: 256,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFC536D).withValues(alpha: 0.05), // secondary-container
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFC536D).withValues(alpha: 0.05),
                    blurRadius: 40,
                    spreadRadius: 40,
                  )
                ]
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.25,
            left: -48,
            child: Container(
              width: 192,
              height: 192,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF1A1A2E).withValues(alpha: 0.05), // primary-container
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1A1A2E).withValues(alpha: 0.05),
                    blurRadius: 40,
                    spreadRadius: 40,
                  )
                ]
              ),
            ),
          ),
          
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 48), // mt-24 mb-12 approximation

                        // Logo Section
                        Text(
                          'FitFlick',
                          style: GoogleFonts.beVietnamPro(
                            textStyle: const TextStyle(
                              color: Color(0xFF00000B), // primary
                              fontWeight: FontWeight.w900,
                              fontSize: 30, // text-3xl
                              letterSpacing: 6.0, // tracking-[0.25em] approx
                            ),
                          ),
                        ),
                        const SizedBox(height: 48),

                        Text(
                          'Welcome Back',
                          style: GoogleFonts.beVietnamPro(
                            textStyle: const TextStyle(
                              color: Color(0xFF1A1C1C), // on-surface
                              fontWeight: FontWeight.bold,
                              fontSize: 24, // text-2xl
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),

                        Text(
                          'Log in to continue shopping',
                          style: GoogleFonts.plusJakartaSans(
                            textStyle: const TextStyle(
                              color: Color(0xFF47464C), // on-surface-variant
                              fontSize: 14, // text-sm
                            ),
                          ),
                        ),
                        const SizedBox(height: 48), // mt flex spacing
                        
                        // Form Section
                        _buildTextField(
                          hintText: 'Email Address',
                          obscureText: false,
                          controller: _emailController,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          hintText: 'Password',
                          obscureText: true,
                          controller: _passwordController,
                        ),
                        
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              foregroundColor: const Color(0xFF00000B), // primary hover effect simulation
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Forgot Password?',
                              style: GoogleFonts.plusJakartaSans(
                                textStyle: const TextStyle(
                                  color: Color(0xFF47464C), // on-surface-variant
                                  fontSize: 12, // text-[12px]
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _handleLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1A1A2E), // primary-container
                              foregroundColor: Colors.white, // on-primary
                              disabledBackgroundColor: const Color(0xFF1A1A2E).withValues(alpha: 0.6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12), // rounded-xl
                              ),
                              elevation: 0,
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    'LOGIN',
                                    style: GoogleFonts.plusJakartaSans(
                                      textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.4, // uppercase tracking
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Social Login / Alternative Divider
                        Row(
                          children: [
                            const Expanded(child: Divider(color: Color(0xFFEEEEEE), thickness: 1)),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                'OR CONTINUE VIA',
                                style: GoogleFonts.plusJakartaSans(
                                  textStyle: const TextStyle(
                                    color: Color(0xFFC8C5CD), // outline-variant
                                    fontSize: 12, // text-xs
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                            ),
                            const Expanded(child: Divider(color: Color(0xFFEEEEEE), thickness: 1)),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Social Login Buttons
                        Row(
                          children: [
                            Expanded(
                              child: _buildOutlinedButton(icon: Icons.api), // placeholder for brand_awareness
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildOutlinedButton(icon: Icons.fingerprint),
                            ),
                          ],
                        ),

                        const Spacer(),

                        // Footer Link
                        Padding(
                          padding: const EdgeInsets.only(top: 48, bottom: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: GoogleFonts.plusJakartaSans(
                                  textStyle: const TextStyle(
                                    color: Color(0xFF1A1C1C), // on-surface
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (_) => const RegisterScreen()),
                                  );
                                },
                                child: Text(
                                  "Register",
                                  style: GoogleFonts.plusJakartaSans(
                                    textStyle: const TextStyle(
                                      color: Color(0xFF1A1C1C),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    required bool obscureText,
    required TextEditingController controller,
  }) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white, // surface-container-lowest
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFEEEEEE), // surface-container
          width: 1.5,
        ),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: GoogleFonts.plusJakartaSans(
          textStyle: const TextStyle(
            color: Color(0xFF1A1C1C), // on-surface
            fontSize: 16,
          ),
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0xFFC8C5CD), // outline-variant
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), // adjusted for height 52
        ),
      ),
    );
  }

  Widget _buildOutlinedButton({required IconData icon}) {
    return SizedBox(
      height: 52,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white, // bg-surface-container-lowest
          side: const BorderSide(color: Color(0xFFEEEEEE), width: 1.5), // border-surface-container
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Icon(icon, color: const Color(0xFF1A1C1C)),
      ),
    );
  }
}

import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitflick/screens/home_screen.dart';
import 'package:fitflick/services/auth_service.dart';
import 'package:fitflick/data/app_data.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscurePassword = true;
  final bool _obscureConfirmPassword = true;
  bool _agreeTerms = false;
  bool _isLoading = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _authService = AuthService();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields.'),
          backgroundColor: Color(0xFFB71D3F),
        ),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match.'),
          backgroundColor: Color(0xFFB71D3F),
        ),
      );
      return;
    }

    if (!_agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please agree to the Terms of Service.'),
          backgroundColor: Color(0xFFB71D3F),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final credential = await _authService.signUp(email: email, password: password);
      // Update the display name
      await credential.user?.updateDisplayName(name);
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        String message = 'Registration failed. Please try again.';
        if (e.toString().contains('email-already-in-use')) {
          message = 'An account with this email already exists.';
        } else if (e.toString().contains('weak-password')) {
          message = 'Password is too weak. Use at least 6 characters.';
        } else if (e.toString().contains('invalid-email')) {
          message = 'Invalid email address.';
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
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64), // h-16
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // backdrop-blur-xl simulation
            child: AppBar(
              backgroundColor: const Color(0xFFF8FAFC).withValues(alpha: 0.8), // slate-50/80
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)), // slate-900
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                'REGISTER',
                style: GoogleFonts.beVietnamPro(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                    color: Color(0xFF0F172A), // text-slate-900
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0), // px-6
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 96), // pt-24

              // Hero Editorial Section
              Container(
                height: 192, // h-48
                margin: const EdgeInsets.only(bottom: 48), // mb-12
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F3F3), // surface-container-low
                  borderRadius: BorderRadius.circular(12), // rounded-xl
                  image: const DecorationImage(
                    image: NetworkImage(
                      AppData.registerHeroImage
                    ),
                    fit: BoxFit.cover,
                    opacity: 0.8, // opacity-80
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 24,
                      left: 24,
                      right: 24,
                      child: Text(
                        'Join The\nFitFlick',
                        style: GoogleFonts.beVietnamPro(
                          textStyle: const TextStyle(
                            fontSize: 30, // text-3xl
                            fontWeight: FontWeight.w800, // font-extrabold
                            height: 1.0, // leading-none
                            letterSpacing: -1.0, // tracking-tighter
                            color: Color(0xFF00000B), // text-primary
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Registration Form
              _buildLabeledField(
                label: 'FULL NAME',
                hintText: 'Alexander McQueen',
                obscureText: false,
                controller: _nameController,
              ),
              const SizedBox(height: 24), // space-y-6 roughly
              
              _buildLabeledField(
                label: 'EMAIL ADDRESS',
                hintText: 'alexander@archive.com',
                obscureText: false,
                controller: _emailController,
              ),
              const SizedBox(height: 24),

              _buildLabeledField(
                label: 'PASSWORD',
                hintText: '••••••••',
                obscureText: _obscurePassword,
                controller: _passwordController,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    color: const Color(0xFFC8C5CD),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
              const SizedBox(height: 24),

              _buildLabeledField(
                label: 'CONFIRM PASSWORD',
                hintText: '••••••••',
                obscureText: _obscureConfirmPassword,
                controller: _confirmPasswordController,
              ),
              const SizedBox(height: 24),

              // Terms
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _agreeTerms = !_agreeTerms;
                      });
                    },
                    child: Container(
                      width: 20, // h-5 w-5
                      height: 20,
                      margin: const EdgeInsets.only(top: 2, right: 12),
                      decoration: BoxDecoration(
                        color: Colors.white, // surface-container-lowest
                        border: Border.all(color: const Color(0xFFC8C5CD)), // outline-variant
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: _agreeTerms
                          ? Center(
                              child: Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF00000B), // primary
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            )
                          : null,
                    ),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.plusJakartaSans(
                          textStyle: const TextStyle(
                            color: Color(0xFF47464C), // on-surface-variant
                            fontSize: 12,
                            height: 1.5,
                          ),
                        ),
                        children: [
                          const TextSpan(text: 'I agree to the '),
                          TextSpan(
                            text: 'Terms of Service',
                            style: const TextStyle(
                              color: Color(0xFF00000B), // primary
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationColor: Color(0x3300000B), // primary/20
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                          const TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: const TextStyle(
                              color: Color(0xFF00000B),
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationColor: Color(0x3300000B),
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                          const TextSpan(text: '.'),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 32),

              // Submit Button
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00000B).withValues(alpha: 0.1), // shadow-primary/10
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleRegister,
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
                            'REGISTER',
                            style: GoogleFonts.plusJakartaSans(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.4, // uppercase tracking
                              ),
                            ),
                          ),
                  ),
                ),
              ),

              // Secondary Action
              const SizedBox(height: 48), // mt-12
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: GoogleFonts.plusJakartaSans(
                      textStyle: const TextStyle(
                        color: Color(0xFF47464C), // on-surface-variant
                        fontSize: 14,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0x3300000B), // primary/20
                            width: 1.5,
                          ),
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: GoogleFonts.plusJakartaSans(
                          textStyle: const TextStyle(
                            color: Color(0xFF00000B), // primary
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Decorative Curator Quote
              const SizedBox(height: 64), // mt-16
              Container(
                padding: const EdgeInsets.only(top: 48), // pt-12
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: const Color(0xFFC8C5CD).withValues(alpha: 0.1), // outline-variant/10
                    ),
                  ),
                ),
                child: Text(
                  '"Fashion is the armor to survive the reality of everyday life."',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.beVietnamPro(
                    textStyle: TextStyle(
                      color: const Color(0xFF47464C).withValues(alpha: 0.4), // on-surface-variant/40
                      fontSize: 14, // text-sm
                      fontStyle: FontStyle.italic,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabeledField({
    required String label,
    required String hintText,
    required bool obscureText,
    required TextEditingController controller,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              textStyle: const TextStyle(
                color: Color(0xFF47464C), // text-on-surface-variant
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0, // tracking-widest
              ),
            ),
          ),
        ),
        Container(
          height: 52,
          decoration: BoxDecoration(
            color: Colors.white, // surface-container-lowest
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFC8C5CD).withValues(alpha: 0.4), // outline-variant/40
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
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: suffixIcon != null ? 14 : 14,
              ), // adjusted for height
              suffixIcon: suffixIcon,
            ),
          ),
        ),
      ],
    );
  }
}

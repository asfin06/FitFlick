import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fitflick/screens/login_screen.dart';
import 'package:fitflick/data/app_data.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1A1A2E), // primary-container
                  Color(0xFF45455B), // primary-container-variant
                ],
              ),
            ),
          ),

          // Abstract Background Decorative Elements
          Positioned(
            top: -size.height * 0.1,
            right: -size.width * 0.1,
            width: size.width * 0.6,
            height: size.height * 0.6,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFB71D3F).withValues(alpha: 0.05),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -size.height * 0.05,
            left: -size.width * 0.05,
            width: size.width * 0.4,
            height: size.height * 0.4,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF00000B).withValues(alpha: 0.20),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),

          // Main Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Atmospheric Branding Wrapper
                Opacity(
                  opacity: 0.9,
                  child: Container(
                    width: 64,
                    height: 1,
                    color: Colors.white.withValues(alpha: 0.2),
                    margin: const EdgeInsets.only(bottom: 32),
                  ),
                ),

                // Main Brand Identity
                Text(
                  AppData.appName,
                  style: GoogleFonts.beVietnamPro(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 64,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -2.0,
                      height: 1.0,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Tagline
                Text(
                  AppData.appTagline,
                  style: GoogleFonts.plusJakartaSans(
                    textStyle: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 4.0,
                    ),
                  ),
                ),

                const SizedBox(height: 96),

                // Loading Indicator / Interaction Cue
                SizedBox(
                  width: 48,
                  height: 48,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.1),
                            width: 2,
                          ),
                        ),
                      ),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Footer / Credits
          Positioned(
            bottom: 48,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                AppData.appFooter,
                style: GoogleFonts.plusJakartaSans(
                  textStyle: TextStyle(
                    color: Colors.white.withValues(alpha: 0.3),
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ),
          ),

          // Bottom Border Accent
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 4,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    const Color(0xFFB71D3F).withValues(alpha: 0.3),
                    Colors.transparent,
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

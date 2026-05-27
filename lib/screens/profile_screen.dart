import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitflick/screens/login_screen.dart';
import 'package:fitflick/screens/edit_profile_screen.dart';
import 'package:fitflick/screens/order_history_screen.dart';
import 'package:fitflick/widgets/bottom_nav_bar.dart';
import 'package:fitflick/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9), // surface color
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64), // h-16
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20), // backdrop-blur-xl
            child: AppBar(
              backgroundColor: const Color(0xFFF9F9F9).withValues(alpha: 0.8), // F9F9F9/80
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A2E)),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                'ACCOUNT',
                style: GoogleFonts.beVietnamPro(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0, // tracking-widest
                    color: Color(0xFF1A1A2E), // text-[#1A1A2E]
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.shopping_bag, color: Color(0xFF94A3B8)), // slate-400
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 96, bottom: 128, left: 16, right: 16), // pt-24 pb-32 px-4
        child: Column(
          children: [
            StreamBuilder<Map<String, dynamic>?>(
              stream: FirestoreService().getUserProfileStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: Padding(padding: EdgeInsets.all(48.0), child: CircularProgressIndicator(color: Color(0xFF1A1A2E))));
                }
                final userData = snapshot.data ?? {};
                final String name = userData['name'] ?? 'Guest User';
                final String email = userData['email'] ?? FirebaseAuth.instance.currentUser?.email ?? 'guest@example.com';
                final String imageUrl = userData['profileImageUrl'] ?? 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=200&h=200';
                final int ordersCount = userData['ordersCount'] ?? 12;
                final int wishlistCount = userData['wishlistCount'] ?? 4;
                final int pointsCount = userData['pointsCount'] ?? 850;

                return Column(
                  children: [
                    // Profile Header
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: 112, // w-28
                          height: 112, // h-28
                          margin: const EdgeInsets.only(bottom: 24), // mb-6 total but logic applies
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFFE8E8E8), width: 2), // border-surface-container-high
                          ),
                          padding: const EdgeInsets.all(4), // p-1
                          child: ClipOval(
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 24, // adjust for margin
                          right: 4, // right-1
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6), // p-1.5
                              decoration: BoxDecoration(
                                color: const Color(0xFF00000B), // primary
                                shape: BoxShape.circle,
                                border: Border.all(color: const Color(0xFFF9F9F9), width: 2), // border-surface
                              ),
                              child: const Icon(Icons.edit, color: Colors.white, size: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      name,
                      style: GoogleFonts.plusJakartaSans(
                        textStyle: const TextStyle(
                          fontSize: 24, // text-2xl
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5, // tracking-tight
                          color: Color(0xFF1A1C1C), // on-surface
                        ),
                      ),
                    ),
                    const SizedBox(height: 4), // mb-1 equiv
                    Text(
                      email,
                      style: GoogleFonts.plusJakartaSans(
                        textStyle: const TextStyle(
                          fontSize: 14, // text-sm
                          fontWeight: FontWeight.w500, // font-medium
                          letterSpacing: 0.5, // tracking-wide
                          color: Color(0xFF78767D), // outline
                        ),
                      ),
                    ),
                    const SizedBox(height: 40), // mb-10

                    // Stats Section
                    Row(
                      children: [
                        Expanded(child: _buildStatCard(ordersCount.toString(), 'ORDERS')),
                        const SizedBox(width: 16), // gap-4
                        Expanded(child: _buildStatCard(wishlistCount.toString(), 'WISHLIST')),
                        const SizedBox(width: 16),
                        Expanded(child: _buildStatCard(pointsCount.toString(), 'POINTS')),
                      ],
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 40), // mb-10

            // Navigation List
            Column(
              children: [
                _buildNavItem(
                  context: context,
                  icon: Icons.local_shipping,
                  label: 'My Orders',
                  iconBgColor: const Color(0xFFE2E0FC),
                  iconColor: const Color(0xFF1A1A2E),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const OrderHistoryScreen())),
                ),
                const SizedBox(height: 12),
                _buildNavItem(context: context, icon: Icons.location_on, label: 'Shipping Addresses', iconBgColor: const Color(0xFFE8E8E8), iconColor: const Color(0xFF00000B)),
                const SizedBox(height: 12),
                _buildNavItem(context: context, icon: Icons.payments, label: 'Payment Methods', iconBgColor: const Color(0xFFE8E8E8), iconColor: const Color(0xFF00000B)),
                const SizedBox(height: 12),
                _buildNavItem(context: context, icon: Icons.favorite, label: 'My Wishlist', iconBgColor: const Color(0xFFE8E8E8), iconColor: const Color(0xFF00000B)),
                const SizedBox(height: 12),
                _buildNavItem(context: context, icon: Icons.notifications, label: 'Notifications', iconBgColor: const Color(0xFFE8E8E8), iconColor: const Color(0xFF00000B), hasDot: true),
                const SizedBox(height: 12),
                _buildNavItem(context: context, icon: Icons.settings, label: 'Settings', iconBgColor: const Color(0xFFE8E8E8), iconColor: const Color(0xFF00000B)),
              ],
            ),
            const SizedBox(height: 40), // mt-10

            // Logout Section
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // surface-container-lowest
                foregroundColor: const Color(0xFFBA1A1A), // error
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // rounded-xl
                  side: BorderSide(color: const Color(0xFFFFDAD6)), // error-container
                ),
                padding: const EdgeInsets.symmetric(vertical: 20), // p-5
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.logout, size: 20),
                  const SizedBox(width: 12), // gap-3
                  Text(
                     'LOGOUT',
                     style: GoogleFonts.plusJakartaSans(
                       textStyle: const TextStyle(
                         fontSize: 12, // text-xs
                         fontWeight: FontWeight.bold,
                         letterSpacing: 2.0, // tracking-widest
                       ),
                     ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 3),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.all(16), // p-4
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3), // surface-container-low
        borderRadius: BorderRadius.circular(12), // rounded-xl
      ),
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              textStyle: const TextStyle(
                fontSize: 18, // text-lg
                fontWeight: FontWeight.bold,
                color: Color(0xFF00000B), // primary
              ),
            ),
          ),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              textStyle: const TextStyle(
                fontSize: 10, // text-[10px]
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0, // tracking-widest
                color: Color(0xFF78767D), // outline
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color iconBgColor,
    required Color iconColor,
    bool hasDot = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
      padding: const EdgeInsets.all(16), // p-4
      decoration: BoxDecoration(
        color: Colors.white, // surface-container-lowest
        borderRadius: BorderRadius.circular(12), // rounded-xl
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03), // shadow-[0_4px_20px_rgba(0,0,0,0.03)]
            blurRadius: 20,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40, // w-10
                height: 40, // h-10
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(8), // rounded-lg
                ),
                alignment: Alignment.center,
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 16), // gap-4
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  textStyle: const TextStyle(
                    fontSize: 14, // text-sm
                    fontWeight: FontWeight.w600, // font-semibold
                    color: Color(0xFF1A1C1C), // on-surface
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              if (hasDot)
                Container(
                  width: 8, // w-2
                  height: 8, // h-2
                  decoration: const BoxDecoration(
                    color: Color(0xFFB71D3F), // secondary
                    shape: BoxShape.circle,
                  ),
                ),
              if (hasDot) const SizedBox(width: 8), // gap-2
              const Icon(Icons.chevron_right, color: Color(0xFF78767D), size: 24), // outline
            ],
          ),
        ],
      ),
      ),
    );
  }

}

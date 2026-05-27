import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitflick/widgets/bottom_nav_bar.dart';
import 'package:fitflick/services/firestore_service.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _isPublicProfile = true; // toggle is ON by default (ml-auto dot = right side)

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await FirestoreService().getUserProfile();
    if (userData != null && mounted) {
      setState(() {
        _nameController.text = userData['name'] ?? '';
        _emailController.text = userData['email'] ?? '';
        _phoneController.text = userData['phone'] ?? '';
      });
    }
    // Initialize with empty so it's not null before microtask finishes
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9), // surface
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64), // h-16
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20), // backdrop-blur-xl
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFFF9F9F9).withValues(alpha: 0.95), // tonal-transition-bg
                    const Color(0xFFF9F9F9).withValues(alpha: 0.8),
                  ],
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: SizedBox(
                  height: 64,
                  child: Row(
                    children: [
                      // Left: back button (w-1/4)
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: IconButton(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 16),
                          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A2E)),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                      // Center: title (w-2/4)
                      Expanded(
                        child: Center(
                          child: Text(
                            'EDIT PROFILE',
                            style: GoogleFonts.beVietnamPro(
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.5, // tracking-tight
                                color: Color(0xFF1A1A2E),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Right: spacer (w-1/4)
                      SizedBox(width: MediaQuery.of(context).size.width / 4),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 96, bottom: 128, left: 24, right: 24), // pt-24 pb-32 px-6
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profile Picture Section
            Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: 128, // w-32
                      height: 128, // h-32
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4), // border-4 border-surface-container-lowest
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08), // shadow-sm
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          )
                        ],
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: StreamBuilder<Map<String, dynamic>?>(
                        stream: FirestoreService().getUserProfileStream(),
                        builder: (context, snapshot) {
                          final imageUrl = snapshot.data?['profileImageUrl'] ?? 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=200&h=200';
                          return Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                          );
                        }
                      ),
                    ),
                    Positioned(
                      bottom: 4, // bottom-1
                      right: 4,  // right-1
                      child: Container(
                        padding: const EdgeInsets.all(8), // p-2
                        decoration: BoxDecoration(
                          color: const Color(0xFF00000B), // primary
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.15), // shadow-md
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            )
                          ],
                        ),
                        child: const Icon(Icons.photo_camera, color: Colors.white, size: 16), // text-sm
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16), // mt-4
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Change Photo',
                    style: GoogleFonts.plusJakartaSans(
                      textStyle: const TextStyle(
                        fontSize: 14, // text-sm
                        fontWeight: FontWeight.w600, // font-semibold
                        letterSpacing: 0.5, // tracking-wide
                        color: Color(0xFFB71D3F), // secondary
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40), // mb-10

            // Form Section
            Container(
              padding: const EdgeInsets.all(24), // p-6
              decoration: BoxDecoration(
                color: Colors.white, // surface-container-lowest
                borderRadius: BorderRadius.circular(16), // rounded-lg
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1A1C1C).withValues(alpha: 0.04), // shadow-[0_4px_32px_rgba(26,28,28,0.04)]
                    blurRadius: 32,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildFormField(
                    label: 'FULL NAME',
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 24), // space-y-6
                  _buildFormField(
                    label: 'EMAIL ADDRESS',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 24),
                  _buildFormField(
                    label: 'PHONE NUMBER',
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 24), // pt-4 roughly
                  // Change Password Button
                  SizedBox(
                    height: 52, // h-[52px]
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white, // surface-container-lowest
                        side: const BorderSide(color: Color(0xFF1A1A2E), width: 2), // border-2 border-primary-container
                        foregroundColor: const Color(0xFF1A1A2E), // primary-container
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // rounded-lg
                        ),
                      ),
                      child: Text(
                        'CHANGE PASSWORD',
                        style: GoogleFonts.plusJakartaSans(
                          textStyle: const TextStyle(
                            fontSize: 12, // text-xs
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0, // tracking-widest
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32), // mt-8

            // Privacy Toggle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8), // px-2
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Public Profile',
                        style: GoogleFonts.plusJakartaSans(
                          textStyle: const TextStyle(
                            fontSize: 14, // text-sm
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.3, // tracking-tight
                            color: Color(0xFF1A1C1C), // on-surface
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Allow others to see your wishlist',
                        style: GoogleFonts.plusJakartaSans(
                          textStyle: const TextStyle(
                            fontSize: 12, // text-xs
                            color: Color(0xFF47464C), // on-surface-variant
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Custom Toggle
                  GestureDetector(
                    onTap: () => setState(() => _isPublicProfile = !_isPublicProfile),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 48, // w-12
                      height: 24, // h-6
                      padding: const EdgeInsets.all(4), // px-1
                      decoration: BoxDecoration(
                        color: _isPublicProfile
                            ? const Color(0xFF1A1A2E) // primary-container (on)
                            : const Color(0xFFC8C5CD), // outline-variant (off)
                        borderRadius: BorderRadius.circular(24), // rounded-full
                      ),
                      child: Row(
                        mainAxisAlignment: _isPublicProfile ? MainAxisAlignment.end : MainAxisAlignment.start, // ml-auto when active
                        children: [
                          Container(
                            width: 16, // w-4
                            height: 16, // h-4
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40), // mt-10

            // Save Changes Button
            Container(
              height: 52, // h-[52px]
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1A1A2E).withValues(alpha: 0.2), // shadow-lg
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  )
                ],
              ),
              child: ElevatedButton(
                onPressed: () async {
                  await FirestoreService().updateUserProfile({
                    'name': _nameController.text,
                    'email': _emailController.text,
                    'phone': _phoneController.text,
                  });
                  if (context.mounted) {
                    Navigator.of(context).pop(); // Save and go back to profile
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A1A2E), // primary-container
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // rounded-lg
                  ),
                ),
                child: Text(
                  'SAVE CHANGES',
                  style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                      fontSize: 14, // text-sm
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0, // tracking-widest
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 3),
    );
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8), // ml-1 space-y-2
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              textStyle: const TextStyle(
                fontSize: 10, // text-[10px]
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0, // tracking-widest
                color: Color(0xFF47464C), // on-surface-variant
              ),
            ),
          ),
        ),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: GoogleFonts.plusJakartaSans(
            textStyle: const TextStyle(
              fontSize: 14, // text-sm
              color: Color(0xFF1A1C1C), // on-surface
            ),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white, // surface-container-lowest
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16), // px-4 h-[52px]
            constraints: const BoxConstraints(minHeight: 52), // h-[52px]
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8), // rounded-lg
              borderSide: BorderSide(
                color: const Color(0xFFC8C5CD).withValues(alpha: 0.4), // border-outline-variant/40
                width: 1.5, // border-[1.5px]
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: const Color(0xFFC8C5CD).withValues(alpha: 0.4),
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFF00000B), // primary — focus:border-primary
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

}

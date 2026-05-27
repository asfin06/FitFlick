import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitflick/screens/cart_screen.dart';
import 'package:fitflick/widgets/bottom_nav_bar.dart';
import 'package:fitflick/data/app_data.dart';
import 'package:fitflick/services/firestore_service.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String selectedSize = 'IT 48';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9), // surface color
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56), // h-[56px]
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20), // backdrop-blur-xl
            child: AppBar(
              backgroundColor: Colors.white.withValues(alpha: 0.8), // bg-white/80
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A2E)), // on-primary-fixed
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                'PRODUCT DETAILS',
                style: GoogleFonts.beVietnamPro(
                  textStyle: const TextStyle(
                    fontSize: 18, // text-lg
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5, // tracking-tight
                    color: Color(0xFF45455B), // primary-fixed-variant mapped closely
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.share_outlined, color: Color(0xFF1A1A2E)),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 120), // pb-24 approx to avoid overlap with bottom bar
        child: Column(
          children: [
            // Safearea top padding equivalent manually handled by the image starting at top
            // but we need the image to go under the appbar, so no padding top here.
            
            // Editorial Product Showcase
            AspectRatio(
              aspectRatio: 3 / 4,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    color: const Color(0xFFF3F3F3), // surface-container-low
                    child: Image.network(
                      AppData.productDetail['imageUrl'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Floating Wishlist Button
                  Positioned(
                    bottom: 24, // bottom-6
                    right: 24, // right-6
                    child: Container(
                      width: 48, // w-12
                      height: 48, // h-12
                      decoration: BoxDecoration(
                        color: Colors.white, // surface-container-lowest
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08), // shadow-[0_8px_30px_rgb(0,0,0,0.08)]
                            blurRadius: 30,
                            offset: const Offset(0, 8),
                          )
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.favorite, color: Color(0xFFB71D3F)), // text-secondary
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Product Details Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0), // px-4 mt-8
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header Info
                  Text(
                    AppData.productDetail['title'],
                    style: GoogleFonts.beVietnamPro(
                      textStyle: const TextStyle(
                        fontSize: 30, // text-3xl
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5, // tracking-tight
                        color: Color(0xFF00000B), // text-primary
                      ),
                    ),
                  ),
                  const SizedBox(height: 8), // gap-2
                  Text(
                    AppData.productDetail['price'],
                    style: GoogleFonts.beVietnamPro(
                      textStyle: const TextStyle(
                        fontSize: 20, // text-xl
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFB71D3F), // text-secondary
                      ),
                    ),
                  ),
                  const SizedBox(height: 32), // gap-8

                  // Description Section
                  Text(
                    'Description',
                    style: GoogleFonts.beVietnamPro(
                      textStyle: const TextStyle(
                        fontSize: 18, // text-lg
                        fontWeight: FontWeight.w600, // font-semibold
                        letterSpacing: -0.5,
                        color: Color(0xFF00000B),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12), // gap-3
                  Text(
                    AppData.productDetail['description'],
                    style: GoogleFonts.plusJakartaSans(
                      textStyle: const TextStyle(
                        fontSize: 14, // text-sm
                        height: 1.6, // leading-relaxed
                        color: Color(0xFF47464C), // on-surface-variant
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Size Selector Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select Size',
                        style: GoogleFonts.beVietnamPro(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.5,
                            color: Color(0xFF00000B),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 2), // pb-0.5
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: const Color(0xFFB71D3F).withValues(alpha: 0.3), // border-secondary/30
                            ),
                          ),
                        ),
                        child: Text(
                          'SIZE GUIDE',
                          style: GoogleFonts.plusJakartaSans(
                            textStyle: const TextStyle(
                              fontSize: 12, // text-xs
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0, // tracking-widest
                              color: Color(0xFFB71D3F),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16), // gap-4 
                  Wrap(
                    spacing: 12, // gap-3
                    runSpacing: 12,
                    children: AppData.productDetail['sizes']
                        .map<Widget>((size) => _buildSizePill(size))
                        .toList(),
                  ),
                  const SizedBox(height: 32),

                  // Metadata Bento (The Curator's Touch)
                  Row(
                    children: [
                      Expanded(child: _buildBentoCard(Icons.auto_awesome, 'Material', AppData.productDetail['material'])),
                      const SizedBox(width: 16), // gap-4
                      Expanded(child: _buildBentoCard(Icons.public, 'Origin', AppData.productDetail['origin'])),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ADD TO CART action bar
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                color: Colors.white.withValues(alpha: 0.9),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () async {
                            await FirestoreService().addToCart(
                              AppData.productDetail,
                              selectedSize: selectedSize,
                            );
                            if (context.mounted) {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => const CartScreen()),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFB71D3F),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'ADD TO CART',
                            style: GoogleFonts.beVietnamPro(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A2E),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const AppBottomNavBar(currentIndex: 1),
        ],
      ),
    );
  }

  Widget _buildSizePill(String size) {
    bool isSelected = selectedSize == size;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSize = size;
        });
      },
      child: Container(
        height: 48, // h-12
        padding: const EdgeInsets.symmetric(horizontal: 32), // px-8
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1A1A2E) : Colors.white, // primary-container vs surface-container-lowest
          borderRadius: BorderRadius.circular(24), // rounded-full
          border: isSelected ? null : Border.all(color: const Color(0xFFC8C5CD)), // outline-variant
        ),
        alignment: Alignment.center,
        child: Text(
          size,
          style: GoogleFonts.plusJakartaSans(
            textStyle: TextStyle(
              fontSize: 14, // text-sm
              fontWeight: FontWeight.w600, // font-semibold
              color: isSelected ? Colors.white : const Color(0xFF47464C), // white vs on-surface-variant
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBentoCard(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(16), // p-4
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3), // surface-container-low
        borderRadius: BorderRadius.circular(12), // rounded-xl
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF45455B), size: 24), // text-primary-fixed-variant
          const SizedBox(height: 8), // gap-2
          Text(
            label.toUpperCase(),
            style: GoogleFonts.plusJakartaSans(
              textStyle: const TextStyle(
                fontSize: 12, // text-xs
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0, // tracking-widest
                color: Color(0xFF45455B), // text-on-primary-fixed-variant
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              textStyle: const TextStyle(
                fontSize: 14, // text-sm
                fontWeight: FontWeight.w500, // font-medium
                color: Color(0xFF1A1C1C),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

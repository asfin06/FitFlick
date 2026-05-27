import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitflick/widgets/bottom_nav_bar.dart';
import 'package:fitflick/data/app_data.dart';
import 'package:fitflick/services/firestore_service.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9), // surface color
      extendBodyBehindAppBar: true,
      extendBody: true, // for floating bottom nav
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64), // h-16
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12), // backdrop-blur-md
            child: AppBar(
              backgroundColor: const Color(0xFFF9F9F9).withValues(alpha: 0.8), // F9F9F9/80
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.menu, color: Color(0xFF1A1A2E)), 
                onPressed: () {},
              ),
              title: Text(
                'FITFLICK',
                style: GoogleFonts.beVietnamPro(
                  textStyle: const TextStyle(
                    fontSize: 24, // text-2xl
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5, // tracking-[-0.02em]
                    color: Color(0xFF1A1A2E), // text-[#1A1A2E]
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.shopping_bag_outlined, color: Color(0xFF1A1A2E)),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 96, bottom: 128, left: 16, right: 16), // pt-24 pb-32 px-4
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Search Section
              Container(
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.white, // surface-container-lowest
                  borderRadius: BorderRadius.circular(12), // rounded-xl
                  border: Border.all(color: const Color(0xFFC8C5CD).withValues(alpha: 0.4), width: 1.5), // border-outline-variant/40
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Color(0xFF78767D)), // text-outline
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        style: GoogleFonts.plusJakartaSans(fontSize: 14),
                        decoration: InputDecoration(
                          hintText: 'Search for luxury fashion...',
                          hintStyle: GoogleFonts.plusJakartaSans(
                            color: const Color(0xFF78767D).withValues(alpha: 0.6), // outline/60
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32), // space-y-8 spacing

              // Category Pills (Horizontal Scroll)
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  children: AppData.categories.asMap().entries.map((e) {
                    return Padding(
                      padding: EdgeInsets.only(right: e.key == AppData.categories.length - 1 ? 0 : 12.0),
                      child: _buildPill(e.value, e.key == 0),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 32),

              // Hero Editorial Banner
              Container(
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16), // rounded-2xl
                  image: const DecorationImage(
                    image: NetworkImage(AppData.homeHeroBannerImage),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        const Color(0xFF00000B).withValues(alpha: 0.6), // primary/60
                        Colors.transparent,
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(32), // p-8
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SUMMER\nCOLLECTION',
                        style: GoogleFonts.beVietnamPro(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 24, // text-2xl
                            fontWeight: FontWeight.w800, // font-extrabold
                            height: 1.0,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.plusJakartaSans(
                            textStyle: TextStyle(
                              color: Colors.white.withValues(alpha: 0.9), // opacity-90
                              fontSize: 14, // text-sm
                              fontWeight: FontWeight.w500,
                              letterSpacing: 2.0, // tracking-widest
                            ),
                          ),
                          children: const [
                            TextSpan(text: 'UP TO 40% OFF — '),
                            TextSpan(
                              text: 'Shop Now',
                              style: TextStyle(decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Featured Lookbook (Asymmetry)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image
                  Expanded(
                    flex: 7, // col-span-7
                    child: AspectRatio(
                      aspectRatio: 4 / 5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16), // rounded-2xl
                        child: Image.network(
                          AppData.homeFeaturedLookbookImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16), // pl-4 (approx)
                  // Text
                  Expanded(
                    flex: 5, // col-span-5
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CURATED',
                          style: GoogleFonts.plusJakartaSans(
                            textStyle: const TextStyle(
                              color: Color(0xFFB71D3F), // secondary
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0, // tracking-[0.2em]
                            ),
                          ),
                        ),
                        const SizedBox(height: 8), // mb-2
                        Text(
                          'THE BOLD PIECES',
                          style: GoogleFonts.beVietnamPro(
                            textStyle: const TextStyle(
                              color: Color(0xFF1A1C1C),
                              fontSize: 30, // text-3xl
                              fontWeight: FontWeight.w800, // font-extrabold
                              height: 1.1, // leading-tight
                              letterSpacing: -1.0, // tracking-tighter
                            ),
                          ),
                        ),
                        const SizedBox(height: 16), // mb-4
                        Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xFF00000B), // border-primary
                                width: 2,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.only(bottom: 4), // pb-1
                          child: Text(
                            'EXPLORE LOOKBOOK',
                            style: GoogleFonts.plusJakartaSans(
                              textStyle: const TextStyle(
                                color: Color(0xFF1A1C1C),
                                fontSize: 12, // text-xs
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5, // tracking-widest
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Product Grid Header & List via StreamBuilder
              StreamBuilder<List<Map<String, dynamic>>>(
                stream: FirestoreService().getProductsStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: CircularProgressIndicator(color: Color(0xFF1A1A2E)),
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  
                  final products = snapshot.data ?? [];
                  if (products.isEmpty) {
                    return const Center(child: Text('No products found'));
                  }

                  // We display up to 4 products in this asymmetric layout
                  final p1 = products.isNotEmpty ? products[0] : null;
                  final p2 = products.length > 1 ? products[1] : null;
                  final p3 = products.length > 2 ? products[2] : null;
                  final p4 = products.length > 3 ? products[3] : null;

                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'ESSENTIAL PIECES',
                            style: GoogleFonts.beVietnamPro(
                              textStyle: const TextStyle(
                                fontSize: 18, // text-lg
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ),
                          Text(
                            'Showing ${products.length} items',
                            style: GoogleFonts.plusJakartaSans(
                              textStyle: const TextStyle(
                                fontSize: 12, // text-xs
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF78767D), // text-outline
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24), // mb-6

                      // Product Grid (Asymmetric)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                if (p1 != null) _buildProductCard(
                                  imageUrl: p1['imageUrl'] ?? '',
                                  tag: p1['subtitle'] ?? '',
                                  title: p1['title'] ?? '',
                                  price: p1['price'] ?? '',
                                  hasFavorite: true,
                                ),
                                if (p2 != null) Transform.translate(
                                  offset: const Offset(0, -32),
                                  child: _buildProductCard(
                                    imageUrl: p2['imageUrl'] ?? '',
                                    tag: p2['subtitle'] ?? '',
                                    title: p2['title'] ?? '',
                                    price: p2['price'] ?? '',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16), // gap-4 
                          Expanded(
                            child: Column(
                              children: [
                                if (p3 != null) Padding(
                                  padding: const EdgeInsets.only(top: 32),
                                  child: _buildProductCard(
                                    imageUrl: p3['imageUrl'] ?? '',
                                    tag: p3['subtitle'] ?? '',
                                    title: p3['title'] ?? '',
                                    price: p3['price'] ?? '',
                                    badge: p3['badge'],
                                  ),
                                ),
                                if (p4 != null) _buildProductCard(
                                  imageUrl: p4['imageUrl'] ?? '',
                                  tag: p4['subtitle'] ?? '',
                                  title: p4['title'] ?? '',
                                  price: p4['price'] ?? '',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildPill(String text, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8), // px-6 py-2.5
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF1A1A2E) : Colors.white, // primary-container vs surface-container-lowest
        borderRadius: BorderRadius.circular(24), // rounded-full
        border: isActive ? null : Border.all(color: const Color(0xFFC8C5CD).withValues(alpha: 0.4)), // outline-variant/40
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: const Color(0xFF1A1C1C).withValues(alpha: 0.04), // editorial-shadow
                  blurRadius: 64,
                  offset: const Offset(0, 32),
                  spreadRadius: -12,
                )
              ]
            : null,
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: GoogleFonts.plusJakartaSans(
          textStyle: TextStyle(
            color: isActive ? Colors.white : const Color(0xFF47464C), // on-primary vs on-surface-variant
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard({
    required String imageUrl,
    required String tag,
    required String title,
    required String price,
    bool hasFavorite = false,
    String? badge,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Container
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1A1C1C).withValues(alpha: 0.04), // editorial-shadow
                  blurRadius: 64,
                  offset: const Offset(0, 32),
                  spreadRadius: -12,
                )
              ],
            ),
            margin: const EdgeInsets.only(bottom: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 3 / 4,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(imageUrl, fit: BoxFit.cover),
                    if (hasFavorite)
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.8),
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                              child: const Icon(Icons.favorite_border, size: 16),
                            ),
                          ),
                        ),
                      ),
                    if (badge != null)
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFDDB4), // tertiary-fixed
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Text(
                            badge,
                            style: GoogleFonts.plusJakartaSans(
                              textStyle: const TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                                color: Color(0xFF291800), // on-tertiary-fixed
                              ),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
          // Category
          Text(
            tag,
            style: GoogleFonts.plusJakartaSans(
              textStyle: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600, // font-semibold
                letterSpacing: 1.5, // tracking-widest
                color: Color(0xFFC8C5CD), // outline-variant
              ),
            ),
          ),
          const SizedBox(height: 4),
          // Title
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1C1C), // on-surface
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Price
          Text(
            price,
            style: GoogleFonts.beVietnamPro(
              textStyle: const TextStyle(
                fontSize: 18, // text-lg
                fontWeight: FontWeight.bold,
                color: Color(0xFFB71D3F), // secondary
              ),
            ),
          ),
        ],
      ),
    );
  }


}

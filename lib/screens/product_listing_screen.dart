import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitflick/screens/product_detail_screen.dart';
import 'package:fitflick/widgets/bottom_nav_bar.dart';
import 'package:fitflick/data/app_data.dart';

class ProductListingScreen extends StatelessWidget {
  const ProductListingScreen({super.key});

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
              backgroundColor: const Color(0xFFF9F9F9).withValues(alpha: 0.8),
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.menu, color: Color(0xFF1A1A2E)), // on-primary-fixed
                onPressed: () => Navigator.of(context).pop(), // allow going back
              ),
              title: Text(
                'FITFLICK',
                style: GoogleFonts.beVietnamPro(
                  textStyle: const TextStyle(
                    fontSize: 20, // text-xl
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                    color: Color(0xFF1A1A2E), // on-primary-fixed
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search, color: Color(0xFF1A1A2E)),
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
          padding: const EdgeInsets.only(top: 80, bottom: 128, left: 24, right: 24), // pt-20 px-6
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Category Filter & Sort Cluster
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Latest Arrivals',
                    style: GoogleFonts.beVietnamPro(
                      textStyle: const TextStyle(
                        fontSize: 24, // text-2xl
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5, // tracking-tight
                        color: Color(0xFF1A1A2E), // on-primary-fixed
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.tune, size: 16, color: Color(0xFF47464C)), // on-surface-variant text-sm
                      const SizedBox(width: 4),
                      Text(
                        'FILTER',
                        style: GoogleFonts.plusJakartaSans(
                          textStyle: const TextStyle(
                            fontSize: 12, // text-xs
                            fontWeight: FontWeight.w600, // font-semibold
                            letterSpacing: 2.0, // tracking-widest
                            color: Color(0xFF47464C),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16), // mb-4 spacing

              // Horizontal scroll pills
              SizedBox(
                height: 36, // py-2.5 ~ 36
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  children: AppData.filterCategories.asMap().entries.map((e) {
                    return Padding(
                      padding: EdgeInsets.only(right: e.key == AppData.filterCategories.length - 1 ? 0 : 12.0),
                      child: _buildPill(e.value, e.key == 0),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 32), // mb-8

              // Product Grid Layout
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const ProductDetailScreen()),
                        );
                      },
                      child: _buildProductCard(
                        imageUrl: AppData.listingProducts[0]['imageUrl'],
                        tag: AppData.listingProducts[0]['subtitle'],
                        tagColor: AppData.listingProducts[0]['color'],
                        rating: AppData.listingProducts[0]['rating'].toString(),
                        title: AppData.listingProducts[0]['title'],
                        price: AppData.listingProducts[0]['price'],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16), // gap-8
                  Expanded(
                    child: _buildProductCard(
                      imageUrl: AppData.listingProducts[1]['imageUrl'],
                      tag: AppData.listingProducts[1]['subtitle'],
                      tagColor: AppData.listingProducts[1]['color'],
                      rating: AppData.listingProducts[1]['rating'].toString(),
                      title: AppData.listingProducts[1]['title'],
                      price: AppData.listingProducts[1]['price'],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildProductCard(
                      imageUrl: AppData.listingProducts[2]['imageUrl'],
                      tag: AppData.listingProducts[2]['subtitle'],
                      tagColor: AppData.listingProducts[2]['color'],
                      rating: AppData.listingProducts[2]['rating'].toString(),
                      title: AppData.listingProducts[2]['title'],
                      price: AppData.listingProducts[2]['price'],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildProductCard(
                      imageUrl: AppData.listingProducts[3]['imageUrl'],
                      tag: AppData.listingProducts[3]['subtitle'],
                      tagColor: AppData.listingProducts[3]['color'],
                      rating: AppData.listingProducts[3]['rating'].toString(),
                      title: AppData.listingProducts[3]['title'],
                      price: AppData.listingProducts[3]['price'],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Product Card 4: Asymmetric Editorial Look (col-span-2)
              _buildEditorialCard(),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 96.0), // fixed bottom-24
        child: SizedBox(
          width: 56, // w-14
          height: 56, // h-14
          child: Stack(
            fit: StackFit.expand,
            children: [
              FloatingActionButton(
                backgroundColor: const Color(0xFF00000B), // primary
                foregroundColor: Colors.white,
                elevation: 12, // shadow-2xl
                shape: const CircleBorder(),
                onPressed: () {
                  Navigator.of(context).pushNamed('/cart');
                },
                child: const Icon(Icons.shopping_cart),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 20, // w-5
                  height: 20, // h-5
                  decoration: BoxDecoration(
                    color: const Color(0xFFB71D3F), // secondary
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFF9F9F9), width: 2), // border-surface border-2
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '2',
                    style: GoogleFonts.plusJakartaSans(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 1),
    );
  }

  Widget _buildPill(String text, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8), // px-6 py-2.5
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF1A1A2E) : Colors.white, // primary-container vs surface-container-lowest
        borderRadius: BorderRadius.circular(24),
        border: isActive ? null : Border.all(color: const Color(0xFFC8C5CD).withValues(alpha: 0.2)), // outline-variant/20
      ),
      alignment: Alignment.center,
      child: Text(
        text.toUpperCase(),
        style: GoogleFonts.plusJakartaSans(
          textStyle: TextStyle(
            color: isActive ? Colors.white : const Color(0xFF45455B), // on-secondary vs on-primary-fixed-variant
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0, // tracking-widest
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard({
    required String imageUrl,
    required String tag,
    required Color tagColor,
    required String rating,
    required String title,
    required String price,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // surface-container-lowest
        borderRadius: BorderRadius.circular(16), // rounded-lg / 16px
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1A1C1C).withValues(alpha: 0.04), // shadow
            blurRadius: 32,
            offset: const Offset(0, -4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image block
          AspectRatio(
            aspectRatio: 3 / 4,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    color: const Color(0xFFF3F3F3), // surface-container-low
                    child: Image.network(imageUrl, fit: BoxFit.cover),
                  ),
                  Positioned(
                    top: 16, // top-4
                    right: 16,
                    child: Container(
                      width: 40, // p-2
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.8), // surface-container-lowest/80
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12), // backdrop-blur-md
                          child: const Icon(Icons.favorite_border, color: Color(0xFF00000B), size: 20), // text-primary
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Details block
          Padding(
            padding: const EdgeInsets.all(24.0), // p-6
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tag.toUpperCase(),
                      style: GoogleFonts.plusJakartaSans(
                        textStyle: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0, // tracking-[0.2em]
                          color: tagColor,
                        ),
                      ),
                    ),
                    Text(
                      '★ $rating',
                      style: GoogleFonts.plusJakartaSans(
                        textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFB955), // tertiary-fixed-variant
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8), // mb-2
                Text(
                  title,
                  style: GoogleFonts.beVietnamPro(
                    textStyle: const TextStyle(
                      fontSize: 18, // text-lg
                      fontWeight: FontWeight.bold,
                      height: 1.1, // leading-tight
                      color: Color(0xFF1A1A2E), // on-primary-fixed
                    ),
                  ),
                ),
                const SizedBox(height: 16), // mb-4
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: GoogleFonts.beVietnamPro(
                        textStyle: const TextStyle(
                          fontSize: 24, // text-2xl
                          fontWeight: FontWeight.w800, // font-extrabold
                          letterSpacing: -0.5, // tracking-tight
                          color: Color(0xFFB71D3F), // secondary
                        ),
                      ),
                    ),
                    Container(
                      width: 44, // p-3 (~44)
                      height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xFF00000B), // primary
                        borderRadius: BorderRadius.circular(6), // rounded-md
                      ),
                      child: const Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 20),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditorialCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3), // surface-container-low
        borderRadius: BorderRadius.circular(16), // rounded-lg
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image
          AspectRatio(
            aspectRatio: 4 / 5,
            child: Image.network(
              AppData.listingEditorialImage,
              fit: BoxFit.cover,
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(32.0), // p-8
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CURATED COLLECTION',
                  style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3.0, // tracking-[0.3em]
                      color: Color(0xFF83829B), // on-primary-container
                    ),
                  ),
                ),
                const SizedBox(height: 16), // mb-4
                Text(
                  'The Winter\nArchive Series',
                  style: GoogleFonts.beVietnamPro(
                    textStyle: const TextStyle(
                      fontSize: 30, // text-3xl
                      fontWeight: FontWeight.w800, // font-extrabold
                      height: 1.0, // leading-none
                      color: Color(0xFF1A1A2E), // on-primary-fixed
                    ),
                  ),
                ),
                const SizedBox(height: 24), // mb-6 
                Text(
                  'Explore the juxtaposition of heavy textures and sharp architectural tailoring designed for the modern urban landscape.',
                  style: GoogleFonts.plusJakartaSans(
                    textStyle: TextStyle(
                      fontSize: 14, // text-sm
                      height: 1.6, // leading-relaxed
                      color: const Color(0xFF47464C).withValues(alpha: 0.8), // on-surface-variant opacity-80
                    ),
                  ),
                ),
                const SizedBox(height: 32), // mb-8
                Row(
                  children: [
                    Text(
                      'VIEW EDITORIAL',
                      style: GoogleFonts.plusJakartaSans(
                        textStyle: const TextStyle(
                          fontSize: 12, // text-xs
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0, // tracking-widest
                          color: Color(0xFF1A1A2E), // on-primary-fixed
                        ),
                      ),
                    ),
                    const SizedBox(width: 16), // gap-4 
                    Container(
                      width: 48, // w-12
                      height: 1, // h-[1px]
                      color: const Color(0xFF00000B), // bg-primary
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

}

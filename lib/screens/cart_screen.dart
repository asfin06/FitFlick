import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitflick/screens/checkout_screen.dart';
import 'package:fitflick/widgets/bottom_nav_bar.dart';
import 'package:fitflick/services/firestore_service.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9), // surface color
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64), // py-4 roughly
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12), // backdrop-blur-md
            child: AppBar(
              backgroundColor: const Color(0xFFF9F9F9).withValues(alpha: 0.8), // F9F9F9/80
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A2E)),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                'CART',
                style: GoogleFonts.beVietnamPro(
                  textStyle: const TextStyle(
                    fontSize: 18, // text-lg
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5, // tracking-tight
                    color: Color(0xFF1A1A2E),
                  ),
                ),
              ),
              actions: const [
                SizedBox(width: 48), // Spacer for centering (matches leading width)
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 96, bottom: 120, left: 16, right: 16), // pt-24 pb-40 px-4
        child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: FirestoreService().getCartStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: Padding(padding: EdgeInsets.all(48.0), child: CircularProgressIndicator(color: Color(0xFF1A1A2E))));
            }
            
            final cartItems = snapshot.data ?? [];
            if (cartItems.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 48),
                  child: Text(
                    'Your cart is empty',
                    style: GoogleFonts.plusJakartaSans(
                      textStyle: const TextStyle(
                        color: Color(0xFF47464C),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              );
            }

            double subtotal = 0;
            for (var item in cartItems) {
              subtotal += (item['price'] as num).toDouble() * (item['quantity'] as num).toInt();
            }
            double tax = subtotal * 0.08;
            double total = subtotal + tax;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Cart Items List
                Column(
                  children: cartItems.asMap().entries.map((e) {
                    final item = e.value;
                    return Padding(
                      padding: EdgeInsets.only(bottom: e.key == cartItems.length - 1 ? 0 : 16.0),
                      child: _buildCartItem(
                        context: context,
                        id: item['id'],
                        imageUrl: item['imageUrl'] ?? '',
                        title: item['title'] ?? '',
                        subtitle: item['subtitle'] ?? '',
                        price: '\$${(item['price'] as num).toDouble().toStringAsFixed(2)}',
                        quantity: (item['quantity'] as num).toInt(),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 32), // mt-8

                // Order Summary Section
                Container(
                  padding: const EdgeInsets.all(24), // p-6
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F3F3), // surface-container-low
                    borderRadius: BorderRadius.circular(24), // rounded-xl (use 24px per Tailwind logic)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'ORDER SUMMARY',
                        style: GoogleFonts.beVietnamPro(
                          textStyle: const TextStyle(
                            fontSize: 12, // text-xs
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0, // tracking-widest
                            color: Color(0xFF00000B), // primary
                          ),
                        ),
                      ),
                      const SizedBox(height: 16), // space-y-4
                      _buildSummaryRow('Subtotal', '\$${subtotal.toStringAsFixed(2)}', isBold: false),
                      const SizedBox(height: 12), // space-y-3
                      _buildSummaryRow('Shipping', 'Complimentary', isBold: false),
                      const SizedBox(height: 12),
                      _buildSummaryRow('Estimated Tax', '\$${tax.toStringAsFixed(2)}', isBold: false),
                      const SizedBox(height: 12),
                      // Divider
                      Container(
                        height: 1, // h-px
                        color: const Color(0xFFC8C5CD).withValues(alpha: 0.3), // outline-variant/30
                        margin: const EdgeInsets.symmetric(vertical: 8), // my-2
                      ),
                      // Total
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: GoogleFonts.beVietnamPro(
                              textStyle: const TextStyle(
                                fontSize: 18, // text-lg
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00000B), // primary
                              ),
                            ),
                          ),
                          Text(
                            '\$${total.toStringAsFixed(2)}',
                            style: GoogleFonts.beVietnamPro(
                              textStyle: const TextStyle(
                                fontSize: 20, // text-xl
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00000B),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // CHECKOUT action button
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                color: Colors.white.withValues(alpha: 0.9),
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const CheckoutScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A1A2E),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'CHECKOUT',
                          style: GoogleFonts.beVietnamPro(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.chevron_right, size: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const AppBottomNavBar(currentIndex: 2),
        ],
      ),
    );
  }

  Widget _buildCartItem({
    required BuildContext context,
    required String id,
    required String imageUrl,
    required String title,
    required String subtitle,
    required String price,
    required int quantity,
  }) {
    return Container(
      padding: const EdgeInsets.all(12), // p-3
      decoration: BoxDecoration(
        color: Colors.white, // surface-container-lowest
        borderRadius: BorderRadius.circular(16), // rounded-lg
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04), // shadow-[0_4px_20px_rgba(0,0,0,0.04)]
            blurRadius: 20,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Container(
            width: 96, // w-24
            decoration: BoxDecoration(
              color: const Color(0xFFF3F3F3), // surface-container-low
              borderRadius: BorderRadius.circular(6), // rounded-md
            ),
            clipBehavior: Clip.antiAlias,
            child: AspectRatio(
              aspectRatio: 3 / 4,
              child: Image.network(imageUrl, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 16), // gap-4

          // Info
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4), // py-1
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // Top Row: Title + Delete
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: GoogleFonts.beVietnamPro(
                                textStyle: const TextStyle(
                                  fontSize: 14, // text-sm
                                  fontWeight: FontWeight.w600, // font-semibold
                                  color: Color(0xFF1A1C1C), // on-surface
                                ),
                              ),
                            ),
                            const SizedBox(height: 4), // mt-1
                            Text(
                              subtitle,
                              style: GoogleFonts.plusJakartaSans(
                                textStyle: const TextStyle(
                                  fontSize: 12, // text-xs
                                  color: Color(0xFF47464C), // on-surface-variant
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(Icons.delete_outline, color: Color(0xFF78767D), size: 20), // outline
                        onPressed: () {
                          FirestoreService().removeFromCart(id);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 32), // space to bottom
                  
                  // Bottom Row: Price + Counter
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                        style: GoogleFonts.beVietnamPro(
                          textStyle: const TextStyle(
                            fontSize: 18, // text-lg
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFC536D), // secondary-container
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), // px-2 py-1
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F3F3), // surface-container-low
                          borderRadius: BorderRadius.circular(24), // rounded-full
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                FirestoreService().updateCartQuantity(id, quantity - 1);
                              },
                              child: Container(
                                width: 24, // w-6
                                height: 24, // h-6
                                decoration: const BoxDecoration(shape: BoxShape.circle),
                                alignment: Alignment.center,
                                child: const Icon(Icons.remove, size: 12),
                              ),
                            ),
                            const SizedBox(width: 12), // gap-3 approx
                            Text(
                              quantity.toString(),
                              style: GoogleFonts.plusJakartaSans(
                                textStyle: const TextStyle(
                                  fontSize: 14, // text-sm
                                  fontWeight: FontWeight.w600, // font-semibold
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            GestureDetector(
                              onTap: () {
                                FirestoreService().updateCartQuantity(id, quantity + 1);
                              },
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: const BoxDecoration(shape: BoxShape.circle),
                                alignment: Alignment.center,
                                child: const Icon(Icons.add, size: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            textStyle: TextStyle(
              fontSize: 14, // text-sm
              color: isBold ? const Color(0xFF1A1C1C) : const Color(0xFF47464C), // on-surface vs on-surface-variant
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.plusJakartaSans(
            textStyle: TextStyle(
              fontSize: 14, // text-sm
              color: const Color(0xFF1A1C1C), // on-surface
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500, // medium
            ),
          ),
        ),
      ],
    );
  }
}

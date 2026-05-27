import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitflick/widgets/bottom_nav_bar.dart';
import 'package:fitflick/services/firestore_service.dart';
class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

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
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12), // backdrop-blur-md
            child: AppBar(
              backgroundColor: const Color(0xFFF8FAFC).withValues(alpha: 0.8), // slate-50/80
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)), // slate-900
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                'ORDER HISTORY',
                style: GoogleFonts.beVietnamPro(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5, // tracking-tight
                    color: Color(0xFF0F172A), // slate-900
                  ),
                ),
              ),
              actions: const [
                SizedBox(width: 48), // spacer for centering
              ],
            ),
          ),
        ),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: FirestoreService().getOrdersStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF1A1A2E)));
          }
          final orders = snapshot.data ?? [];
          if (orders.isEmpty) {
            return Center(
              child: Text(
                'No orders found',
                style: GoogleFonts.plusJakartaSans(
                  textStyle: const TextStyle(
                    color: Color(0xFF47464C),
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.only(top: 96, bottom: 104, left: 24, right: 24), // pt-24 pb-32 px-6
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: orders.asMap().entries.map((e) {
                return Padding(
                  padding: EdgeInsets.only(bottom: e.key == orders.length - 1 ? 0 : 24.0),
                  child: _buildOrderCard(
                    orderNumber: e.value['orderNumber'] ?? 'Unknown',
                    date: e.value['date'] ?? '',
                    status: e.value['status'] ?? 'Unknown',
                    itemCount: e.value['itemCount'] ?? 0,
                    price: e.value['price'] ?? '\$0.00',
                    images: List<String>.from(e.value['images'] ?? []),
                    extraItemCount: e.value['extraItemCount'],
                    isFaded: e.value['isFaded'] ?? false,
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 3),
    );
  }

  Widget _buildOrderCard({
    required String orderNumber,
    required String date,
    required String status,
    required int itemCount,
    required String price,
    required List<String> images,
    int? extraItemCount,
    bool isFaded = false,
  }) {
    Color statusBgColor;
    Color statusTextColor;

    if (status == 'Delivered') {
      statusBgColor = const Color(0xFFF0FDF4); // green-50
      statusTextColor = const Color(0xFF16A34A); // green-600
    } else { // In Transit
      statusBgColor = const Color(0xFF1A1A2E); // primary-container
      statusTextColor = const Color(0xFFE2E0FC); // on-primary-fixed
    }

    return Opacity(
      opacity: isFaded ? 0.7 : 1.0,
      child: Container(
        padding: const EdgeInsets.all(20), // p-5
        decoration: BoxDecoration(
          color: Colors.white, // surface-container-lowest
          borderRadius: BorderRadius.circular(12), // rounded-xl
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04), // shadow-[0_4px_24px_rgba...]
              blurRadius: 24,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Section (Order #, Date, Status)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orderNumber,
                      style: GoogleFonts.plusJakartaSans(
                        textStyle: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0, // tracking-widest
                          color: Color(0xFF47464C), // on-surface-variant
                        ),
                      ),
                    ),
                    const SizedBox(height: 4), // space-y-1
                    Text(
                      date,
                      style: GoogleFonts.plusJakartaSans(
                        textStyle: const TextStyle(
                          fontSize: 14, // text-sm
                          fontWeight: FontWeight.w500, // font-medium
                          color: Color(0xFF1A1C1C), // on-surface
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), // px-2 py-1
                  decoration: BoxDecoration(
                    color: statusBgColor,
                    borderRadius: BorderRadius.circular(4), // rounded
                  ),
                  child: Text(
                    status.toUpperCase(),
                    style: GoogleFonts.plusJakartaSans(
                      textStyle: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800, // font-extrabold
                        letterSpacing: 2.0, // tracking-widest
                        color: statusTextColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16), // space-y-4
            
            // Image Section
            Row(
              children: [
                for (var img in images) ...[
                  Container(
                    width: 64, // w-16
                    height: 80, // h-20
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F3F3), // surface-container-low
                      borderRadius: BorderRadius.circular(8), // rounded-lg
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(img, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 12), // gap-3
                ],
                if (extraItemCount != null && extraItemCount > 0)
                  Container(
                    width: 64, // w-16
                    height: 80, // h-20
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F3F3), // surface-container-low
                      borderRadius: BorderRadius.circular(8), // rounded-lg
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '+$extraItemCount',
                      style: GoogleFonts.plusJakartaSans(
                        textStyle: const TextStyle(
                          fontSize: 12, // text-xs
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF47464C), // on-surface-variant
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16), // space-y-4

            // Bottom Section (Item Count, Price)
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xFFE8E8E8)), // border-surface-container-high
                ),
              ),
              padding: const EdgeInsets.only(top: 8), // pt-2
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$itemCount ${itemCount == 1 ? 'Item' : 'Items'}',
                    style: GoogleFonts.plusJakartaSans(
                      textStyle: const TextStyle(
                        fontSize: 12, // text-xs
                        color: Color(0xFF47464C), // on-surface-variant
                      ),
                    ),
                  ),
                  Text(
                    price,
                    style: GoogleFonts.beVietnamPro(
                      textStyle: const TextStyle(
                        fontSize: 20, // text-xl
                        fontWeight: FontWeight.w800, // font-extrabold
                        color: Color(0xFFB71D3F), // secondary
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


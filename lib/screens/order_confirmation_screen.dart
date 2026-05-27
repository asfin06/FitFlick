import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitflick/screens/home_screen.dart';
import 'package:fitflick/data/app_data.dart';

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9), // surface
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64), // h-16 approx
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12), // backdrop-blur-xl
            child: AppBar(
              backgroundColor: const Color(0xFFF9F9F9).withValues(alpha: 0.8), // #F9F9F9/80
              elevation: 0,
              centerTitle: true,
              leading: Center(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent, // hover:bg-surface-container-low handled by InkWell normally, but we keep simple
                    ),
                    child: const Icon(Icons.close, color: Color(0xFF1A1A2E)),
                  ),
                ),
              ),
              title: Text(
                'CONFIRMATION',
                style: GoogleFonts.beVietnamPro(
                  textStyle: const TextStyle(
                    fontSize: 18, // text-lg
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3.6, // tracking-[0.2em] (approx 20% of 18)
                    color: Color(0xFF1A1A2E), // text-[#1A1A2E]
                  ),
                ),
              ),
              actions: const [
                SizedBox(width: 48), // spacer for centering match leading width
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 96, bottom: 48, left: 24, right: 24), // pt-24 pb-12 px-6
        child: Column(
          children: [
            // Success State Section
            Column(
              children: [
                Container(
                  width: 96, // w-24
                  height: 96, // h-24
                  margin: const EdgeInsets.only(bottom: 32), // mb-8
                  decoration: BoxDecoration(
                    color: Colors.white, // surface-container-lowest
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04), // shadow-[0_32px_64px_-15px...]
                        blurRadius: 64,
                        offset: const Offset(0, 32),
                        spreadRadius: -15,
                      )
                    ],
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.check_circle,
                    color: Color(0xFF4CAF50), // text-[#4CAF50]
                    size: 48, // text-[48px]
                  ),
                ),
                Text(
                  'THANK YOU FOR YOUR ORDER',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.beVietnamPro(
                    textStyle: const TextStyle(
                      fontSize: 24, // text-[24px]
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1.0, // tracking-tighter
                      height: 1.2, // leading-tight
                      color: Color(0xFF1A1A2E), // on-primary-fixed
                    ),
                  ),
                ),
                const SizedBox(height: 16), // mb-4 equiv
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.plusJakartaSans(
                      textStyle: const TextStyle(
                        fontSize: 16, // text-md
                        color: Color(0xFF47464C), // on-surface-variant
                      ),
                    ),
                    children: [
                      const TextSpan(text: 'Your order '),
                      TextSpan(
                        text: AppData.orderConfirmationDetails['orderNumber'] as String,
                        style: GoogleFonts.plusJakartaSans(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1C1C), // on-surface
                          ),
                        ),
                      ),
                      const TextSpan(text: ' has been placed successfully.'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48), // mb-12 equiv

            // Order Detail Card
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Decorative Accent Background
                Positioned(
                  top: -16, // -top-4
                  right: -16, // -right-4
                  child: Container(
                    width: 128, // w-32
                    height: 128, // h-32
                    decoration: BoxDecoration(
                      color: const Color(0xFFFC536D).withValues(alpha: 0.1), // secondary-container/10
                      shape: BoxShape.circle,
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40), // blur-3xl
                      child: Container(color: Colors.transparent),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(32), // p-8
                  decoration: BoxDecoration(
                    color: Colors.white, // surface-container-lowest
                    borderRadius: BorderRadius.circular(12), // rounded-xl
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1A1C1C).withValues(alpha: 0.04), // shadow-[0_32px_32px_-12px...]
                        blurRadius: 32,
                        offset: const Offset(0, 32),
                        spreadRadius: -12,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ORDER SUMMARY',
                                style: GoogleFonts.plusJakartaSans(
                                  textStyle: const TextStyle(
                                    fontSize: 14, // text-sm
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2.0, // tracking-widest
                                    color: Color(0xFF45455B), // on-primary-fixed-variant
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4), // mb-1
                              Text(
                                '${AppData.orderConfirmationDetails['itemsCount']} items purchased',
                                style: GoogleFonts.plusJakartaSans(
                                  textStyle: const TextStyle(
                                    fontSize: 14, // text-sm
                                    color: Color(0xFF47464C), // on-surface-variant
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), // px-3 py-1
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3F3F3), // surface-container-low
                              borderRadius: BorderRadius.circular(24), // rounded-full
                            ),
                            child: Text(
                              (AppData.orderConfirmationDetails['status'] as String).toUpperCase(),
                              style: GoogleFonts.plusJakartaSans(
                                textStyle: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0, // tracking-widest
                                  color: Color(0xFF45455B), // on-primary-fixed-variant
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32), // mb-8 -> space-y-6 roughly adds up

                      // Delivery Estimation
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 40, // w-10
                            height: 40, // h-10
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A1A2E).withValues(alpha: 0.05), // primary-container/5
                              borderRadius: BorderRadius.circular(8), // rounded-lg
                            ),
                            alignment: Alignment.center,
                            child: const Icon(Icons.local_shipping, color: Color(0xFF1A1A2E), size: 20),
                          ),
                          const SizedBox(width: 16), // gap-4
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ESTIMATED DELIVERY',
                                style: GoogleFonts.plusJakartaSans(
                                  textStyle: const TextStyle(
                                    fontSize: 12, // text-xs
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -0.5, // tracking-tighter
                                    color: Color(0xFF45455B), // on-primary-fixed-variant
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4), // mb-1
                              Text(
                                AppData.orderConfirmationDetails['estimatedDelivery'] as String,
                                style: GoogleFonts.plusJakartaSans(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w600, // font-semibold
                                    color: Color(0xFF1A1C1C), // on-surface
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 24), // space-y-6

                      // Shipping Address
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 40, // w-10
                            height: 40, // h-10
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A1A2E).withValues(alpha: 0.05), // primary-container/5
                              borderRadius: BorderRadius.circular(8), // rounded-lg
                            ),
                            alignment: Alignment.center,
                            child: const Icon(Icons.location_on, color: Color(0xFF1A1A2E), size: 20),
                          ),
                          const SizedBox(width: 16), // gap-4
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'SHIPPING TO',
                                style: GoogleFonts.plusJakartaSans(
                                  textStyle: const TextStyle(
                                    fontSize: 12, // text-xs
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -0.5, // tracking-tighter
                                    color: Color(0xFF45455B), // on-primary-fixed-variant
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4), // mb-1
                              Text(
                                AppData.orderConfirmationDetails['shippingAddress'] as String,
                                style: GoogleFonts.plusJakartaSans(
                                  textStyle: const TextStyle(
                                    fontSize: 14, // text-sm
                                    height: 1.6, // leading-relaxed
                                    color: Color(0xFF1A1C1C), // on-surface
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // Divider
                      Container(
                        height: 1, // h-[1px]
                        width: double.infinity,
                        color: const Color(0xFFF3F3F3), // surface-container-low
                      ),
                      const SizedBox(height: 32),

                      // Abstract Visual Placeholder
                      Row(
                        children: [
                          ...((AppData.orderConfirmationDetails['receiptImages'] as List<String>).take(2).map((imgUrl) {
                            return Expanded(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF3F3F3),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  margin: const EdgeInsets.only(right: 8),
                                  child: Image.network(
                                    imgUrl,
                                    fit: BoxFit.cover,
                                    color: Colors.white.withValues(alpha: 0.2), // opacity-80 approx
                                    colorBlendMode: BlendMode.lighten,
                                  ),
                                ),
                              ),
                            );
                          })),
                          if ((AppData.orderConfirmationDetails['receiptImages'] as List<String>).length > 2)
                            Expanded(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF3F3F3),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '+${(AppData.orderConfirmationDetails['receiptImages'] as List<String>).length - 2}',
                                    style: GoogleFonts.plusJakartaSans(
                                      textStyle: const TextStyle(
                                        fontSize: 12, // text-xs
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF47464C), // on-surface-variant
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Order Total Overlay
            Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 48, left: 8, right: 8), // mt-8 mb-12 px-2
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TOTAL PAID',
                        style: GoogleFonts.plusJakartaSans(
                          textStyle: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0, // tracking-[0.2em] approx
                            color: Color(0xFF47464C), // on-surface-variant
                          ),
                        ),
                      ),
                      const SizedBox(height: 4), // mb-1
                      Text(
                        AppData.orderConfirmationDetails['totalPaid'] as String,
                        style: GoogleFonts.beVietnamPro(
                          textStyle: const TextStyle(
                            fontSize: 30, // text-3xl
                            fontWeight: FontWeight.w800, // font-extrabold
                            letterSpacing: -1.0, // tracking-tighter
                            color: Color(0xFF1A1A2E), // on-primary-fixed
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'VIEW RECEIPT',
                    style: GoogleFonts.plusJakartaSans(
                      textStyle: const TextStyle(
                        fontSize: 12, // text-xs
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0, // tracking-widest
                        color: Color(0xFF1A1A2E), // on-primary-fixed
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Actions
            Column(
              children: [
                SizedBox(
                  height: 52, // h-[52px]
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                        (route) => false, // pop all the way back to home
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A1A2E), // primary-container
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // rounded-xl
                      ),
                      elevation: 8,
                      shadowColor: const Color(0xFF1A1A2E).withValues(alpha: 0.3), // shadow-[0_12px_24px_-8px_rgba(26,26,46,0.3)]
                    ),
                    child: Text(
                      'CONTINUE SHOPPING',
                      style: GoogleFonts.plusJakartaSans(
                        textStyle: const TextStyle(
                          fontSize: 14, // text-sm
                          fontWeight: FontWeight.w600, // font-semibold
                          letterSpacing: 1.4, // tracking-[0.1em]
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16), // space-y-4
                Text(
                  'A CONFIRMATION EMAIL HAS BEEN SENT TO YOUR INBOX.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                      fontSize: 11, // text-[11px]
                      fontWeight: FontWeight.w500, // font-medium
                      letterSpacing: 0.5, // tracking-[0.05em]
                      color: Color(0xFF47464C), // on-surface-variant
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48), // Spacer before footer
            
            // Support Section (Editorial Context)
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xFFF3F3F3)), // border-surface-container-low
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 48), // py-12
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.help_outline, color: Color(0xFF47464C), size: 20), // on-surface-variant
                      const SizedBox(width: 16), // gap-4
                      Text(
                        'NEED HELP WITH YOUR ORDER?',
                        style: GoogleFonts.plusJakartaSans(
                          textStyle: const TextStyle(
                            fontSize: 12, // text-xs
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0, // tracking-widest
                            color: Color(0xFF1A1C1C), // on-surface
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24), // gap-6 equiv
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Contact Support',
                        style: GoogleFonts.plusJakartaSans(
                          textStyle: const TextStyle(
                            fontSize: 12, // text-xs
                            color: Color(0xFF47464C), // on-surface-variant
                          ),
                        ),
                      ),
                      const SizedBox(width: 32), // gap-8
                      Text(
                        'Returns Policy',
                        style: GoogleFonts.plusJakartaSans(
                          textStyle: const TextStyle(
                            fontSize: 12, // text-xs
                            color: Color(0xFF47464C), // on-surface-variant
                          ),
                        ),
                      ),
                    ],
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

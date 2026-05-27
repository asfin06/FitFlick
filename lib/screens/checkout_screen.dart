import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitflick/screens/order_confirmation_screen.dart';
import 'package:fitflick/widgets/bottom_nav_bar.dart';
import 'package:fitflick/data/app_data.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _selectedShipping = 'standard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9), // surface color
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56), // h-[56px] approx
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12), // backdrop-blur-xl
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC).withValues(alpha: 0.8), // slate-50/80
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFFE2E8F0).withValues(alpha: 0.2), // slate-200/20
                    Colors.transparent,
                  ],
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: SizedBox(
                  height: 56,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)), // slate-900
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Text(
                        'CHECKOUT',
                        style: GoogleFonts.beVietnamPro(
                          textStyle: const TextStyle(
                            fontSize: 18, // text-lg
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      const SizedBox(width: 48), // spacer for centering
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 96, bottom: 128, left: 24, right: 24), // pt-24 pb-40 px-6
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Shipping Address Section
            Text(
              'Shipping Address',
              style: GoogleFonts.beVietnamPro(
                textStyle: const TextStyle(
                  fontSize: 20, // text-xl
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5, // tracking-tight
                  color: Color(0xFF00000B), // primary
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(24), // p-6
              decoration: BoxDecoration(
                color: Colors.white, // surface-container-lowest
                borderRadius: BorderRadius.circular(12), // rounded-xl
                border: Border.all(color: const Color(0xFFC8C5CD).withValues(alpha: 0.1)), // outline-variant/10
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1A1C1C).withValues(alpha: 0.04), // shadow-[0_32px_32px_...]
                    blurRadius: 32,
                    offset: const Offset(0, 32),
                  )
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppData.checkoutShippingAddress['name']!,
                        style: GoogleFonts.beVietnamPro(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1C1C), // on-surface
                          ),
                        ),
                      ),
                      const SizedBox(height: 4), // space-y-1 roughly
                      Text(
                        AppData.checkoutShippingAddress['address']!,
                        style: GoogleFonts.plusJakartaSans(
                          textStyle: const TextStyle(
                            fontSize: 14, // text-sm
                            height: 1.6, // leading-relaxed
                            color: Color(0xFF47464C), // on-surface-variant
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppData.checkoutShippingAddress['phone']!,
                        style: GoogleFonts.plusJakartaSans(
                          textStyle: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF47464C),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Change',
                    style: GoogleFonts.plusJakartaSans(
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500, // font-medium
                        color: Color(0xFF78767D), // outline
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Shipping Method Section
            Text(
              'Shipping Method',
              style: GoogleFonts.beVietnamPro(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                  color: Color(0xFF00000B),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildShippingOption(
                    id: AppData.checkoutShippingMethods[0]['id'],
                    icon: AppData.checkoutShippingMethods[0]['icon'],
                    topRightText: AppData.checkoutShippingMethods[0]['topRightText'],
                    title: AppData.checkoutShippingMethods[0]['title'],
                    subtitle: AppData.checkoutShippingMethods[0]['subtitle'],
                  ),
                ),
                const SizedBox(width: 16), // gap-4
                Expanded(
                  child: _buildShippingOption(
                    id: AppData.checkoutShippingMethods[1]['id'],
                    icon: AppData.checkoutShippingMethods[1]['icon'],
                    topRightText: AppData.checkoutShippingMethods[1]['topRightText'],
                    title: AppData.checkoutShippingMethods[1]['title'],
                    subtitle: AppData.checkoutShippingMethods[1]['subtitle'],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Payment Method Section
            Text(
              'Payment Method',
              style: GoogleFonts.beVietnamPro(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                  color: Color(0xFF00000B),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFC8C5CD).withValues(alpha: 0.1)),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1A1C1C).withValues(alpha: 0.04),
                    blurRadius: 32,
                    offset: const Offset(0, 32),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48, // w-12
                        height: 32, // h-8
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1A2E), // primary-container
                          borderRadius: BorderRadius.circular(4), // rounded
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          AppData.checkoutPaymentMethod['brand']!,
                          style: const TextStyle(
                            fontFamily: 'Arial', // Fallback for basic sans
                            fontSize: 10,
                            fontWeight: FontWeight.w900, // font-black
                            fontStyle: FontStyle.italic,
                            letterSpacing: -1.0, // tracking-tighter
                            color: Color(0xFFE2E0FC), // primary-fixed
                          ),
                        ),
                      ),
                      const SizedBox(width: 16), // gap-4
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppData.checkoutPaymentMethod['title']!,
                            style: GoogleFonts.beVietnamPro(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1A1C1C),
                              ),
                            ),
                          ),
                          const SizedBox(height: 2), // space-y-0.5
                          Text(
                            AppData.checkoutPaymentMethod['subtitle']!,
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
                  Text(
                    'Change',
                    style: GoogleFonts.plusJakartaSans(
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF78767D),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Order Summary Section
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0x33C8C5CD)), // border-outline-variant/20
                ),
              ),
              padding: const EdgeInsets.only(top: 16), // pt-4
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Order Summary',
                    style: GoogleFonts.beVietnamPro(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                        color: Color(0xFF00000B),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F3F3), // surface-container-low
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        _buildSummaryRow('Subtotal', AppData.checkoutSummary['subtotal']!),
                        const SizedBox(height: 12),
                        _buildSummaryRow('Shipping', AppData.checkoutSummary['shipping']!),
                        const SizedBox(height: 12),
                        _buildSummaryRow('Estimated Tax', AppData.checkoutSummary['tax']!),
                        const SizedBox(height: 12),
                        Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Color(0x4DC8C5CD)), // border-outline-variant/30
                            ),
                          ),
                          padding: const EdgeInsets.only(top: 12), // pt-3
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total',
                                style: GoogleFonts.beVietnamPro(
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF00000B),
                                  ),
                                ),
                              ),
                              Text(
                                AppData.checkoutSummary['total']!,
                                style: GoogleFonts.beVietnamPro(
                                  textStyle: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -0.5,
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
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Editorial Lookbook Teaser
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      AppData.checkoutLookbookImage,
                      fit: BoxFit.cover,
                      color: Colors.black.withValues(alpha: 0.25),
                      colorBlendMode: BlendMode.darken, // brightness-75 equivalent somewhat
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.6),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'NEW SEASON',
                            style: GoogleFonts.plusJakartaSans(
                              textStyle: TextStyle(
                                fontSize: 10,
                                letterSpacing: 3.0, // tracking-[0.3em]
                                color: Colors.white.withValues(alpha: 0.7),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'FitFlick',
                            style: GoogleFonts.beVietnamPro(
                              textStyle: const TextStyle(
                                fontSize: 24, // text-2xl
                                fontWeight: FontWeight.w900, // font-black
                                height: 1.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // PLACE ORDER action button
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                color: Colors.white.withValues(alpha: 0.9),
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                child: SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const OrderConfirmationScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A1A2E),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'PLACE ORDER',
                      style: GoogleFonts.plusJakartaSans(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
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

  Widget _buildShippingOption({
    required String id,
    required IconData icon,
    required String topRightText,
    required String title,
    required String subtitle,
  }) {
    bool isSelected = _selectedShipping == id;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedShipping = id;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(20), // p-5
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF00000B) : const Color(0xFFC8C5CD).withValues(alpha: 0.2),
            width: isSelected ? 1 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 12,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  icon,
                  color: isSelected ? const Color(0xFF00000B) : const Color(0xFF78767D), // primary vs on-surface-variant
                  size: 24,
                ),
                if (id == 'standard')
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), // px-2 py-1
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFDDB4), // tertiary-fixed
                      borderRadius: BorderRadius.circular(4), // rounded
                    ),
                    child: Text(
                      topRightText,
                      style: GoogleFonts.plusJakartaSans(
                        textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0, // tracking-widest
                          color: Color(0xFFB57700), // on-tertiary-container
                        ),
                      ),
                    ),
                  )
                else
                  Text(
                    topRightText,
                    style: GoogleFonts.plusJakartaSans(
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1C1C), // on-surface
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
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            textStyle: const TextStyle(
              fontSize: 14, // text-sm
              color: Color(0xFF47464C), // on-surface-variant
            ),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.plusJakartaSans(
            textStyle: const TextStyle(
              fontSize: 14, // text-sm
              fontWeight: FontWeight.w500, // font-medium
              color: Color(0xFF1A1C1C), // on-surface
            ),
          ),
        ),
      ],
    );
  }
}

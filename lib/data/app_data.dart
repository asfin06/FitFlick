import 'package:flutter/material.dart';

class AppData {
  // Splash Screen
  static const String appName = 'FITFLICK';
  static const String appTagline = 'CURATED ELEGANCE';
  static const String appFooter = '© 2024 EDITORIAL PORTFOLIO';

  // Home Screen
  static const List<String> categories = ['All', 'New In', 'Clothing', 'Shoes', 'Accessories'];
  static const String homeHeroBannerImage = 'https://lh3.googleusercontent.com/aida-public/AB6AXuBz83qQ-2FPPQzeXAlAefcSETToTPjnCeQ5865MWoDgXQI3PX1PTe-cwxCLXS-E0YpU27UtQvOX3_OZ4NK_ulQ4CbZirING1XZjMydoHYg_7pKx3xP1YIH6jWQeB4xR28rFaioNC4ne0_UwHCXjkv251dqTYjsN_NNEw3v6vi9qKoH4kKvyHgYlNrl2rGKKiYWVKd6Wo5UeAB3xSGitcLnS_uTFaB5ryjCONH91PB5062rHB3FfTW65UkkYI-ibHG7PI4NBEyOsfMkJ';
  static const String homeFeaturedLookbookImage = 'https://lh3.googleusercontent.com/aida-public/AB6AXuDQYh5F92Fhq5w0OhzSBrCDBqVUOu7vboHA8pe38REwSRkCwSLTbd6fkNlObQyeDjmkms_wKWNg6s1_zGUJw7lTcJvTgHZho2U-Gblr7X_ExozzDxeuIi17qtjIf5i9QHIiF__QwgB-bUYK_B4Bybdbdk1rHoR5VM7nJEdPyzEGTYbPiHJ_I1Sj3mSXTrJnS_l8idqgoxlIeDB7etY5njENEBxh9S5lHXGM3kSN97m8wA6qsWCq02bjwvihtuyj87vH3vTylw3c3GD_';
  
  static const List<Map<String, dynamic>> featuredProducts = [
    {
      'title': 'Tailored Wool Overcoat',
      'price': '\$1,250',
      'subtitle': 'ARCHIVE SIGNATURE',
      'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBA3sgZ4OeAAGlVibDBQ7X0lfMMqw2-QcA9WcqLfnPaAYDLnIm8nNd6-G089tMgIDs-IVSv_kT6B95VgfScMt-u6pcmKgj5d1jUubXQ2LDqwjnDcQLB6xEak1o8ZhW-ySQlx2z6qEGJITgzpCcpEp-EvA8ZO5ZYYItnLVjR1jl0vt1i8R9S4vVX2ooiFscmB81U7qBCBp1K-5FfbtSgS0QEHea4VVNfGYaV23Rda3eGBE4M0b-C0Cm-BrogsrQiuGe66-haPKIB23yd',
    },
    {
      'title': 'Petite Leather Tote',
      'price': '\$2,400',
      'subtitle': 'ARCHIVE ESSENTIALS',
      'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuDsRV0Ney9ZkbnKNVpVbCbZ_YvAR_oIfA-ttuWUFpqqK1YkZVyTMXv91_SRUUshDkodJeu4ipgLCVL3j18WM17gDhu_QcMKezEVNR-cCsCcFZpc59Nke39JXkhdYBOikiifJ99b_bppwZZHRvhuvHbqFrgfiYlo_VkYtkSnkg3NS3uWoFzv2T7C3sHuesMusHD0GBWfNLhNEjLIUtOYLsAggt77MR3QxGA0mOFTl54r4TQcPBPI7gpSx4EFztrYPMEaDCoDeWKW6MDd',
    },
    {
      'title': 'Metallic Stiletto Pumps',
      'price': '\$890',
      'subtitle': 'LUXURY COLLECTION',
      'badge': 'LIMITED',
      'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBdXSyY8o5wYsrVql9iU93hOUOvLjaBWowF7_PoudHpEVLf_5WlOrC6-MRd_e_B9TnYydlM6KeTfB3GMx-UcJUz1WUOFwIvnXQtx3Z86jHd8LT1caLTGPWNgcc0f_QNszMQlToUDnpipQzNJkeGZNdR55tDgsfecFvoojF-w_ZeoUGmi62DC9Ql537IlZYuRY4p6ek4tWys9OWAPXt50LlXe9UDXHzUz8-pWHDz1O7LIy0BbKIxLwTAJJb4PvCdOMz-8ROOJ1Gz8-3E',
    },
    {
      'title': 'Floral Silk Midi Dress',
      'price': '\$560',
      'subtitle': 'NEW SEASON',
      'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuC_bRVm2DgT3bfCYLHCGDSlaRwG9vr3pookV3_NMMO6p0RsaRZPr4F5opup1lk3JeGsmL_ywcel_merZJlikvgqY16kuuZJV0K9e9iahFiHVDzYcfTgaBU1hK1Wzx6Pq5PUZtQLKgjBsMxL6loUNCAPmjdsSekTaIuKboVmw-Tz7QBPs-TSLIRF8-rk3NPAFDsX7T-YAmjHP1zToAECygd1pvAGH9z47CgJTStrEOnuzHp4_lT5Vmn32mRd5kHNVZ2hCNwd5SZhmKsg',
    },
  ];

  // Product Listing Screen
  static const List<String> filterCategories = ['All Items', 'Outerwear', 'Footwear', 'Accessories', 'Knitwear'];
  
  static const List<Map<String, dynamic>> listingProducts = [
    {
      'title': 'Sculpted Wool Overcoat',
      'price': '\$1,250',
      'subtitle': 'New Season',
      'color': Color(0xFFB71D3F),
      'rating': 4.9,
      'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuB4vDtes6Qk83YZBy2lQRO4lurNVtGQUs8aOKSifdkpxxnKQHfHqhNPMnDKCcQX7eXMmVnQw1x-DVZVKLg9owcloG6e0iFlxGiKlnDX1QNJsvmkKHVhK8QqdQ2gwhX13iYqA1o6gY6IlGzVgzROfSwdq2YYmiTxEzLarD68ns91AYGsC7rSkBQrJEGoJxmIeaonJ7FRuW8o6X_aNT3o_tYORWr0Gs6Kv4qaILgRRvmLTsEDGojpu-j9wZwW7uARpa73wO2v_Lm-M5Ku',
    },
    {
      'title': 'Obsidian Leather Boots',
      'price': '\$890',
      'subtitle': 'Essentials',
      'color': Color(0xFF83829B),
      'rating': 4.8,
      'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBu3UXPHLik5Rv7_qww73UniYdL4dqt1jdgRucr5bNbPFr_iGKCwDXGPqB2nMJX6B5WqcKxGqJEmu3bsT8iqli1n0_Vwkd9Y3sUZV6xNy11OvmTU3Mzo-L5JE83HGzFFw5AOL3HnWHrHLoic-rcRkg4zcpVSiobdUyjJsJTEJle1BoDNmgRLpHOCJCxZxEHD5_AHT85VDyA4wQhfPSAEy-Lz8ibAKNauvtir00xAs-ehc7CjWPgYSRSwSYCajN4KIhWJFrTFgN5boxA',
    },
    {
      'title': 'Pure Cashmere Rollneck',
      'price': '\$540',
      'subtitle': 'Limited Edition',
      'color': Color(0xFFFFB955),
      'rating': 5.0,
      'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAewzBWbDhpPxCsV6Z_uURiYgCma3qMgDR1TtjbYeHTfKkm0FlnlgMPunBzOBDmKJiaZu10XG1mE_a8croczgw--k20BwA1pQuplifYM5SZNGMYQ6m_iocf6AiyMVbZ1a1TlAYgBdgXvu-Jk6ZNvgWgMkkyjeYSWxsBSABRKPkp4P3VLqTs7HJedCEPYkBPV57_mW-HfwL660of9CpFy_kOhy8fT2cXWPiHehNMx1_dXNwm8qqkL7g94wpvCvdCSuxDFAUt6iY7OPWA',
    },
    {
      'title': 'Poplin Archive Shirt',
      'price': '\$320',
      'subtitle': 'Legacy Piece',
      'color': Color(0xFF83829B),
      'rating': 4.7,
      'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBbCca4FbB_Y0f89HddGKP4y5ZzThd7u2q2WFHw7e7N8Y2fZ6g-3ay996JK2sXumTGz8bllB68caPGmXZDDIf7eSlqILW-aHM2XwT4UKnI6fyCF0QIW3vbUs6dAqsxWe2fuOlJUuzrRIJXHGZHZOt9SoAsqtne3GyyjDxFsST46jei04ZlpRQQzsLBwdqpNPmSi-cmBGQjEFEf1tZsE8E7l1PQYs3wAX3fFTMIxHO52594-FFAAAvrhHarqFaf5K-Bp4j9yE_RmzuoX',
    },
  ];

  static const String listingEditorialImage = 'https://lh3.googleusercontent.com/aida-public/AB6AXuBb3vlwPQWxfOvJnAowftbrpWbdAggc5BY_Ib1AoXSRUZjqyeKARo3SnDPrNF3RDns4897W3w8JsHez-d0ingyIiu9zL8WFl-kPEDibL6HP9AR8hn1ILdu8PMiPW5zfksOKKrqsApWWEV21Y7dDq7PVlasYWW6Vxy-QDqee1kS6Ky1meTq0UQlZB8mgNprmfio4jlZxKMdl0bsaSgO9464lOHx-i76xfbXNOnPeTYPVRUHjOIlV-58pgm3pGLUH6QFO_YbCN8yfk6bA';

  // Product Detail Screen
  static const Map<String, dynamic> productDetail = {
    'title': 'Sculpted Wool Overcoat',
    'price': '€1,850.00',
    'description': 'Masterfully crafted from double-faced Italian wool, this sculpted overcoat redefines modern tailoring. Featuring architectural shoulders, a concealed placket, and a silk-blend lining, it offers a refined silhouette that balances avant-garde design with timeless luxury.',
    'sizes': ['IT 48', 'IT 50', 'IT 52', 'IT 54'],
    'material': '100% Virgin Wool',
    'origin': 'Made in Milan',
    'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAdwHNGSgzW7aCEjF0hbQOtelXBHS8Oqlqxcm2z7Zcpqj8DdL7xqtEKJpLk_nhhqdSSqU95WMwzsMvKQAB6KFxqJm2eibbEBKuL34zI-ZohPQ9XlOUHZJdCrx7SWGgk60bZbiZda_Dqq3QAC4MN-Z-MB92_EeNSuCBT6SGpTyEGzhIlrbmHLCUCLil4GV7qDE-iEhAIIyOg7RoPY0pdmrNM_TE5tjgU9P5_aP71OZQtg0Izi85OmMWkz-1e-b3D27n2uNDAbh_tBygH',
  };

  // Cart Screen
  static const List<Map<String, dynamic>> cartItems = [
    {
      'title': 'Sculptural Wool Overcoat',
      'subtitle': 'Midnight Blue / Size M',
      'price': '\$890.00',
      'quantity': 1,
      'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuCR9uUpTcaFio7gRaWomlKotcczI6IAexkNALzbMcLKyvRztujkF0AQiWLNoOw6Xvwhgft3oxBkJI8BcK6dOxK9gLzVqdlGbUIdMD_YhHj_OHaj_vLB06mQCSs7tuQiGqcA8ivlpxpD52IkAht-uoJZf2wCRHUAjCb8yzqlsS-mKdpskF_fObX4939wQPCH4SDXkeSOrhekSoo5J7BL1bTzVxnEdoyNZhH-dpB6ZY_7BZrPg4aMbUyCkgIhMFMNUX7diBIw8KZz-jum',
    },
    {
      'title': 'Lustrous Silk Blouse',
      'subtitle': 'Pearl White / Size S',
      'price': '\$320.00',
      'quantity': 1,
      'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuDKecdbGwnBoUAILJsIkwKROFGJ2hTYIRIRs1vJoRS-GLBJD-kzuUd49vuo-feXFQ-7SDpWLKTEOp5qDU21GDLbMUYYRsLlb6B1s2MUMW4UDJimJo9KF9L-dd_NSQKC2xbfyHyxlwgcnIVja3sXWjEF76YkRZ6-MugPf2nuChYB8jpHVkzUpnuVZxRTU9ceWdaBoBA-9zKvaKq9oDCLWy9R1C_bUDQ54gD2j8hcoqGB1kNpUpFNz5cmLzbdBYY7dVaXlGFnqyXL6yJ-',
    },
    {
      'title': 'Signature Leather Tote',
      'subtitle': 'Noir Black / One Size',
      'price': '\$1,250.00',
      'quantity': 1,
      'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuDrxNMriPAK0pgIs1Vo48OqljQBZEPjhj5C2cxpTbxJ7RaVC6D0Jho4qeiDSwN9rKjgLiiy11UFEv5IFibpkIfUNuxjnzwKGawoKry5esO3ygVz9n4GiI6q82OTb81nShOQrYA4MrM4tSV1BPcmlowLdm57OCAHBWaQNvie642UFFIZ0qgY4IDmXIismgfSsSFpYtYtHL3SJYOvfUPzwvJIj69CUe5TJ_Aw2ZiiqdUQrCn-sOLmV0PuZt49IDXZqifGvZcQKBoLBYm_',
    },
  ];

  static const Map<String, String> cartSummary = {
    'subtotal': '\$2,460.00',
    'shipping': 'Complimentary',
    'tax': '\$196.80',
    'total': '\$2,656.80',
  };

  // Checkout Screen
  static const Map<String, dynamic> checkoutShippingAddress = {
    'name': 'Julianne Moore',
    'address': '721 Fifth Avenue\nNew York, NY 10022',
    'phone': '+1 (212) 555-0198',
  };

  static const List<Map<String, dynamic>> checkoutShippingMethods = [
    {
      'id': 'standard',
      'title': 'Standard Delivery',
      'subtitle': '3-5 Business Days',
      'cost': 'FREE',
    },
    {
      'id': 'express',
      'title': 'Express Delivery',
      'subtitle': '1-2 Business Days',
      'cost': '\$15.00',
    },
  ];

  static const Map<String, String> checkoutPaymentMethod = {
    'cardType': 'VISA',
    'cardNumber': 'Visa ending in 4242',
    'expiry': 'Expires 12/26',
  };

  static const Map<String, String> checkoutSummary = {
    'subtotal': '\$840.00',
    'shipping': 'Free',
    'tax': '\$67.20',
    'total': '\$907.20',
  };

  static const String checkoutLookbookImage = 'https://lh3.googleusercontent.com/aida-public/AB6AXuBWT2fPepYEwGttDarOjQjjsKCMHr_RE0Lc7yngBe1zbGgSmtqQ2LrfrzNQmIqmilmexMUfO8tjtWNFcCw_BwYKKRjbHbdMXO9iMtMIEBA85tqqV6hMxG3Hoe2qP7rKj4h6dj_4nHRLNq8G51J4H_ld4XFqQiwnAeRaFmuf-lD_3gi40yoh6kbiXWo1Iful6JBNtmAsNpkOQ-qLCUStYpJDh_dAFMYpr3XwxbG8-U6s-RPc3xQnj1cmbZiOdALw7vmIX4dwzs_RLMgH';

  // Order Confirmation Screen
  static const Map<String, dynamic> orderConfirmationDetails = {
    'orderNumber': '#82347-90',
    'itemsCount': 3,
    'status': 'CONFIRMED',
    'estimatedDelivery': 'Oct 24 - Oct 26',
    'shippingAddress': 'Alexander McQueen\n124 Savile Row, Mayfair\nLondon, W1S 3PR, UK',
    'totalPaid': '£1,240.00',
    'images': [
      'https://lh3.googleusercontent.com/aida-public/AB6AXuB9XBWG92jh1vDOVKMtFTx2GG0PYleSxFjzsPodbLNv-KhQvSuwk5dbuGjmvrv4wEYXbpqBuiW_hvdVVGPYzfrmZnfs_P-UakbFG41TFEtr2b7M4S13TDmkp7nkd982OFZdRnrTCrE_j7c1hOORSq1mH3kHjs240kTjaNizzNPmhSmjtDkxW-WEWXEqK0MRpDrJYrGnePr-aV8_a7O5Yg3RRhv-OE_QSvqw4ezwHaMBjRdOCgqzkzQBjKBYo-Ok_7D9I1opT677EwGM',
      'https://lh3.googleusercontent.com/aida-public/AB6AXuBfapZBVcKlY74W0Xm8rW6b2urBuF0tfGJXCC5OZ9ERZN_x1hwr7NBObB-rTz8Vuxu_6gMglVK5heO4DtaBeizeQybNjGYSu27LFxXZMAqKbAfz-4lfMWOrV43vG3fY0-MN69iEqxnoIUcfYYwKAi3Ndgzkktj1xy5JwAoa8weA7MBImZuKDVSJ_ybfcfAc2cMcH6Mgob0M8fShrVR67ZrU5dnfWtcsfE0rE9EVyb68W34peKjOrQRBd-_R6Frq9QMFOgWctbMEyuGp',
    ],
  };

  // Order History Screen
  static const List<Map<String, dynamic>> orderHistory = [
    {
      'orderNumber': '#ORD-7721',
      'date': 'September 12, 2023',
      'status': 'Delivered',
      'itemCount': 3,
      'price': '\$1,240.00',
      'images': [
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDGryY5PnWLQHUqwoNxSEj2AQuzCyZh0l2dQXjQkand77_Xqix1YOkczKUz8yQWrDhwVoo_GZtFCVo86l_LizOlAS2hInmVKT8bgReOb5_xJd32aoOr9cuErxAOro-hYgwPYn5LRBxPexu4AgQUmUPnuN5amAqIFk1dnSXjI6J-UdtFgr1dQ64E5UT8SbrKtBQOQL7PIoNWuxCJJHNF9K4cAm5EDmUSIDh491X0LcxOPpOgEbfLs7cCkzs7FgIYqB1w02POBZwAcnbB',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAM7hvM3p7c6mRVaNLhEG_zP_dnRrrMS_r3eH4iEFn_MME2tw8w2p03shPG8jd1mfMsTdgMoZt2klS04U7TxzcxAmjfZzUcURI0idQn6VfgYRNMu76eN6wp1sTyrL4-oLDYixK9Rb20cF3auMhff5grNmmyQFDkFXHrKUyyN_bWIyoBVjVWrNSeQKHU2dISVth7dp3QDoQrN1ZcQbYMtJw3UFtH9HoXTFuQEDNslsV0YWJ-8rvUcg72UJ2e4tVpzbuA4MzVeift0g_C',
      ],
      'extraItemCount': 1,
    },
    {
      'orderNumber': '#ORD-8842',
      'date': 'October 02, 2023',
      'status': 'In Transit',
      'itemCount': 2,
      'price': '\$890.00',
      'images': [
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDFb4pnlvmT-j2Gx3h0KtjY0s3aiHzPJWWkrtYKcSuqbzPpzc8rzZB7P7kwdhDx9USMG1zWTYvYoMr0-xHvrTmm-8SZRujFB9NN9U5Lpbi22x7WFqebv0bVCFrhDARq8yxgsQUIljP3vFwlI0dIHBlzqVfS23DWrDMmkDelWbtMfQibBJaTAofnEOD5mnKnRgJ3EzS21tDdMGVDb5EX70ocuyU_PNyiFpPtOkPgQHBZMveseGGw_GlazpOAFQKJtNxFAlygA0_xvcsc',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuC9V0nxJv9gK4pjwlchTseamTe6yyDM-0YcD6jufWpGBkFMIveukLfNJ2mRy9YyUG4eT4wr2NL3fgNVEzSK69VAf6NnOe1kfgn-RRjb8anVUqrSsiL8BhC4OjPehAMl2DWjsfo-aP3cq0AzsV8b-Nmm8k9ioeHHSAyJbzRoxg66HePATUj_-ZeicGCZ3oiApeECmHGt_OUHEqU_RYgaeS0YIYHEUu9upRI71X-LOo3OCfDHnuxZR9vwWgLx5cfSs_OkfaYKgJrVgTIa',
      ],
    },
    {
      'orderNumber': '#ORD-6610',
      'date': 'August 28, 2023',
      'status': 'Delivered',
      'itemCount': 1,
      'price': '\$215.00',
      'images': [
        'https://lh3.googleusercontent.com/aida-public/AB6AXuBAEZhF7MyfGOYRe9US4GJa6Ryy9BnuncFgrH34oicAbAdgOpbVxLLFKBKZ_lDziimN0sjXpfcoGIMjlzHKxMWtxxuIhgdgwLylQOri6Ddrnzuwtr2tMBFMH4SXqCtpWcZS603gbPAieyL819AXHq8NaVXQQxrucNw-dT0ymK6cbNd2_Tw-trmw5yMW52IsJ-txeiMk8TIYUQfOWZtT43VQRqcvziXPr9ArR7cGlXoYiKKERoGFNF1dtXIet0Dj_4RjUQuN8GzTyKyF',
      ],
    },
    {
      'orderNumber': '#ORD-5509',
      'date': 'July 14, 2023',
      'status': 'Delivered',
      'itemCount': 1,
      'price': '\$540.00',
      'images': [
        'https://lh3.googleusercontent.com/aida-public/AB6AXuCl56iqWmdKxKL6_glQC5VONLipYdaDg0PWaVXNWWILgQgAcxstfV5KwLu4Z7ojuhUtgKMZJL6l49NRM3GoK4J-yMkqQFnHiRczjhUoV9mJRucXZ1QYZW4sdzIKA1-QWxNATavbXr1vGwwUg2vhRtJXoUDjL0f5IY3agLmxU26m0OhC9cv_ABFAen8oNwaiQrpZ7dWdGYwa61Ial9KH9_CSYI4KkDYi9IWNz6ggVPiidasxwb4u8SFDjYpMS1jo7RwLDgSzYV0kbMIT',
      ],
      'isFaded': true,
    },
  ];

  // Profile Screen
  static const Map<String, dynamic> userProfile = {
    'name': 'Julianne Moore',
    'email': 'julianne.m@example.com',
    'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBi7IjwMurI3d4ZbnepxEE-3ShQyfC8s3VJOvnGEDcen3omu52oNaMAMRaH8LhErldAVTVUWonU4fiKkf33UnWgvwIVTQ85W_KkHHkYfpkyt2ET1t9OIZiNi8DF0UGGAOKX2f9k4dTMZruWVDKz-2s3bVE-x-T-oHNeRwO_J-s_5-XvkQnXX_6tVwt-Flj5P3scGnoH_bS5Mbp9EtMpSVNunpzg78ZPNHn9OKjgTPvysF3rJ6RzdgpRR2n0Gnlv-4KnNKubDKrs4c47',
    'stats': {
      'orders': '12',
      'wishlist': '48',
      'points': '2.4k',
    },
  };

  // Edit Profile Screen
  static const Map<String, dynamic> editProfile = {
    'name': 'Julianne V. Moore',
    'email': 'julianne.moore@archive.co',
    'phone': '+1 (555) 012-3456',
    'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuCq5jJcWmuq7knYcvCjjAumyH_6kfGGL1FEi8wrCZo1HpYugfCkjPfIRNr02e5PN8CWyAvW-X00SA2jFPlB0xN8HDXmekutdF5JY0yVvwqtFwDcedVJH7-NtR1K3K0BRh1tCqb0WVvWC3n5Vu8azW5fCUNOoygVjAzMVovprX7pm5lvkbu0rXuYYv89gOP1KkvY1KFK5d5rAzucyVzirJDOMCiyI-V9Cqr_bRWRlc7glauL8OIZQxgw8C6M4PiccOzEMOhSfX9fCEtU',
  };

  // Register Screen
  static const String registerHeroImage = 'https://lh3.googleusercontent.com/aida-public/AB6AXuCCR9jxqB8-pvR9_HDLrR2FY5xRbUbfQIhMv96YOk8Q-iEjU7Q6X5GoUXvtyvRxCIRA_AiFIAkvd6QQdKkYOzvmU0-PpD7rzSxMpnVYEDvbKipni8ad8zd1sQXzasxFSDEvlOqXYln9pO-wgc2ffNHWlL2VElWWOyBYGKn0WR6xlgq7IgTi1r0ANRipCh6bs02ab4TUZ-nx1WuNuF7Ivmi-UHxllGHXqWtMc448fRMF3LP6yRF9is0ARdqZiJxW-tPimvdCjzxAwm7O';
}

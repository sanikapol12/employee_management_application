import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ============================================================================
// COLOR PALETTE - VIOLET & SHADES OF VIOLET
// ============================================================================
class VioletTheme {
  static const Color primaryViolet = Color(0xFF6B21A8); // Deep Royal Violet
  static const Color richViolet = Color(0xFF7C3AED); // Electric Amethyst
  static const Color deepViolet = Color(0xFF3B0764); // Midnight Violet
  static const Color darkPlum = Color(0xFF2E1065); // Darkest Violet
  static const Color lightLilac = Color(0xFFC084FC); // Vibrant Lilac
  static const Color softLavender = Color(0xFFDDD6FE); // Soft Lavender
  static const Color paleViolet = Color(0xFFF3E8FF); // Very light violet
  static const Color surfaceViolet = Color(0xFFFAF5FF); // Background tint
  static const Color cardSurface = Colors.white;
  static const Color tulipPink = Color(0xFFF472B6);
  static const Color stemGreen = Color(0xFF10B981);
  static const Color goldAccent = Color(0xFFFBBF24);

  static LinearGradient primaryGradient = const LinearGradient(
    colors: [Color(0xFF3B0764), Color(0xFF6B21A8), Color(0xFF7C3AED)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient bannerGradient = const LinearGradient(
    colors: [Color(0xFF4C1D95), Color(0xFF7C3AED), Color(0xFF9333EA)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static LinearGradient cardAccentGradient = const LinearGradient(
    colors: [Color(0xFFF3E8FF), Color(0xFFFAF5FF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

// ============================================================================
// MODELS
// ============================================================================
class ProductItem {
  final String id;
  final String title;
  final String category; // 'Flowers' or 'Keychains'
  final int startingPrice;
  final String tag;
  final String description;
  final String colorVariant;
  final double rating;
  final int reviewCount;
  final String emoji;
  final List<String> availableColors;

  ProductItem({
    required this.id,
    required this.title,
    required this.category,
    required this.startingPrice,
    required this.tag,
    required this.description,
    required this.colorVariant,
    required this.rating,
    required this.reviewCount,
    required this.emoji,
    required this.availableColors,
  });
}

class ReviewItem {
  final String id;
  final String reviewerName;
  final String timeAgo;
  final int rating;
  final String comment;
  final String verifiedProduct;

  ReviewItem({
    required this.id,
    required this.reviewerName,
    required this.timeAgo,
    required this.rating,
    required this.comment,
    required this.verifiedProduct,
  });
}

// ============================================================================
// SAMPLE DATA
// ============================================================================
final List<ProductItem> sampleProducts = [
  // KEYCHAINS - Starting at 49
  ProductItem(
    id: 'kc-1',
    title: 'Mini Tulip Bell Keychain',
    category: 'Keychains',
    startingPrice: 49,
    tag: 'STARTS AT ₹49',
    description:
        'Cute handcrafted fuzzy pipe cleaner tulip bell charm with silver key loop. Ideal for backpacks, pouches, and keys.',
    colorVariant: 'Lavender & Violet',
    rating: 4.9,
    reviewCount: 38,
    emoji: '🌷',
    availableColors: ['Lavender', 'Deep Violet', 'Baby Pink', 'Sky Blue'],
  ),
  ProductItem(
    id: 'kc-2',
    title: 'Fuzzy Sprout & Leaf Charm',
    category: 'Keychains',
    startingPrice: 49,
    tag: 'POPULAR ₹49',
    description:
        'Aesthetic miniature pipe cleaner sprout bud. Super soft, wire reinforced, durable and delightfully fluffy.',
    colorVariant: 'Mint & Lilac',
    rating: 4.8,
    reviewCount: 22,
    emoji: '🌱',
    availableColors: ['Lilac Green', 'Pastel Sage', 'Violet Sprout'],
  ),
  ProductItem(
    id: 'kc-3',
    title: 'Amethyst Blossom Loop Charm',
    category: 'Keychains',
    startingPrice: 59,
    tag: 'HANDMADE',
    description:
        'Multi-petal violet blossom with center pearl bead and golden lobster clasp for luxury bags.',
    colorVariant: 'Royal Purple',
    rating: 5.0,
    reviewCount: 45,
    emoji: '🌸',
    availableColors: ['Royal Purple', 'Soft Orchid', 'Rose Violet'],
  ),
  ProductItem(
    id: 'kc-4',
    title: 'Fuzzy Bunny & Clover Keychain',
    category: 'Keychains',
    startingPrice: 69,
    tag: 'BESTSELLER',
    description:
        'Adorable sculpted pipe cleaner bunny head paired with lucky clover and lilac ribbon.',
    colorVariant: 'Pastel Lilac',
    rating: 4.9,
    reviewCount: 67,
    emoji: '🐰',
    availableColors: ['Lilac White', 'Violet Pink', 'Vanilla Cream'],
  ),
  ProductItem(
    id: 'kc-5',
    title: 'Violet Heart Knotted Keychain',
    category: 'Keychains',
    startingPrice: 55,
    tag: 'TRENDING',
    description:
        'Puffed double-wire pipe cleaner heart in rich violet tones with silver bell and ring.',
    colorVariant: 'Deep Violet',
    rating: 4.7,
    reviewCount: 19,
    emoji: '💜',
    availableColors: ['Deep Violet', 'Lilac Mist', 'Berry Wine'],
  ),
  ProductItem(
    id: 'kc-6',
    title: 'Cute Sunflower Loop Keychain',
    category: 'Keychains',
    startingPrice: 65,
    tag: 'FAVORITE',
    description:
        'Cheerful fuzzy sunflower with violet leaves for a whimsical pop of sunshine.',
    colorVariant: 'Golden Violet',
    rating: 4.9,
    reviewCount: 31,
    emoji: '🌻',
    availableColors: ['Golden Violet', 'Pastel Sunrise', 'Amethyst Sun'],
  ),

  // FLOWERS - Starting at 149
  ProductItem(
    id: 'fl-1',
    title: 'Everlasting Violet Tulip Stem',
    category: 'Flowers',
    startingPrice: 149,
    tag: 'STARTS AT ₹149',
    description:
        'Our signature handcrafted artificial pipe cleaner tulip stem. Features velvety violet petals, bendable stem, and dual lush leaves.',
    colorVariant: 'Signature Violet',
    rating: 5.0,
    reviewCount: 84,
    emoji: '🌷',
    availableColors: [
      'Signature Violet',
      'Pastel Lilac',
      'Soft Pink',
      'Pure White'
    ],
  ),
  ProductItem(
    id: 'fl-2',
    title: 'Lilac Lily of the Valley Stem',
    category: 'Flowers',
    startingPrice: 169,
    tag: 'NEW ARRIVAL',
    description:
        'Delicate dangling bell florets handcrafted with plush pipe cleaner chenille wire. Never fades or droops.',
    colorVariant: 'Lilac & Emerald',
    rating: 4.8,
    reviewCount: 29,
    emoji: '🪻',
    availableColors: ['Lilac Whisper', 'Lavender Mist', 'Snow Lilac'],
  ),
  ProductItem(
    id: 'fl-3',
    title: 'Royal Amethyst Rose Stem',
    category: 'Flowers',
    startingPrice: 199,
    tag: 'SIGNATURE ITEM',
    description:
        'Lavish multi-layered pipe cleaner rose crafted with 20+ petals in gradient royal violet hues.',
    colorVariant: 'Royal Amethyst',
    rating: 4.9,
    reviewCount: 62,
    emoji: '🌹',
    availableColors: [
      'Royal Amethyst',
      'Deep Velvet Violet',
      'Mauve Lavender'
    ],
  ),
  ProductItem(
    id: 'fl-4',
    title: 'Pastel Daisy Trio Bouquet',
    category: 'Flowers',
    startingPrice: 249,
    tag: 'GIFT SET',
    description:
        'Set of 3 handcrafted pipe cleaner daisies tied with lavender organza ribbon and gift wrapping.',
    colorVariant: 'Violet & Cream',
    rating: 4.9,
    reviewCount: 41,
    emoji: '🌼',
    availableColors: ['Violet Daisies', 'Pastel Rainbow', 'Lilac & Butter'],
  ),
  ProductItem(
    id: 'fl-5',
    title: 'Signature Tulip Garden Pot',
    category: 'Flowers',
    startingPrice: 349,
    tag: 'TABLE DECOR',
    description:
        '3 blooming pipe cleaner tulips planted in a cute pastel mini ceramic/yarn base pot. Ready for gifting.',
    colorVariant: 'Tri-Violet Shades',
    rating: 5.0,
    reviewCount: 53,
    emoji: '🪴',
    availableColors: ['Tri-Violet Blend', 'Lavender Fantasy', 'Blush & Violet'],
  ),
  ProductItem(
    id: 'fl-6',
    title: 'Grand Everlasting Bouquet (7 Stems)',
    category: 'Flowers',
    startingPrice: 599,
    tag: 'LUXURY BUNDLE',
    description:
        'Exquisite luxury bouquet with 4 tulips, 2 daisies, and 1 royal rose wrapped in aesthetic Korean frosted paper.',
    colorVariant: 'Signature Violet Palette',
    rating: 5.0,
    reviewCount: 97,
    emoji: '💐',
    availableColors: [
      'Signature Violet Galaxy',
      'Lilac Romance',
      'Custom Mix'
    ],
  ),
];

// ============================================================================
// CUSTOM TULIP FLOWER ICON WIDGET
// ============================================================================
class TulipFlowerIcon extends StatelessWidget {
  final double size;
  final Color? flowerColor;
  final Color? stemColor;

  const TulipFlowerIcon({
    super.key,
    this.size = 32,
    this.flowerColor,
    this.stemColor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _TulipPainter(
        flowerColor: flowerColor ?? const Color(0xFFF472B6),
        stemColor: stemColor ?? const Color(0xFF34D399),
      ),
    );
  }
}

class _TulipPainter extends CustomPainter {
  final Color flowerColor;
  final Color stemColor;

  _TulipPainter({required this.flowerColor, required this.stemColor});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Stem
    final stemPaint = Paint()
      ..color = stemColor
      ..strokeWidth = w * 0.1
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final stemPath = Path();
    stemPath.moveTo(w * 0.5, h * 0.55);
    stemPath.quadraticBezierTo(w * 0.52, h * 0.75, w * 0.5, h * 0.95);
    canvas.drawPath(stemPath, stemPaint);

    // Leaf
    final leafPaint = Paint()
      ..color = stemColor.withValues(alpha: 0.9)
      ..style = PaintingStyle.fill;

    final leafPath = Path();
    leafPath.moveTo(w * 0.5, h * 0.78);
    leafPath.quadraticBezierTo(w * 0.78, h * 0.68, w * 0.82, h * 0.58);
    leafPath.quadraticBezierTo(w * 0.68, h * 0.76, w * 0.5, h * 0.85);
    leafPath.close();
    canvas.drawPath(leafPath, leafPaint);

    // Left Leaf
    final leftLeafPath = Path();
    leftLeafPath.moveTo(w * 0.5, h * 0.82);
    leftLeafPath.quadraticBezierTo(w * 0.22, h * 0.72, w * 0.18, h * 0.65);
    leftLeafPath.quadraticBezierTo(w * 0.32, h * 0.80, w * 0.5, h * 0.88);
    leftLeafPath.close();
    canvas.drawPath(leftLeafPath, leafPaint);

    // Center Petal (Darker Violet/Pink)
    final centerPetalPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          flowerColor.withValues(alpha: 0.85),
          const Color(0xFF9333EA),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, w, h))
      ..style = PaintingStyle.fill;

    final centerPetal = Path();
    centerPetal.moveTo(w * 0.5, h * 0.1);
    centerPetal.cubicTo(
        w * 0.65, h * 0.2, w * 0.68, h * 0.45, w * 0.5, h * 0.62);
    centerPetal.cubicTo(
        w * 0.32, h * 0.45, w * 0.35, h * 0.2, w * 0.5, h * 0.1);
    centerPetal.close();
    canvas.drawPath(centerPetal, centerPetalPaint);

    // Left Petal
    final sidePetalPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          const Color(0xFFC084FC),
          flowerColor,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, w, h))
      ..style = PaintingStyle.fill;

    final leftPetal = Path();
    leftPetal.moveTo(w * 0.24, h * 0.2);
    leftPetal.cubicTo(
        w * 0.42, h * 0.26, w * 0.48, h * 0.52, w * 0.45, h * 0.62);
    leftPetal.cubicTo(
        w * 0.22, h * 0.58, w * 0.16, h * 0.35, w * 0.24, h * 0.2);
    leftPetal.close();
    canvas.drawPath(leftPetal, sidePetalPaint);

    // Right Petal
    final rightPetal = Path();
    rightPetal.moveTo(w * 0.76, h * 0.2);
    rightPetal.cubicTo(
        w * 0.58, h * 0.26, w * 0.52, h * 0.52, w * 0.55, h * 0.62);
    rightPetal.cubicTo(
        w * 0.78, h * 0.58, w * 0.84, h * 0.35, w * 0.76, h * 0.2);
    rightPetal.close();
    canvas.drawPath(rightPetal, sidePetalPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ============================================================================
// MAIN APP ROOT
// ============================================================================
class YourSignatureApp extends StatelessWidget {
  const YourSignatureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your Signature | Artificial Pipe Cleaner Flowers & Keychains',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: VioletTheme.surfaceViolet,
        colorScheme: ColorScheme.fromSeed(
          seedColor: VioletTheme.primaryViolet,
          primary: VioletTheme.primaryViolet,
          secondary: VioletTheme.richViolet,
          surface: VioletTheme.cardSurface,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
      ),
      home: const YourSignatureHomePage(),
    );
  }
}

// ============================================================================
// HOME PAGE
// ============================================================================
class YourSignatureHomePage extends StatefulWidget {
  const YourSignatureHomePage({super.key});

  @override
  State<YourSignatureHomePage> createState() => _YourSignatureHomePageState();
}

class _YourSignatureHomePageState extends State<YourSignatureHomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _inquiryKey = GlobalKey();
  final GlobalKey _reviewsKey = GlobalKey();
  final GlobalKey _catalogKey = GlobalKey();

  String _selectedCategory = 'All';
  String _searchQuery = '';

  // Inquiry form controllers
  final _inquiryFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _inquiryMessageController = TextEditingController();
  String _selectedInterest = 'Keychains (Starts ₹49)';

  // Review form controllers
  final _reviewFormKey = GlobalKey<FormState>();
  final _reviewerNameController = TextEditingController();
  final _reviewTextController = TextEditingController();
  int _selectedRating = 5;

  // Real-time reviews list
  late List<ReviewItem> _reviews;

  @override
  void initState() {
    super.initState();
    _reviews = [
      ReviewItem(
        id: 'r-1',
        reviewerName: 'Ananya Sharma',
        timeAgo: '2 days ago',
        rating: 5,
        comment:
            'Ordered 5 tulip keychains for ₹49 each as return gifts! The fuzzy pipe cleaner quality is top notch and my friends adored them. Definitely ordering a bouquet next! 🌷💜',
        verifiedProduct: 'Mini Tulip Bell Keychain (₹49)',
      ),
      ReviewItem(
        id: 'r-2',
        reviewerName: 'Priya Deshmukh',
        timeAgo: '4 days ago',
        rating: 5,
        comment:
            'The violet flower stem for ₹149 is beyond gorgeous! The shades of lavender and violet brighten my study desk completely. Stays fresh forever! ✨',
        verifiedProduct: 'Everlasting Violet Tulip Stem (₹149)',
      ),
      ReviewItem(
        id: 'r-3',
        reviewerName: 'Kavita Joshi',
        timeAgo: '1 week ago',
        rating: 5,
        comment:
            'Your Signature delivered the grand 7-stem bouquet on time for my sister’s birthday. The craftsmanship in every single petal is marvelous!',
        verifiedProduct: 'Grand Everlasting Bouquet',
      ),
    ];
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _nameController.dispose();
    _mobileController.dispose();
    _inquiryMessageController.dispose();
    _reviewerNameController.dispose();
    _reviewTextController.dispose();
    super.dispose();
  }

  void _scrollToKey(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _handleInquirySubmit() {
    if (_inquiryFormKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final phone = _mobileController.text.trim();
      final note = _inquiryMessageController.text.trim();
      final product = _selectedInterest;

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: VioletTheme.paleViolet,
                  shape: BoxShape.circle,
                ),
                child: const TulipFlowerIcon(size: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Inquiry Received!',
                  style: GoogleFonts.playfairDisplay(
                    color: VioletTheme.deepViolet,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Thank you, $name! 💜',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: VioletTheme.primaryViolet,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'We have logged your inquiry for "$product". Our artisans will WhatsApp/Call you at +91 $phone shortly with design photos and dispatch details.',
                style: const TextStyle(color: Color(0xFF4B5563), height: 1.4),
              ),
              if (note.isNotEmpty) ...[
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: VioletTheme.surfaceViolet,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: VioletTheme.softLavender),
                  ),
                  child: Text(
                    'Your Note: "$note"',
                    style: const TextStyle(
                        fontStyle: FontStyle.italic, fontSize: 13),
                  ),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Close',
                  style: TextStyle(color: VioletTheme.primaryViolet)),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: VioletTheme.deepViolet,
                    content: Text(
                      'Opening WhatsApp inquiry for $name...',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.chat, color: Colors.white, size: 18),
              label: const Text('Chat on WhatsApp',
                  style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF25D366),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      );

      // Clear form
      _nameController.clear();
      _mobileController.clear();
      _inquiryMessageController.clear();
    }
  }

  void _handleReviewSubmit() {
    if (_reviewFormKey.currentState!.validate()) {
      final name = _reviewerNameController.text.trim();
      final text = _reviewTextController.text.trim();

      setState(() {
        _reviews.insert(
          0,
          ReviewItem(
            id: 'r-${DateTime.now().millisecondsSinceEpoch}',
            reviewerName: name,
            timeAgo: 'Just now',
            rating: _selectedRating,
            comment: text,
            verifiedProduct: 'Verified Customer',
          ),
        );
      });

      _reviewerNameController.clear();
      _reviewTextController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: VioletTheme.richViolet,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: Row(
            children: const [
              Icon(Icons.stars, color: Colors.amber, size: 24),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Thank you for reviewing "Your Signature"! Your review has been published.',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  void _openProductDetail(ProductItem product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _ProductDetailModal(
        product: product,
        onInquire: () {
          Navigator.pop(ctx);
          setState(() {
            _selectedInterest =
                '${product.title} (₹${product.startingPrice})';
          });
          _scrollToKey(_inquiryKey);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = sampleProducts.where((p) {
      final matchCategory =
          _selectedCategory == 'All' || p.category == _selectedCategory;
      final matchSearch = _searchQuery.isEmpty ||
          p.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.description.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchCategory && matchSearch;
    }).toList();

    return Scaffold(
      backgroundColor: VioletTheme.surfaceViolet,
      // Prominent Drawer for mobile screens
      drawer: _buildAppDrawer(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // BIG APPBAR WITH TULIP AND "YOUR SIGNATURE"
          _buildBigSliverAppBar(),

          // MAIN WEBSITE CONTENT
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // AESTHETIC HERO BANNER
                _buildHeroBanner(),

                // SPECIAL HIGHLIGHTS / PRICING BADGES
                _buildPricingHighlights(),

                // PRODUCT CATALOG SECTION
                Container(
                  key: _catalogKey,
                  child: _buildCatalogSection(filteredList),
                ),

                const SizedBox(height: 50),

                // WHY CHOOSE OUR ARTIFICIAL PIPE CLEANERS
                _buildWhyChooseUsSection(),

                const SizedBox(height: 50),

                // INQUIRY SECTION (BOTTOM TEXTFIELDS FOR NAME & MOBILE NO.)
                Container(
                  key: _inquiryKey,
                  child: _buildInquirySection(),
                ),

                const SizedBox(height: 50),

                // REVIEWS SECTION (BOTTOM TEXTFIELD FOR REVIEWS & LIVE REVIEWS LIST)
                Container(
                  key: _reviewsKey,
                  child: _buildReviewSection(),
                ),

                const SizedBox(height: 60),

                // FOOTER
                _buildFooter(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _scrollToKey(_inquiryKey),
        backgroundColor: VioletTheme.richViolet,
        foregroundColor: Colors.white,
        elevation: 6,
        icon: const Icon(Icons.send_rounded),
        label: const Text(
          'Quick Inquiry',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // ==========================================================================
  // 1. BIG APPBAR
  // ==========================================================================
  Widget _buildBigSliverAppBar() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 860;

    return SliverAppBar(
      pinned: true,
      floating: false,
      expandedHeight: isDesktop ? 120.0 : 96.0,
      backgroundColor: VioletTheme.deepViolet,
      elevation: 8,
      shadowColor: VioletTheme.richViolet.withValues(alpha: 0.4),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: VioletTheme.primaryGradient,
            boxShadow: [
              BoxShadow(
                color: VioletTheme.darkPlum.withValues(alpha: 0.5),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 40 : 16,
                vertical: 8,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // TULIP FLOWER ICON BEFORE WEBSITE NAME
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: VioletTheme.softLavender.withValues(alpha: 0.3),
                        width: 1.5,
                      ),
                    ),
                    child: const TulipFlowerIcon(
                      size: 38,
                      flowerColor: Color(0xFFF472B6),
                      stemColor: Color(0xFF34D399),
                    ),
                  ),
                  const SizedBox(width: 14),

                  // WEBSITE NAME: "your signature"
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'your signature',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: isDesktop ? 30 : 22,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.2,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: VioletTheme.deepViolet
                                      .withValues(alpha: 0.8),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: VioletTheme.lightLilac
                                  .withValues(alpha: 0.25),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: VioletTheme.lightLilac
                                    .withValues(alpha: 0.5),
                              ),
                            ),
                            child: Text(
                              'Handmade Crafts',
                              style: TextStyle(
                                fontSize: isDesktop ? 11 : 9,
                                color: VioletTheme.paleViolet,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Artisanal Pipe Cleaner Flowers & Keychains',
                        style: GoogleFonts.poppins(
                          fontSize: isDesktop ? 13 : 11,
                          color: VioletTheme.softLavender,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // DESKTOP NAVIGATION
                  if (isDesktop) ...[
                    _buildNavButton('Home', () {
                      _scrollController.animateTo(0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOut);
                    }),
                    _buildNavButton('Keychains (From ₹49)', () {
                      setState(() => _selectedCategory = 'Keychains');
                      _scrollToKey(_catalogKey);
                    }),
                    _buildNavButton('Flowers (From ₹149)', () {
                      setState(() => _selectedCategory = 'Flowers');
                      _scrollToKey(_catalogKey);
                    }),
                    _buildNavButton('Inquiry', () => _scrollToKey(_inquiryKey)),
                    _buildNavButton('Reviews', () => _scrollToKey(_reviewsKey)),
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: () => _scrollToKey(_inquiryKey),
                      icon: const Icon(Icons.favorite,
                          size: 16, color: Colors.white),
                      label: const Text('Order Now'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: VioletTheme.richViolet,
                        foregroundColor: Colors.white,
                        elevation: 4,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton(String label, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.white.withValues(alpha: 0.95),
          ),
        ),
      ),
    );
  }

  Widget _buildAppDrawer() {
    return Drawer(
      backgroundColor: VioletTheme.deepViolet,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: VioletTheme.primaryGradient,
              ),
              child: Row(
                children: [
                  const TulipFlowerIcon(size: 36),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'your signature',
                        style: GoogleFonts.playfairDisplay(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Pipe Cleaner Arts & Crafts',
                        style: TextStyle(
                            color: VioletTheme.softLavender, fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              leading:
                  const Icon(Icons.home_outlined, color: Colors.white),
              title: const Text('Home',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _scrollController.animateTo(0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOut);
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.vpn_key_outlined, color: Colors.white),
              title: const Text('Keychains (From ₹49)',
                  style: TextStyle(color: Colors.white)),
              trailing: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: VioletTheme.lightLilac.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text('₹49',
                    style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                        fontSize: 12)),
              ),
              onTap: () {
                Navigator.pop(context);
                setState(() => _selectedCategory = 'Keychains');
                _scrollToKey(_catalogKey);
              },
            ),
            ListTile(
              leading: const Icon(Icons.local_florist_outlined,
                  color: Colors.white),
              title: const Text('Flowers (From ₹149)',
                  style: TextStyle(color: Colors.white)),
              trailing: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: VioletTheme.lightLilac.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text('₹149',
                    style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                        fontSize: 12)),
              ),
              onTap: () {
                Navigator.pop(context);
                setState(() => _selectedCategory = 'Flowers');
                _scrollToKey(_catalogKey);
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.question_answer_outlined, color: Colors.white),
              title: const Text('Product Inquiry',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _scrollToKey(_inquiryKey);
              },
            ),
            ListTile(
              leading: const Icon(Icons.star_outline, color: Colors.white),
              title: const Text('Customer Reviews',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _scrollToKey(_reviewsKey);
              },
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _scrollToKey(_inquiryKey);
                },
                icon: const Icon(Icons.chat_bubble_outline,
                    color: Colors.white),
                label: const Text('Inquire on WhatsApp',
                    style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF25D366),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================================
  // 2. HERO BANNER
  // ==========================================================================
  Widget _buildHeroBanner() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 860;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFF3E8FF),
            const Color(0xFFEDE9FE),
            VioletTheme.surfaceViolet,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 20,
        vertical: isDesktop ? 50 : 30,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: isDesktop
              ? Row(
                  children: [
                    Expanded(child: _buildHeroText(isDesktop)),
                    const SizedBox(width: 40),
                    Expanded(child: _buildHeroVisualCard()),
                  ],
                )
              : Column(
                  children: [
                    _buildHeroText(isDesktop),
                    const SizedBox(height: 30),
                    _buildHeroVisualCard(),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildHeroText(bool isDesktop) {
    return Column(
      crossAxisAlignment:
          isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: VioletTheme.softLavender,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: VioletTheme.lightLilac),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              TulipFlowerIcon(size: 18),
              SizedBox(width: 8),
              Text(
                'Everlasting Fuzzy Floral & Keychains',
                style: TextStyle(
                  color: VioletTheme.deepViolet,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'Crafted with Passion,\nBlooms Forever in Violet',
          textAlign: isDesktop ? TextAlign.start : TextAlign.center,
          style: GoogleFonts.playfairDisplay(
            fontSize: isDesktop ? 44 : 30,
            fontWeight: FontWeight.w800,
            color: VioletTheme.deepViolet,
            height: 1.18,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Welcome to "Your Signature" — where soft pipe cleaner chenille wire transforms into whimsical keychains starting at just ₹49 and everlasting hand-sculpted flowers starting at ₹149. Add handcrafted charm to your everyday style!',
          textAlign: isDesktop ? TextAlign.start : TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: isDesktop ? 15 : 13,
            color: const Color(0xFF4B5563),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => _scrollToKey(_catalogKey),
              icon: const Icon(Icons.shopping_bag_outlined,
                  color: Colors.white),
              label: const Text('Explore Creations'),
              style: ElevatedButton.styleFrom(
                backgroundColor: VioletTheme.primaryViolet,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 4,
              ),
            ),
            OutlinedButton.icon(
              onPressed: () => _scrollToKey(_inquiryKey),
              icon: const Icon(Icons.edit_note,
                  color: VioletTheme.primaryViolet),
              label: const Text('Custom Inquiry'),
              style: OutlinedButton.styleFrom(
                foregroundColor: VioletTheme.primaryViolet,
                side: const BorderSide(
                    color: VioletTheme.primaryViolet, width: 1.5),
                padding: const EdgeInsets.symmetric(
                    horizontal: 22, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeroVisualCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: VioletTheme.primaryViolet.withValues(alpha: 0.12),
            blurRadius: 28,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(
          color: VioletTheme.softLavender.withValues(alpha: 0.6),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  TulipFlowerIcon(size: 28),
                  SizedBox(width: 8),
                  Text(
                    'your signature',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: VioletTheme.deepViolet,
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 14),
                    SizedBox(width: 4),
                    Text(
                      '4.9 (250+ reviews)',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF92400E),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Interactive visual showcase of Keychain & Flower
          Row(
            children: [
              Expanded(
                child: _buildShowcaseTile(
                  title: 'Pipe Cleaner Keychain',
                  price: 'From ₹49',
                  badge: 'Affordable Charm',
                  badgeColor: const Color(0xFF10B981),
                  emoji: '🔑',
                  bgColor: const Color(0xFFF3E8FF),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _buildShowcaseTile(
                  title: 'Pipe Cleaner Flower',
                  price: 'From ₹149',
                  badge: 'Signature Tulip',
                  badgeColor: VioletTheme.primaryViolet,
                  emoji: '🌷',
                  bgColor: const Color(0xFFEDE9FE),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: VioletTheme.surfaceViolet,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: const [
                Icon(Icons.auto_awesome,
                    color: VioletTheme.richViolet, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '100% Bendable • Velvety Soft • Never Withers • Customized on request',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: VioletTheme.deepViolet,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShowcaseTile({
    required String title,
    required String price,
    required String badge,
    required Color badgeColor,
    required String emoji,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: VioletTheme.softLavender,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 32)),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  badge,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: VioletTheme.deepViolet,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            price,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: VioletTheme.primaryViolet,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================================
  // 3. PRICING HIGHLIGHTS BANNER
  // ==========================================================================
  Widget _buildPricingHighlights() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
              gradient: VioletTheme.bannerGradient,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: VioletTheme.primaryViolet.withValues(alpha: 0.3),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Wrap(
              alignment: WrapAlignment.spaceAround,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 20,
              runSpacing: 16,
              children: [
                _buildHighlightStat(
                  icon: Icons.vpn_key,
                  value: '₹49',
                  label: 'Keychains Starting Price',
                  subtext: 'Bells, bunnies & floral loops',
                ),
                Container(
                  width: 1.5,
                  height: 45,
                  color: Colors.white.withValues(alpha: 0.3),
                ),
                _buildHighlightStat(
                  icon: Icons.local_florist,
                  value: '₹149',
                  label: 'Flowers Starting Price',
                  subtext: 'Signature tulips, roses & daisies',
                ),
                Container(
                  width: 1.5,
                  height: 45,
                  color: Colors.white.withValues(alpha: 0.3),
                ),
                _buildHighlightStat(
                  icon: Icons.palette_outlined,
                  value: '10+ Shades',
                  label: 'Violet & Pastel Palette',
                  subtext: 'Custom color requests accepted',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHighlightStat({
    required IconData icon,
    required String value,
    required String label,
    required String subtext,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'Best Value',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              label,
              style: const TextStyle(
                color: VioletTheme.paleViolet,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
            Text(
              subtext,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 11,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ==========================================================================
  // 4. PRODUCT CATALOG WITH TABS & FILTERS
  // ==========================================================================
  Widget _buildCatalogSection(List<ProductItem> products) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const TulipFlowerIcon(size: 32),
              const SizedBox(height: 10),
              Text(
                'Handmade With Love & Pipe Cleaners',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: VioletTheme.deepViolet,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Browse our adorable keychains (from ₹49) and everlasting flowers (from ₹149)',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),

              // Filter Tabs & Search Bar
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildCategoryFilterChip('All', '✨ All Creations'),
                  _buildCategoryFilterChip(
                      'Keychains', '🔑 Keychains (Starts ₹49)'),
                  _buildCategoryFilterChip(
                      'Flowers', '💐 Flowers (Starts ₹149)'),
                ],
              ),
              const SizedBox(height: 16),

              // Search field
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: TextField(
                  onChanged: (val) => setState(() => _searchQuery = val),
                  decoration: InputDecoration(
                    hintText: 'Search tulip, rose, bunny keychain...',
                    prefixIcon: const Icon(Icons.search,
                        color: VioletTheme.primaryViolet),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                          color: VioletTheme.softLavender),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                          color: VioletTheme.primaryViolet, width: 2),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Responsive Product Grid
              if (products.isEmpty)
                Container(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      const Icon(Icons.search_off,
                          size: 48, color: VioletTheme.lightLilac),
                      const SizedBox(height: 12),
                      const Text(
                        'No creations match your search!',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: VioletTheme.deepViolet),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () => setState(() {
                          _searchQuery = '';
                          _selectedCategory = 'All';
                        }),
                        child: const Text('Reset Filters'),
                      ),
                    ],
                  ),
                )
              else
                LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = 3;
                    if (constraints.maxWidth < 640) {
                      crossAxisCount = 1;
                    } else if (constraints.maxWidth < 980) {
                      crossAxisCount = 2;
                    }

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 24,
                        mainAxisExtent: 440,
                      ),
                      itemBuilder: (context, index) {
                        return _buildProductCard(products[index]);
                      },
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryFilterChip(String key, String label) {
    final isSelected = _selectedCategory == key;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (val) {
        if (val) setState(() => _selectedCategory = key);
      },
      selectedColor: VioletTheme.primaryViolet,
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : VioletTheme.deepViolet,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
        fontSize: 13,
      ),
      side: BorderSide(
        color: isSelected
            ? VioletTheme.primaryViolet
            : VioletTheme.softLavender,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    );
  }

  Widget _buildProductCard(ProductItem product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: VioletTheme.softLavender.withValues(alpha: 0.8),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: VioletTheme.primaryViolet.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Visual Showcase Area
          Stack(
            children: [
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(22)),
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFFF5F3FF),
                      VioletTheme.paleViolet,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        product.emoji,
                        style: const TextStyle(fontSize: 64),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product.colorVariant,
                        style: const TextStyle(
                          fontSize: 12,
                          color: VioletTheme.primaryViolet,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: product.startingPrice <= 69
                        ? const Color(0xFF059669)
                        : VioletTheme.richViolet,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    product.tag,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        product.rating.toString(),
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Content Area
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.category.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 11,
                        color: VioletTheme.richViolet,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                      ),
                    ),
                    Text(
                      '${product.reviewCount} reviews',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  product.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: VioletTheme.deepViolet,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  product.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 14),
                // Price Tag & Order Action
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Starting Price',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          '₹${product.startingPrice}',
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: VioletTheme.primaryViolet,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () => _openProductDetail(product),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: VioletTheme.primaryViolet,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                      ),
                      child: const Row(
                        children: [
                          Text('Details',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12)),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward_rounded, size: 14),
                        ],
                      ),
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

  // ==========================================================================
  // 5. WHY CHOOSE ARTIFICIAL PIPE CLEANER FLOWERS & CHARMS
  // ==========================================================================
  Widget _buildWhyChooseUsSection() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Text(
                'Why You Will Love "Your Signature"',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: VioletTheme.deepViolet,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Artisan pipe cleaner craftsmanship that brings everlasting smiles',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 30),
              Wrap(
                spacing: 24,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  _buildFeatureCard(
                    icon: Icons.eco_outlined,
                    title: 'Never Withering Blooms',
                    desc:
                        'Unlike real flowers that fade in 3 days, our chenille blooms stay vibrant and fresh for years.',
                  ),
                  _buildFeatureCard(
                    icon: Icons.touch_app_outlined,
                    title: 'Fuzzy & Bendable',
                    desc:
                        'Soft, tactile, and flexible. You can adjust the petals, leaves, and angles anytime.',
                  ),
                  _buildFeatureCard(
                    icon: Icons.savings_outlined,
                    title: 'Budget-Friendly Joy',
                    desc:
                        'Cute keychains starting at ₹49 and radiant floral stems starting at ₹149. Luxury for all.',
                  ),
                  _buildFeatureCard(
                    icon: Icons.palette_outlined,
                    title: 'Violet Aesthetic Vibes',
                    desc:
                        'Exclusively curated violet, amethyst, lavender, and lilac hues to enchant your space.',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String desc,
  }) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: VioletTheme.surfaceViolet,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: VioletTheme.softLavender),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: VioletTheme.paleViolet,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: VioletTheme.primaryViolet, size: 24),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: VioletTheme.deepViolet,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            desc,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF4B5563),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================================
  // 6. INQUIRY SECTION (NAME & MOBILE NO. BOTTOM FIELDS)
  // ==========================================================================
  Widget _buildInquirySection() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 860),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: VioletTheme.softLavender,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: VioletTheme.primaryViolet.withValues(alpha: 0.1),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Form(
              key: _inquiryFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Section Header
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: VioletTheme.paleViolet,
                      shape: BoxShape.circle,
                    ),
                    child: const TulipFlowerIcon(size: 32),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Like Our Products? Make An Inquiry',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: VioletTheme.deepViolet,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Drop your name and mobile number below. Our team will contact you for orders, customizations, and wholesale inquiries!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // TEXT FIELD FOR NAME
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Your Name *',
                      labelStyle:
                          const TextStyle(color: VioletTheme.primaryViolet),
                      hintText: 'Enter your full name',
                      prefixIcon: const Icon(Icons.person_outline,
                          color: VioletTheme.primaryViolet),
                      filled: true,
                      fillColor: VioletTheme.surfaceViolet,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            const BorderSide(color: VioletTheme.softLavender),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                            color: VioletTheme.primaryViolet, width: 2),
                      ),
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),

                  // TEXT FIELD FOR MOBILE NO.
                  TextFormField(
                    controller: _mobileController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Mobile Number *',
                      labelStyle:
                          const TextStyle(color: VioletTheme.primaryViolet),
                      hintText: 'e.g. 9876543210',
                      prefixIcon: const Icon(Icons.phone_iphone_outlined,
                          color: VioletTheme.primaryViolet),
                      prefixText: '+91 ',
                      prefixStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: VioletTheme.deepViolet,
                      ),
                      filled: true,
                      fillColor: VioletTheme.surfaceViolet,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            const BorderSide(color: VioletTheme.softLavender),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                            color: VioletTheme.primaryViolet, width: 2),
                      ),
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Please enter your mobile number';
                      }
                      if (val.trim().length < 10) {
                        return 'Please enter a valid 10-digit mobile number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),

                  // PRODUCT OF INTEREST
                  DropdownButtonFormField<String>(
                    initialValue: _selectedInterest,
                    decoration: InputDecoration(
                      labelText: 'Product of Interest',
                      labelStyle:
                          const TextStyle(color: VioletTheme.primaryViolet),
                      prefixIcon: const Icon(Icons.category_outlined,
                          color: VioletTheme.primaryViolet),
                      filled: true,
                      fillColor: VioletTheme.surfaceViolet,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            const BorderSide(color: VioletTheme.softLavender),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Keychains (Starts ₹49)',
                        child: Text('🔑 Keychains (Starting at ₹49)'),
                      ),
                      DropdownMenuItem(
                        value: 'Flowers (Starts ₹149)',
                        child: Text('💐 Flowers (Starting at ₹149)'),
                      ),
                      DropdownMenuItem(
                        value: 'Custom Bouquet Box',
                        child: Text('🎁 Custom Bouquet Gift Box'),
                      ),
                      DropdownMenuItem(
                        value: 'Bulk Return Favors',
                        child: Text('🎉 Bulk Event / Return Favors'),
                      ),
                    ],
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedInterest = val);
                    },
                  ),
                  const SizedBox(height: 18),

                  // MESSAGE / NOTE
                  TextFormField(
                    controller: _inquiryMessageController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Your Message / Custom Color Request',
                      labelStyle:
                          const TextStyle(color: VioletTheme.primaryViolet),
                      hintText:
                          'e.g. I want 3 violet tulips and 2 bunny keychains in pastel purple...',
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(bottom: 45),
                        child: Icon(Icons.chat_bubble_outline,
                            color: VioletTheme.primaryViolet),
                      ),
                      filled: true,
                      fillColor: VioletTheme.surfaceViolet,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            const BorderSide(color: VioletTheme.softLavender),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // SUBMIT INQUIRY BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: _handleInquirySubmit,
                      icon: const Icon(Icons.send_rounded, color: Colors.white),
                      label: const Text(
                        'Submit Product Inquiry',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: VioletTheme.primaryViolet,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================================================
  // 7. REVIEW SECTION (TEXTFIELD TO REVIEW BUSINESS & LIVE REVIEWS)
  // ==========================================================================
  Widget _buildReviewSection() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 860),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Review Form Container
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: VioletTheme.softLavender,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: VioletTheme.primaryViolet.withValues(alpha: 0.1),
                      blurRadius: 28,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Form(
                  key: _reviewFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF3C7),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.rate_review_outlined,
                            color: Color(0xFFD97706), size: 30),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Review "Your Signature"',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: VioletTheme.deepViolet,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'We value your feedback! Tell us what you loved about our artificial pipe cleaner flowers and keychains.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // STAR RATING PICKER
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          final star = index + 1;
                          return IconButton(
                            iconSize: 32,
                            padding: const EdgeInsets.all(4),
                            icon: Icon(
                              star <= _selectedRating
                                  ? Icons.star_rounded
                                  : Icons.star_border_rounded,
                              color: Colors.amber,
                            ),
                            onPressed: () {
                              setState(() => _selectedRating = star);
                            },
                          );
                        }),
                      ),
                      Text(
                        '$_selectedRating out of 5 Stars',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: VioletTheme.primaryViolet,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // NAME OF REVIEWER
                      TextFormField(
                        controller: _reviewerNameController,
                        decoration: InputDecoration(
                          labelText: 'Your Name *',
                          labelStyle:
                              const TextStyle(color: VioletTheme.primaryViolet),
                          hintText: 'e.g. Sanika P.',
                          prefixIcon: const Icon(Icons.person_outline,
                              color: VioletTheme.primaryViolet),
                          filled: true,
                          fillColor: VioletTheme.surfaceViolet,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                                color: VioletTheme.softLavender),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                                color: VioletTheme.primaryViolet, width: 2),
                          ),
                        ),
                        validator: (val) {
                          if (val == null || val.trim().isEmpty) {
                            return 'Please provide your name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),

                      // REVIEW TEXTFIELD (AS REQUESTED)
                      TextFormField(
                        controller: _reviewTextController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          labelText: 'Write Your Review *',
                          labelStyle:
                              const TextStyle(color: VioletTheme.primaryViolet),
                          hintText:
                              'Describe the flower details, keychain fluffiness, colors, or your overall shopping experience...',
                          prefixIcon: const Padding(
                            padding: EdgeInsets.only(bottom: 60),
                            child: Icon(Icons.edit_note,
                                color: VioletTheme.primaryViolet),
                          ),
                          filled: true,
                          fillColor: VioletTheme.surfaceViolet,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                                color: VioletTheme.softLavender),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                                color: VioletTheme.primaryViolet, width: 2),
                          ),
                        ),
                        validator: (val) {
                          if (val == null || val.trim().isEmpty) {
                            return 'Please share your review thoughts';
                          }
                          if (val.trim().length < 5) {
                            return 'Review is a bit too short (min 5 characters)';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),

                      // SUBMIT REVIEW BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton.icon(
                          onPressed: _handleReviewSubmit,
                          icon: const Icon(Icons.rate_review,
                              color: Colors.white),
                          label: const Text(
                            'Post Business Review',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: VioletTheme.richViolet,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 36),

              // LIVE REVIEWS LIST
              Text(
                'Customer Testimonials (${_reviews.length})',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: VioletTheme.deepViolet,
                ),
              ),
              const SizedBox(height: 16),

              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _reviews.length,
                separatorBuilder: (_, __) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  final review = _reviews[index];
                  return Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: VioletTheme.softLavender),
                      boxShadow: [
                        BoxShadow(
                          color:
                              VioletTheme.primaryViolet.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: VioletTheme.paleViolet,
                              foregroundColor: VioletTheme.deepViolet,
                              radius: 18,
                              child: Text(
                                review.reviewerName.isNotEmpty
                                    ? review.reviewerName[0].toUpperCase()
                                    : '?',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    review.reviewerName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: VioletTheme.deepViolet,
                                    ),
                                  ),
                                  Text(
                                    review.verifiedProduct,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: VioletTheme.richViolet,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: List.generate(
                                5,
                                (s) => Icon(
                                  s < review.rating
                                      ? Icons.star_rounded
                                      : Icons.star_border_rounded,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          review.comment,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF374151),
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          review.timeAgo,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================================
  // 8. FOOTER
  // ==========================================================================
  Widget _buildFooter() {
    return Container(
      color: VioletTheme.deepViolet,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TulipFlowerIcon(size: 32),
                  const SizedBox(width: 10),
                  Text(
                    'your signature',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Handcrafted Artificial Pipe Cleaner Flowers & Whimsical Keychains',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: VioletTheme.softLavender,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 16,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: [
                  _buildFooterBadge('🔑 Keychains From ₹49'),
                  _buildFooterBadge('🌷 Flowers From ₹149'),
                  _buildFooterBadge('💜 100% Handcrafted'),
                  _buildFooterBadge('📦 Pan-India Shipping'),
                ],
              ),
              const SizedBox(height: 24),
              const Divider(color: Color(0xFF581C87)),
              const SizedBox(height: 16),
              Text(
                '© 2026 your signature. All rights reserved. Designed with violet passion.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooterBadge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: VioletTheme.softLavender.withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// ============================================================================
// PRODUCT DETAIL MODAL SHEET
// ============================================================================
class _ProductDetailModal extends StatefulWidget {
  final ProductItem product;
  final VoidCallback onInquire;

  const _ProductDetailModal({
    required this.product,
    required this.onInquire,
  });

  @override
  State<_ProductDetailModal> createState() => _ProductDetailModalState();
}

class _ProductDetailModalState extends State<_ProductDetailModal> {
  late String _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.product.availableColors.first;
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;

    return Container(
      padding: const EdgeInsets.all(28),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: VioletTheme.paleViolet,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  p.category,
                  style: const TextStyle(
                    color: VioletTheme.primaryViolet,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            p.title,
            style: GoogleFonts.playfairDisplay(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: VioletTheme.deepViolet,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(
                'Starting at ₹${p.startingPrice}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: VioletTheme.primaryViolet,
                ),
              ),
              const SizedBox(width: 14),
              const Icon(Icons.star, color: Colors.amber, size: 18),
              Text(' ${p.rating} (${p.reviewCount} customer reviews)'),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            p.description,
            style: const TextStyle(
              color: Color(0xFF4B5563),
              fontSize: 13,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Select Pipe Cleaner Color Shade:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: VioletTheme.deepViolet,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            children: p.availableColors.map((color) {
              final isSel = _selectedColor == color;
              return ChoiceChip(
                label: Text(color),
                selected: isSel,
                onSelected: (val) {
                  if (val) setState(() => _selectedColor = color);
                },
                selectedColor: VioletTheme.primaryViolet,
                labelStyle: TextStyle(
                  color: isSel ? Colors.white : VioletTheme.deepViolet,
                  fontSize: 12,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: widget.onInquire,
              icon: const Icon(Icons.send_outlined, color: Colors.white),
              label: Text(
                'Inquire About This ${p.category.toLowerCase() == "keychains" ? "Keychain (₹${p.startingPrice})" : "Flower (₹${p.startingPrice})"}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: VioletTheme.primaryViolet,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

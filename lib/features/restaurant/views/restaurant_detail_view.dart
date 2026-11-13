import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_frame.dart';

class RestaurantDetailView extends StatefulWidget {
  const RestaurantDetailView({required this.onBack, super.key});

  final VoidCallback onBack;

  @override
  State<RestaurantDetailView> createState() => _RestaurantDetailViewState();
}

class _RestaurantDetailViewState extends State<RestaurantDetailView> {
  String selectedTab = 'Popular';
  int basketCount = 2;
  double basketTotal = 24.98;

  @override
  Widget build(BuildContext context) {
    return AppFrame(
      child: Scaffold(
        backgroundColor: AppColors.cream,
        body: Stack(
          children: [
            Column(
              children: [
                _HeroImage(onBack: widget.onBack),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _RestaurantInfo(),
                        const SizedBox(height: 16),
                        _TabBar(
                          selectedTab: selectedTab,
                          onTabSelected: (tab) =>
                              setState(() => selectedTab = tab),
                        ),
                        const SizedBox(height: 16),
                        _MenuSection(),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            _FloatingBasket(count: basketCount, total: basketTotal),
          ],
        ),
      ),
    );
  }
}

class _HeroImage extends StatelessWidget {
  final VoidCallback onBack;

  const _HeroImage({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 280,
          width: double.infinity,
          child: Image.asset('assets/photo-margherita.png', fit: BoxFit.cover),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: onBack,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      size: 20,
                      color: AppColors.ink,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.ios_share,
                        size: 20,
                        color: AppColors.ink,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.favorite_border,
                        size: 20,
                        color: AppColors.ink,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _RestaurantInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Napoli Street Pizza',
                  style: AppText.inter(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: AppColors.ink,
                    height: 1.2,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Color(0xFFF5A623).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Icon(Icons.star, size: 14, color: Color(0xFFF5A623)),
                    const SizedBox(width: 4),
                    Text(
                      '4.8',
                      style: AppText.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.ink,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '(1.2k)',
                      style: AppText.inter(
                        fontSize: 12,
                        color: AppColors.muted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Italian · Pizza · ££ · 1.2 km away',
            style: AppText.inter(fontSize: 14, color: AppColors.muted),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _InfoChip(Icons.access_time, '25-35 min'),
              const SizedBox(width: 12),
              _InfoChip(Icons.delivery_dining, '£1.49 delivery'),
              const SizedBox(width: 12),
              _InfoChip(Icons.credit_card, 'Min. £8'),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.orange.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.orange.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: AppColors.orange.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.percent, size: 16, color: AppColors.orange),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '20% off orders over £20',
                    style: AppText.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.ink,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.orange,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Auto-applied',
                    style: AppText.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
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
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.muted),
        const SizedBox(width: 4),
        Text(label, style: AppText.inter(fontSize: 13, color: AppColors.muted)),
      ],
    );
  }
}

class _TabBar extends StatelessWidget {
  final String selectedTab;
  final ValueChanged<String> onTabSelected;

  const _TabBar({required this.selectedTab, required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    final tabs = ['Popular', 'Pizzas', 'Sides', 'Drinks', 'Desserts'];

    return Container(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          final tab = tabs[index];
          final isSelected = tab == selectedTab;
          return GestureDetector(
            onTap: () => onTabSelected(tab),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.ink : Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                tab,
                style: AppText.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : AppColors.ink,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _MenuSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Popular',
            style: AppText.inter(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 16),
          _MenuItem(
            name: 'Margherita',
            description: 'San Marzano tomato, fior di latte, fresh basil',
            price: '£10.99',
            image: 'assets/photo-margherita.png',
            badge: 'BESTSELLER',
          ),
          const SizedBox(height: 12),
          _MenuItem(
            name: 'Diavola',
            description: 'Spicy salami, chilli, mozzarella, oregano',
            price: '£12.49',
            image: 'assets/photo-sushi.png',
          ),
          const SizedBox(height: 12),
          _MenuItem(
            name: 'Garlic Bread',
            description: 'Wood-fired with rosemary butter',
            price: '£4.99',
            image: 'assets/photo-bowl.png',
          ),
          const SizedBox(height: 12),
          _MenuItem(
            name: 'Tiramisu',
            description: 'Classic mascarpone & espresso',
            price: '£5.49',
            image: 'assets/photo-margherita.png',
            badge: 'NEW',
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String name;
  final String description;
  final String price;
  final String image;
  final String? badge;

  const _MenuItem({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppText.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: AppText.inter(
                    fontSize: 13,
                    color: AppColors.muted,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      price,
                      style: AppText.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.ink,
                      ),
                    ),
                    if (badge != null) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: badge == 'BESTSELLER'
                              ? AppColors.orange.withValues(alpha: 0.15)
                              : AppColors.green.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          badge!,
                          style: AppText.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: badge == 'BESTSELLER'
                                ? AppColors.orange
                                : AppColors.green,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Stack(
            children: [
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(image, fit: BoxFit.cover),
                ),
              ),
              Positioned(
                bottom: 6,
                right: 6,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.orange,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.orange.withValues(alpha: 0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(Icons.add, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FloatingBasket extends StatelessWidget {
  final int count;
  final double total;

  const _FloatingBasket({required this.count, required this.total});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20,
      right: 20,
      bottom: 32,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.ink,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.ink.withValues(alpha: 0.4),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.orange,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$count',
                  style: AppText.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                'View basket',
                style: AppText.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              '£${total.toStringAsFixed(2)}',
              style: AppText.inter(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

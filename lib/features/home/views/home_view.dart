import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_frame.dart';

class HomeView extends StatefulWidget {
  const HomeView({required this.onRestaurantTap, super.key});

  final VoidCallback onRestaurantTap;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return AppFrame(
      child: Scaffold(
        backgroundColor: AppColors.cream,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _DeliveryAddress(),
                    const SizedBox(height: 16),
                    _SearchBar(),
                    const SizedBox(height: 16),
                    _PromoCard(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _CategoriesSection(),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
            SliverToBoxAdapter(
              child: _PopularSection(onRestaurantTap: widget.onRestaurantTap),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
            SliverToBoxAdapter(child: _OrderAgainSection()),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
        bottomNavigationBar: _BottomNav(),
      ),
    );
  }
}

class _DeliveryAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'DELIVER TO',
          style: AppText.inter(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: AppColors.muted,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.location_on, size: 18, color: AppColors.orange),
            const SizedBox(width: 4),
            Text(
              'Home - 14 Oakfield Rd',
              style: AppText.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(width: 4),
            Icon(Icons.keyboard_arrow_down, size: 20, color: AppColors.ink),
            const Spacer(),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.notifications_outlined,
                size: 22,
                color: AppColors.ink,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search dishes or restaurants',
                hintStyle: AppText.inter(
                  fontSize: 14,
                  color: AppColors.muted.withValues(alpha: 0.6),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.muted,
                  size: 22,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.ink,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(Icons.tune, color: Colors.white, size: 22),
        ),
      ],
    );
  }
}

class _PromoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.orange, Color(0xFFFF8C5A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'FIRST ORDER',
                        style: AppText.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '30% off\nfirst order',
                      style: AppText.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Use code MUNCH30',
                    style: AppText.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.ink,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 12,
            top: 12,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/photo-margherita.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoriesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Categories',
              style: AppText.inter(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.ink,
              ),
            ),
            Text(
              'See all',
              style: AppText.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.orange,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [
              _CategoryItem('Pizza', 'assets/photo-margherita.png'),
              _CategoryItem('Burgers', 'assets/photo-bowl.png'),
              _CategoryItem('Sushi', 'assets/photo-sushi.png'),
              _CategoryItem('Healthy', 'assets/photo-bowl.png'),
              _CategoryItem('Desserts', 'assets/photo-margherita.png'),
            ],
          ),
        ),
      ],
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final String label;
  final String image;

  const _CategoryItem(this.label, this.image);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(image, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: AppText.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.ink,
            ),
          ),
        ],
      ),
    );
  }
}

class _PopularSection extends StatelessWidget {
  final VoidCallback onRestaurantTap;

  const _PopularSection({required this.onRestaurantTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Popular near you',
                style: AppText.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink,
                ),
              ),
              Text(
                'See all',
                style: AppText.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.orange,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 280,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _RestaurantCard(
                name: 'Napoli Street Pizza',
                rating: '4.8',
                time: '25-35 min',
                delivery: '£1.49 delivery',
                category: 'Italian',
                image: 'assets/photo-margherita.png',
                discount: '20% OFF',
                onTap: onRestaurantTap,
              ),
              _RestaurantCard(
                name: 'Burger Barn',
                rating: '4.6',
                time: '15-25 min',
                delivery: 'Free delivery',
                category: 'American',
                image: 'assets/photo-bowl.png',
                onTap: onRestaurantTap,
              ),
              _RestaurantCard(
                name: 'Sushi Master',
                rating: '4.9',
                time: '30-40 min',
                delivery: '£2.49 delivery',
                category: 'Japanese',
                image: 'assets/photo-sushi.png',
                onTap: onRestaurantTap,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RestaurantCard extends StatelessWidget {
  final String name;
  final String rating;
  final String time;
  final String delivery;
  final String category;
  final String image;
  final String? discount;
  final VoidCallback? onTap;

  const _RestaurantCard({
    required this.name,
    required this.rating,
    required this.time,
    required this.delivery,
    required this.category,
    required this.image,
    this.discount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: name,
                  child: Container(
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),
                if (discount != null)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.orange,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        discount!,
                        style: AppText.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.favorite_border,
                      size: 18,
                      color: AppColors.ink,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              name,
              style: AppText.inter(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.ink,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.star, size: 14, color: Color(0xFFF5A623)),
                const SizedBox(width: 4),
                Text(
                  rating,
                  style: AppText.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.access_time, size: 14, color: AppColors.muted),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    time,
                    style: AppText.inter(fontSize: 13, color: AppColors.muted),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: Text(
                    delivery,
                    style: AppText.inter(fontSize: 13, color: AppColors.muted),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  ' · ',
                  style: AppText.inter(fontSize: 13, color: AppColors.muted),
                ),
                Text(
                  category,
                  style: AppText.inter(fontSize: 13, color: AppColors.muted),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderAgainSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order again',
                style: AppText.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink,
                ),
              ),
              Text(
                'View orders',
                style: AppText.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _OrderAgainItem(
            name: 'Sakura Sushi',
            description: 'Salmon nigiri set · 2 days ago',
            image: 'assets/photo-sushi.png',
          ),
          const SizedBox(height: 12),
          _OrderAgainItem(
            name: 'Green Bowl',
            description: 'Chicken Caesar bowl · Last week',
            image: 'assets/photo-bowl.png',
          ),
        ],
      ),
    );
  }
}

class _OrderAgainItem extends StatelessWidget {
  final String name;
  final String description;
  final String image;

  const _OrderAgainItem({
    required this.name,
    required this.description,
    required this.image,
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
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(image, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 12),
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
                  style: AppText.inter(fontSize: 13, color: AppColors.muted),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.orange,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Reorder',
              style: AppText.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(Icons.home, 'Home', true),
            _NavItem(Icons.search, 'Search', false),
            _NavItem(Icons.receipt_long_outlined, 'Orders', false),
            _NavItem(Icons.person_outline, 'Profile', false),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;

  const _NavItem(this.icon, this.label, this.active);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: active ? AppColors.ink : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 22, color: active ? Colors.white : AppColors.muted),
          if (active) ...[
            const SizedBox(width: 8),
            Text(
              label,
              style: AppText.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

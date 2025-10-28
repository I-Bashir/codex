import 'package:flutter/material.dart';

void main() {
  runApp(const VodaApp());
}

class VodaApp extends StatelessWidget {
  const VodaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Voda',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0E6BA8),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF4F8FF),
        fontFamily: 'Roboto',
      ),
      home: const VodaHomePage(),
    );
  }
}

class VodaHomePage extends StatelessWidget {
  const VodaHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final activeJourneys = _ActiveLake.demo();
    final highlights = _HighlightLake.demo();
    final latest = _LatestLake.demo();

    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFFF4F8FF),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        elevation: 4,
        shape: const CircleBorder(),
        backgroundColor: const Color(0xFF0E6BA8),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: const _VodaBottomNavigation(),
      body: SafeArea(
        child: Stack(
          children: [
            const _WaterBackdrop(),
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                const SliverToBoxAdapter(child: SizedBox(height: 18)),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        _HomeAppBar(),
                        SizedBox(height: 22),
                        _HeroHeader(),
                        SizedBox(height: 24),
                        _StatRow(),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 28)),
                SliverToBoxAdapter(
                  child: _SectionHeader(
                    title: 'Active lakes',
                    subtitle: 'Keep pouring into your goals',
                    actionLabel: 'View all',
                    onActionTap: () {},
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 228,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => _ActiveLakeCard(
                        lake: activeJourneys[index],
                      ),
                      separatorBuilder: (context, index) => const SizedBox(width: 16),
                      itemCount: activeJourneys.length,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 28)),
                SliverToBoxAdapter(
                  child: _SectionHeader(
                    title: 'Community spotlights',
                    subtitle: 'See how other drops are flowing',
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      children: highlights
                          .map((lake) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: _HighlightLakeCard(lake: lake),
                              ))
                          .toList(),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: _SectionHeader(
                    title: 'Latest lakes',
                    subtitle: 'Fresh journeys to dive into',
                    actionLabel: 'Explore more',
                    onActionTap: () {},
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(22, 18, 22, 32),
                  sliver: SliverToBoxAdapter(
                    child: Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: latest
                          .map((lake) => _LatestLakeCard(lake: lake))
                          .toList(),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: Center(
                      child: Text(
                        'Made with 💧',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: const Color(0xFF8EA6C1),
                              letterSpacing: 0.5,
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
    );
  }
}

class _WaterBackdrop extends StatelessWidget {
  const _WaterBackdrop();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0E6BA8), Color(0xFFE7F4FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.45],
          ),
        ),
      ),
    );
  }
}

class _HomeAppBar extends StatelessWidget {
  const _HomeAppBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Color(0x22000000),
                blurRadius: 12,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'V',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
                color: Color(0xFF0E6BA8),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Morning tide,',
                style: TextStyle(
                  color: Color(0xFFCAE1F9),
                  fontSize: 14,
                  letterSpacing: 0.2,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Avery Flores',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ),
        _CircleIconButton(
          icon: Icons.search,
          onPressed: () {},
        ),
        const SizedBox(width: 12),
        _CircleIconButton(
          icon: Icons.notifications_outlined,
          onPressed: () {},
          hasBadge: true,
        ),
      ],
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.icon,
    required this.onPressed,
    this.hasBadge = false,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final bool hasBadge;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.16),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white.withOpacity(0.4)),
            ),
            child: Icon(icon, color: Colors.white),
          ),
        ),
        if (hasBadge)
          const Positioned(
            right: -2,
            top: -2,
            child: CircleAvatar(
              radius: 6,
              backgroundColor: Color(0xFFFF6B6B),
            ),
          ),
      ],
    );
  }
}

class _HeroHeader extends StatelessWidget {
  const _HeroHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF63C5EA), Color(0xFF0E6BA8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: const [
          BoxShadow(
            color: Color(0x330E6BA8),
            blurRadius: 24,
            offset: Offset(0, 20),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Keep your flow going',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'You’re on day 7 of your streak. Two lakes need attention today.',
                  style: TextStyle(
                    color: Color(0xFFE0F4FF),
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 16),
                _HeroPill(label: 'Check in now'),
              ],
            ),
          ),
          const SizedBox(width: 20),
          const _HeroProgress(value: 0.74),
        ],
      ),
    );
  }
}

class _HeroPill extends StatelessWidget {
  const _HeroPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.schedule, size: 16, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroProgress extends StatelessWidget {
  const _HeroProgress({required this.value});

  final double value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: 120,
            width: 120,
            child: CircularProgressIndicator(
              value: value,
              strokeWidth: 12,
              backgroundColor: Colors.white.withOpacity(0.18),
              valueColor: const AlwaysStoppedAnimation(Color(0xFFBFF0FF)),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${(value * 100).round()}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Weekly flow',
                style: TextStyle(
                  color: Color(0xFFE0F4FF),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow();

  @override
  Widget build(BuildContext context) {
    final stats = _QuickStat.demo();
    return Row(
      children: [
        for (int i = 0; i < stats.length; i++)
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: i == stats.length - 1 ? 0 : 12),
              child: _QuickStatCard(stat: stats[i]),
            ),
          ),
      ],
    );
  }
}

class _QuickStatCard extends StatelessWidget {
  const _QuickStatCard({required this.stat});

  final _QuickStat stat;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 16,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: stat.color.withOpacity(0.18),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(stat.icon, color: stat.color),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stat.label,
                style: const TextStyle(
                  color: Color(0xFF6B7A90),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                stat.value,
                style: const TextStyle(
                  color: Color(0xFF0E3657),
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onActionTap,
  });

  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFF0E3657),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 6),
                      Text(
                        subtitle!,
                        style: const TextStyle(
                          color: Color(0xFF6B7A90),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (actionLabel != null)
                TextButton.icon(
                  onPressed: onActionTap,
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF0E6BA8),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  icon: const Icon(Icons.chevron_right_rounded, size: 20),
                  label: Text(
                    actionLabel!,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActiveLake {
  const _ActiveLake({
    required this.title,
    required this.category,
    required this.progress,
    required this.members,
    required this.daysRemaining,
    required this.palette,
    required this.avatars,
  });

  final String title;
  final String category;
  final double progress;
  final int members;
  final int daysRemaining;
  final List<Color> palette;
  final List<String> avatars;

  static List<_ActiveLake> demo() {
    return const [
      _ActiveLake(
        title: '30-Day Gratitude Writing',
        category: 'Mindfulness',
        progress: 0.72,
        members: 128,
        daysRemaining: 5,
        palette: [Color(0xFF5AC8FA), Color(0xFF0E6BA8)],
        avatars: ['AV', 'JT', 'ML', '+8'],
      ),
      _ActiveLake(
        title: 'Sunrise Run Crew',
        category: 'Movement',
        progress: 0.58,
        members: 86,
        daysRemaining: 12,
        palette: [Color(0xFF9AE6B4), Color(0xFF34D399)],
        avatars: ['KR', 'OC', 'AM', '+5'],
      ),
      _ActiveLake(
        title: 'Code 15 Minutes Daily',
        category: 'Growth',
        progress: 0.81,
        members: 212,
        daysRemaining: 9,
        palette: [Color(0xFFFFC98B), Color(0xFFFF914D)],
        avatars: ['JB', 'LS', 'TW', '+12'],
      ),
      _ActiveLake(
        title: 'Evening Wind-down Stretch',
        category: 'Balance',
        progress: 0.42,
        members: 64,
        daysRemaining: 16,
        palette: [Color(0xFFB3E5FC), Color(0xFF2196F3)],
        avatars: ['NP', 'HS', 'AE', '+3'],
      ),
    ];
  }
}

class _ActiveLakeCard extends StatelessWidget {
  const _ActiveLakeCard({required this.lake});

  final _ActiveLake lake;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: lake.palette,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: lake.palette.last.withOpacity(0.35),
            blurRadius: 22,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _LakeBadge(text: lake.category),
          const SizedBox(height: 16),
          Text(
            lake.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: lake.progress,
            minHeight: 8,
            backgroundColor: Colors.white.withOpacity(0.25),
            valueColor: const AlwaysStoppedAnimation(Colors.white),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                '${(lake.progress * 100).round()}% complete',
                style: const TextStyle(
                  color: Color(0xFFE7F8FF),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              _LakeBadge(text: '${lake.daysRemaining} days left', light: true),
            ],
          ),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _OverlappedAvatars(initials: lake.avatars),
              const SizedBox(width: 12),
              Text(
                '${lake.members} drops',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OverlappedAvatars extends StatelessWidget {
  const _OverlappedAvatars({required this.initials});

  final List<String> initials;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: Stack(
        children: [
          for (int i = 0; i < initials.length; i++)
            Positioned(
              left: i * 22,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: const Color(0x33000000),
                  child: Text(
                    initials[i],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _LakeBadge extends StatelessWidget {
  const _LakeBadge({required this.text, this.light = false});

  final String text;
  final bool light;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: light ? Colors.white.withOpacity(0.25) : Colors.white.withOpacity(0.18),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.35)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _HighlightLake {
  const _HighlightLake({
    required this.title,
    required this.description,
    required this.icon,
    required this.iconColor,
    required this.gradient,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;
  final List<Color> gradient;

  static List<_HighlightLake> demo() {
    return const [
      _HighlightLake(
        title: 'Morning Flow Circle',
        description: 'Top community this week. Members logged 420 mindful minutes.',
        icon: Icons.bolt_rounded,
        iconColor: Color(0xFFFFD166),
        gradient: [Color(0xFF8EC5FC), Color(0xFFE0C3FC)],
      ),
      _HighlightLake(
        title: 'Drop of the Day: Naomi',
        description: 'Completed her 60-day yoga lake and invited 14 new drops.',
        icon: Icons.emoji_events_rounded,
        iconColor: Color(0xFFFF9F1C),
        gradient: [Color(0xFFA1FFCE), Color(0xFFFAFFD1)],
      ),
      _HighlightLake(
        title: 'Creator spotlight: The Blue Crew',
        description: 'Hosted a weekend cleanup and raised funds for clean water access.',
        icon: Icons.public_rounded,
        iconColor: Color(0xFF4D96FF),
        gradient: [Color(0xFFD9E4FF), Color(0xFFB1C7FF)],
      ),
    ];
  }
}

class _HighlightLakeCard extends StatelessWidget {
  const _HighlightLakeCard({required this.lake});

  final _HighlightLake lake;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: lake.gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(lake.icon, color: lake.iconColor, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lake.title,
                    style: const TextStyle(
                      color: Color(0xFF16324F),
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    lake.description,
                    style: const TextStyle(
                      color: Color(0xFF274C77),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.chevron_right_rounded),
              color: const Color(0xFF274C77),
            ),
          ],
        ),
      ),
    );
  }
}

class _LatestLake {
  const _LatestLake({
    required this.title,
    required this.creator,
    required this.members,
    required this.goal,
  });

  final String title;
  final String creator;
  final int members;
  final String goal;

  static List<_LatestLake> demo() {
    return const [
      _LatestLake(
        title: 'Hydration Habit Reset',
        creator: '@alexis',
        members: 56,
        goal: 'Drink 2L daily',
      ),
      _LatestLake(
        title: 'Deep Work Sprint',
        creator: '@daniel',
        members: 102,
        goal: '90-minute focus blocks',
      ),
      _LatestLake(
        title: 'Digital Sunset Club',
        creator: '@jamie',
        members: 33,
        goal: 'No screens after 9pm',
      ),
      _LatestLake(
        title: 'Stretch + Breathe',
        creator: '@lina',
        members: 88,
        goal: 'Daily mobility routine',
      ),
      _LatestLake(
        title: 'Slow Reading Evenings',
        creator: '@booksandboba',
        members: 41,
        goal: 'Finish 1 book / month',
      ),
      _LatestLake(
        title: 'Plant-based Mondays',
        creator: '@river',
        members: 67,
        goal: 'Cook 4 recipes together',
      ),
      _LatestLake(
        title: 'Mindful Evenings',
        creator: '@sofi',
        members: 73,
        goal: '15 minutes of journaling',
      ),
      _LatestLake(
        title: 'Voda Creators Lab',
        creator: '@voda-team',
        members: 240,
        goal: 'Prototype new lake ideas',
      ),
    ];
  }
}

class _LatestLakeCard extends StatelessWidget {
  const _LatestLakeCard({required this.lake});

  final _LatestLake lake;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 172,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 14,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F4FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.water_drop_rounded,
              color: Color(0xFF0E6BA8),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            lake.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF0E3657),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            lake.goal,
            style: const TextStyle(
              color: Color(0xFF5F6C7B),
              fontSize: 12,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: const Color(0xFF0E6BA8).withOpacity(0.1),
                child: Text(
                  lake.creator.substring(1, 3).toUpperCase(),
                  style: const TextStyle(
                    color: Color(0xFF0E6BA8),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lake.creator,
                      style: const TextStyle(
                        color: Color(0xFF5F6C7B),
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '${lake.members} drops',
                      style: const TextStyle(
                        color: Color(0xFF0E6BA8),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickStat {
  const _QuickStat({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  static List<_QuickStat> demo() {
    return const [
      _QuickStat(
        label: 'Active lakes',
        value: '04',
        icon: Icons.water_drop_outlined,
        color: Color(0xFF3BAFDA),
      ),
      _QuickStat(
        label: 'Completed',
        value: '12',
        icon: Icons.check_circle_outline_rounded,
        color: Color(0xFF34D399),
      ),
      _QuickStat(
        label: 'Your drops',
        value: '1.2k',
        icon: Icons.groups_2_outlined,
        color: Color(0xFFFF9F1C),
      ),
    ];
  }
}

class _VodaBottomNavigation extends StatelessWidget {
  const _VodaBottomNavigation();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 80,
      elevation: 12,
      color: Colors.white,
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            _BottomNavItem(icon: Icons.home_rounded, label: 'Home', active: true),
            _BottomNavItem(icon: Icons.chat_bubble_outline_rounded, label: 'Chat'),
            SizedBox(width: 48),
            _BottomNavItem(icon: Icons.emoji_events_outlined, label: 'Badges'),
            _BottomNavItem(icon: Icons.person_outline_rounded, label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.icon,
    required this.label,
    this.active = false,
  });

  final IconData icon;
  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final color = active ? const Color(0xFF0E6BA8) : const Color(0xFF9AA5B1);
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

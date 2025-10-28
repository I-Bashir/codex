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
          seedColor: const Color(0xFF0C5C8A),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F9FF),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Color(0xFF1F2933),
          ),
        ),
      ),
      home: const VodaHomePage(),
    );
  }
}

class VodaHomePage extends StatelessWidget {
  const VodaHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final activeLakes = _ActiveLake.demo();
    final latestLakes = _LatestLake.demo();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F9FF),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF0C5C8A),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: const _VodaBottomNavigation(),
      body: SafeArea(
        child: Column(
          children: [
            const _HomeAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _HomeHero(),
                    const SizedBox(height: 28),
                    const _SectionHeader(
                      title: 'Active Lakes',
                      badgeText: 'Yours',
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 210,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => _ActiveLakeCard(
                          lake: activeLakes[index],
                        ),
                        separatorBuilder: (context, index) => const SizedBox(width: 16),
                        itemCount: activeLakes.length,
                        padding: const EdgeInsets.only(right: 4),
                      ),
                    ),
                    const SizedBox(height: 28),
                    _SectionHeader(
                      title: 'Latest Lakes',
                      actionLabel: 'Explore more',
                      onActionTap: () {},
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: latestLakes
                          .map(
                            (lake) => _LatestLakeCard(lake: lake),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: Text(
                        'Made with 💧',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: const Color(0xFF9AA5B1),
                              letterSpacing: 0.4,
                            ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeAppBar extends StatelessWidget {
  const _HomeAppBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color(0x33134567),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                'V',
                style: TextStyle(
                  color: Color(0xFF0C5C8A),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
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
                  'Welcome back,',
                  style: TextStyle(
                    color: Color(0xFF5A7184),
                    fontSize: 13,
                    letterSpacing: 0.1,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Avery Flores',
                  style: TextStyle(
                    color: Color(0xFF0B3954),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Color(0xFF0C5C8A)),
          ),
          IconButton(
            onPressed: () {},
            icon: Stack(
              clipBehavior: Clip.none,
              children: const [
                Icon(Icons.notifications_none, color: Color(0xFF0C5C8A)),
                Positioned(
                  right: -2,
                  top: -2,
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor: Color(0xFFFF6B6B),
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

class _HomeHero extends StatelessWidget {
  const _HomeHero();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: const Color(0x111F2933),
                blurRadius: 16,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _HeroStat(
                      label: 'Streak',
                      value: '7 Days',
                      icon: Icons.local_fire_department_outlined,
                      iconColor: const Color(0xFFFF7A59),
                    ),
                    const SizedBox(height: 12),
                    _ProgressBar(
                      label: 'Progress',
                      valueLabel: '68%',
                      progress: 0.68,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF38BDF8), Color(0xFF0EA5E9)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.water_drop, size: 28, color: Colors.white),
                    SizedBox(height: 6),
                    Text(
                      'Active
Lakes: 4',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HeroStat extends StatelessWidget {
  const _HeroStat({
    required this.label,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$label:',
              style: const TextStyle(
                color: Color(0xFF5A7184),
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({
    required this.label,
    required this.valueLabel,
    required this.progress,
  });

  final String label;
  final String valueLabel;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '$label:',
              style: const TextStyle(
                color: Color(0xFF5A7184),
                fontSize: 13,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              valueLabel,
              style: const TextStyle(
                color: Color(0xFF0C5C8A),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            minHeight: 10,
            value: progress,
            backgroundColor: const Color(0xFFE3F2FD),
            valueColor: const AlwaysStoppedAnimation(Color(0xFF38BDF8)),
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    this.badgeText,
    this.actionLabel,
    this.onActionTap,
  });

  final String title;
  final String? badgeText;
  final String? actionLabel;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0B3954),
          ),
        ),
        if (badgeText != null) ...[
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFDCF3FF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              badgeText!,
              style: const TextStyle(
                color: Color(0xFF0C5C8A),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
        const Spacer(),
        if (actionLabel != null)
          TextButton(
            onPressed: onActionTap,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              foregroundColor: const Color(0xFF0C5C8A),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  actionLabel!,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.chevron_right, size: 18),
              ],
            ),
          ),
      ],
    );
  }
}

class _ActiveLake {
  const _ActiveLake({
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.remainingDays,
    required this.gradient,
  });

  final String title;
  final String subtitle;
  final double progress;
  final int remainingDays;
  final List<Color> gradient;

  static List<_ActiveLake> demo() {
    return const [
      _ActiveLake(
        title: '30-Day Reading Challenge',
        subtitle: '75%  |  129/172',
        progress: 0.75,
        remainingDays: 12,
        gradient: [Color(0xFF60A5FA), Color(0xFF3B82F6)],
      ),
      _ActiveLake(
        title: 'Daily Mindfulness',
        subtitle: '92%  |  81 Days',
        progress: 0.92,
        remainingDays: 9,
        gradient: [Color(0xFFFBBF24), Color(0xFFF59E0B)],
      ),
      _ActiveLake(
        title: 'Morning Run Crew',
        subtitle: '54%  |  32/60',
        progress: 0.54,
        remainingDays: 21,
        gradient: [Color(0xFF34D399), Color(0xFF10B981)],
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
      width: 240,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          colors: lake.gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: lake.gradient.last.withOpacity(0.25),
            blurRadius: 18,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.22),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Text(
              'Active',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
          const Spacer(),
          Text(
            lake.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            lake.subtitle,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              minHeight: 8,
              value: lake.progress,
              backgroundColor: Colors.white.withOpacity(0.2),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '${lake.remainingDays} Days Remaining',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _LatestLake {
  const _LatestLake({
    required this.title,
    required this.creator,
    required this.avatar,
    required this.members,
    required this.goal,
    required this.background,
  });

  final String title;
  final String creator;
  final String avatar;
  final String members;
  final String goal;
  final List<Color> background;

  static List<_LatestLake> demo() {
    return const [
      _LatestLake(
        title: 'Mindful Eating Challenge for 21 Days',
        creator: 'Lazyfrog44',
        avatar: '🍓',
        members: '35 / 120',
        goal: '21 Days',
        background: [Color(0xFFFFF7E6), Color(0xFFFFEDD5)],
      ),
      _LatestLake(
        title: 'Yoga for Absolute Beginners',
        creator: 'crazybanana11',
        avatar: '🧘',
        members: '52 / 100',
        goal: '30 Days',
        background: [Color(0xFFE0F2FE), Color(0xFFBAE6FD)],
      ),
      _LatestLake(
        title: 'Build a Small Web App in a Week',
        creator: 'thePakistaniNinja17',
        avatar: '💡',
        members: '28 / 40',
        goal: '7 Days',
        background: [Color(0xFFEDE9FE), Color(0xFFDAD5FE)],
      ),
      _LatestLake(
        title: '10-Minute Daily Meditation Habit',
        creator: 'buyukadam23',
        avatar: '🧘‍♂️',
        members: '60 / 80',
        goal: '30 Days',
        background: [Color(0xFFFEE2E2), Color(0xFFFECACA)],
      ),
      _LatestLake(
        title: 'Couch to 5K Sprint Group',
        creator: 'pacepioneer',
        avatar: '🏃‍♂️',
        members: '42 / 90',
        goal: '9 Weeks',
        background: [Color(0xFFD1FAE5), Color(0xFFA7F3D0)],
      ),
      _LatestLake(
        title: '60-Day Journaling Circle',
        creator: 'writewave',
        avatar: '📓',
        members: '19 / 50',
        goal: '60 Days',
        background: [Color(0xFFE0E7FF), Color(0xFFC7D2FE)],
      ),
    ];
  }
}

class _LatestLakeCard extends StatelessWidget {
  const _LatestLakeCard({required this.lake});

  final _LatestLake lake;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 20 * 2 - 16) / 2,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: lake.background,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(
                      lake.avatar,
                      style: const TextStyle(fontSize: 22),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lake.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF0B3954),
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '@${lake.creator}',
                        style: const TextStyle(
                          color: Color(0xFF5A7184),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.group_outlined, size: 18, color: Color(0xFF0C5C8A)),
                const SizedBox(width: 6),
                Text(
                  lake.members,
                  style: const TextStyle(
                    color: Color(0xFF0C5C8A),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    lake.goal,
                    style: const TextStyle(
                      color: Color(0xFF0C5C8A),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
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

class _VodaBottomNavigation extends StatelessWidget {
  const _VodaBottomNavigation();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 78,
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      color: Colors.white,
      elevation: 12,
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
    final color = active ? const Color(0xFF0C5C8A) : const Color(0xFF9AA5B1);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
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

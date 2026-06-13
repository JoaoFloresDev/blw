import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../l10n/app_localizations.dart';
import '../services/storage_service.dart';
import '../widgets/paywall_view.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onComplete;

  const OnboardingScreen({super.key, required this.onComplete});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // MARK: - Constants
  static const int _featurePageCount = 3;

  // MARK: - Properties
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // MARK: - Lifecycle
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // MARK: - Actions
  void _nextPage() {
    if (_currentPage < _featurePageCount - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _openPaywall();
    }
  }

  /// Pushes the paywall as a native horizontal route (iOS push with parallax
  /// + edge shadow) — a clean transition since both screens share the green
  /// background and a plain page slide would look static.
  void _openPaywall() {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (routeContext) => Scaffold(
          backgroundColor: const Color(0xFF1B9A43),
          body: PaywallView(
            isOnboarding: true,
            onClose: () {
              Navigator.of(routeContext).pop();
              _completeOnboarding();
            },
          ),
        ),
      ),
    );
  }

  void _completeOnboarding() async {
    await StorageService.setOnboardingComplete();
    widget.onComplete();
  }

  // MARK: - View
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final pages = [
      _OnboardingPageData(
        icon: CupertinoIcons.heart_fill,
        title: l10n.onboardingTitle1,
        description: l10n.onboardingDesc1,
      ),
      _OnboardingPageData(
        icon: CupertinoIcons.leaf_arrow_circlepath,
        title: l10n.onboardingTitle2,
        description: l10n.onboardingDesc2,
      ),
      _OnboardingPageData(
        icon: CupertinoIcons.camera_fill,
        title: l10n.onboardingTitle3,
        description: l10n.onboardingDesc3,
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF1FA047),
      body: PageView.builder(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) => setState(() => _currentPage = index),
        itemCount: pages.length,
        itemBuilder: (context, index) {
          return _OnboardingFeaturePage(
            key: ValueKey(index),
            data: pages[index],
            pageIndex: index,
            pageCount: _featurePageCount,
            onNext: _nextPage,
            onSkip: _completeOnboarding,
            l10n: l10n,
          );
        },
      ),
    );
  }
}

// MARK: - Feature page (AppLock style, green palette)

class _OnboardingFeaturePage extends StatefulWidget {
  final _OnboardingPageData data;
  final int pageIndex;
  final int pageCount;
  final VoidCallback onNext;
  final VoidCallback onSkip;
  final AppLocalizations l10n;

  const _OnboardingFeaturePage({
    super.key,
    required this.data,
    required this.pageIndex,
    required this.pageCount,
    required this.onNext,
    required this.onSkip,
    required this.l10n,
  });

  @override
  State<_OnboardingFeaturePage> createState() => _OnboardingFeaturePageState();
}

class _OnboardingFeaturePageState extends State<_OnboardingFeaturePage>
    with TickerProviderStateMixin {
  // MARK: - Animation State
  bool _showIcon = false;
  bool _showTitle = false;
  bool _showDescription = false;
  bool _showButton = false;
  bool _isButtonPressed = false;

  late final AnimationController _pulseController;

  // MARK: - Lifecycle
  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _startEntrance();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _startEntrance() {
    _stagger(0, () => _showIcon = true);
    _stagger(120, () => _showTitle = true);
    _stagger(240, () => _showDescription = true);
    _stagger(400, () => _showButton = true);
  }

  void _stagger(int ms, VoidCallback apply) {
    Future.delayed(Duration(milliseconds: ms), () {
      if (!mounted) return;
      setState(apply);
    });
  }

  // MARK: - View
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF3FD168),
            Color(0xFF2BB554),
            Color(0xFF1B9A43),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            _buildSkipRow(),
            Expanded(child: _buildContent()),
            _buildButton(),
            const SizedBox(height: 20),
            _buildIndicator(),
            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }

  // MARK: - Subviews
  Widget _buildSkipRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CupertinoButton(
            onPressed: widget.onSkip,
            child: Text(
              widget.l10n.skip,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildIcon(),
          const SizedBox(height: 44),
          AnimatedSlide(
            offset: _showTitle ? Offset.zero : const Offset(0, 0.15),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
            child: AnimatedOpacity(
              opacity: _showTitle ? 1 : 0,
              duration: const Duration(milliseconds: 500),
              child: Text(
                widget.data.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 29,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          AnimatedSlide(
            offset: _showDescription ? Offset.zero : const Offset(0, 0.15),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
            child: AnimatedOpacity(
              opacity: _showDescription ? 1 : 0,
              duration: const Duration(milliseconds: 500),
              child: Text(
                widget.data.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withValues(alpha: 0.92),
                  height: 1.5,
                  letterSpacing: -0.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return AnimatedOpacity(
      opacity: _showIcon ? 1 : 0,
      duration: const Duration(milliseconds: 500),
      child: AnimatedSlide(
        offset: _showIcon ? Offset.zero : const Offset(0, 0.12),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
        child: ScaleTransition(
          scale: Tween<double>(begin: 1.0, end: 1.07).animate(
            CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 148,
                height: 148,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.22),
                  shape: BoxShape.circle,
                ),
              ),
              Icon(widget.data.icon, size: 58, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton() {
    return AnimatedOpacity(
      opacity: _showButton ? 1 : 0,
      duration: const Duration(milliseconds: 500),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: GestureDetector(
          onTapDown: (_) => setState(() => _isButtonPressed = true),
          onTapUp: (_) => setState(() => _isButtonPressed = false),
          onTapCancel: () => setState(() => _isButtonPressed = false),
          onTap: widget.onNext,
          child: AnimatedScale(
            scale: _isButtonPressed ? 0.95 : 1.0,
            duration: const Duration(milliseconds: 150),
            child: Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.l10n.next,
                    style: const TextStyle(
                      color: Color(0xFF1B9A43),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(
                    CupertinoIcons.chevron_right,
                    color: Color(0xFF1B9A43),
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.pageCount, (i) {
        final isActive = widget.pageIndex == i;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 26 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.white.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}

// MARK: - Model

class _OnboardingPageData {
  final IconData icon;
  final String title;
  final String description;

  _OnboardingPageData({
    required this.icon,
    required this.title,
    required this.description,
  });
}

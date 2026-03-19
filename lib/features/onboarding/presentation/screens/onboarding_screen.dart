import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animate_do/animate_do.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';

class OnboardingScreen extends StatefulWidget {
  final bool fromSettings;

  const OnboardingScreen({super.key, this.fromSettings = false});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _currentPage = 0;

  List<_OnboardingPage> _pages(BuildContext context) {
    final l = S.of(context)!;
    return [
      _OnboardingPage(
        icon: Iconsax.document_upload,
        gradient: const [Color(0xFF667eea), Color(0xFF764ba2)],
        title: l.onboardingUploadTitle,
        description: l.onboardingUploadDesc,
        screenshot: 'assets/images/onboarding/upload.png',
      ),
      _OnboardingPage(
        icon: Iconsax.magic_star,
        gradient: const [Color(0xFFf857a6), Color(0xFFff5858)],
        title: l.onboardingSummaryTitle,
        description: l.onboardingSummaryDesc,
        screenshot: 'assets/images/onboarding/summary.png',
      ),
      _OnboardingPage(
        icon: Iconsax.share,
        gradient: const [Color(0xFF4facfe), Color(0xFF00f2fe)],
        title: l.onboardingShareTitle,
        description: l.onboardingShareDesc,
        screenshot: 'assets/images/onboarding/share.png',
      ),
      _OnboardingPage(
        icon: Iconsax.translate,
        gradient: const [Color(0xFF43e97b), Color(0xFF38f9d7)],
        title: l.onboardingTranslateTitle,
        description: l.onboardingTranslateDesc,
        screenshot: 'assets/images/onboarding/translate.png',
      ),
      _OnboardingPage(
        icon: Iconsax.filter,
        gradient: const [Color(0xFFfa709a), Color(0xFFfee140)],
        title: l.onboardingHistoryTitle,
        description: l.onboardingHistoryDesc,
        screenshot: 'assets/images/onboarding/history.png',
      ),
      _OnboardingPage(
        icon: Iconsax.copy,
        gradient: const [Color(0xFF6366f1), Color(0xFFa78bfa)],
        title: l.onboardingCopyShareTitle,
        description: l.onboardingCopyShareDesc,
        screenshot: 'assets/images/onboarding/copy_share.png',
      ),
    ];
  }

  Future<void> _completeOnboarding() async {
    if (widget.fromSettings) {
      if (mounted) context.pop();
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.onboardingCompleteKey, true);
    if (mounted) context.go('/home');
  }

  void _next() {
    final pages = _pages(context);
    if (_currentPage < pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
      );
    } else {
      _completeOnboarding();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pages = _pages(context);
    final isLast = _currentPage == pages.length - 1;
    final l = S.of(context)!;

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: widget.fromSettings
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 8, left: 8, right: 16),
                child: widget.fromSettings
                    ? IconButton(
                        onPressed: () => context.pop(),
                        icon: Icon(
                          Icons.close,
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondary,
                        ),
                      )
                    : AnimatedOpacity(
                        opacity: isLast ? 0.0 : 1.0,
                        duration: const Duration(milliseconds: 200),
                        child: TextButton(
                          onPressed: isLast ? null : _completeOnboarding,
                          child: Text(
                            l.onboardingSkip,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: isDark
                                  ? AppColors.textSecondaryDark
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
              ),
            ),

            // Page content
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: pages.length,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemBuilder: (context, index) {
                  final page = pages[index];
                  return _buildPage(page, isDark);
                },
              ),
            ),

            // Bottom: dots + button
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
              child: Column(
                children: [
                  // Dot indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(pages.length, (i) {
                      final active = i == _currentPage;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: active ? 28 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: active
                              ? AppColors.primary
                              : (isDark
                                  ? AppColors.dividerDark
                                  : AppColors.divider),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 32),

                  // Action button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _next,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isLast
                                ? l.onboardingGetStarted
                                : l.onboardingNext,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (!isLast) ...[
                            const SizedBox(width: 8),
                            const Icon(Iconsax.arrow_right_3, size: 20),
                          ],
                        ],
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

  Widget _buildPage(_OnboardingPage page, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 8),
          FadeInUp(
            duration: const Duration(milliseconds: 400),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: page.gradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Icon(page.icon, size: 18, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    page.title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color:
                          isDark ? AppColors.textLight : AppColors.textPrimary,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          FadeInUp(
            delay: const Duration(milliseconds: 100),
            duration: const Duration(milliseconds: 400),
            child: Text(
              page.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 1.4,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: FadeIn(
              delay: const Duration(milliseconds: 200),
              duration: const Duration(milliseconds: 500),
              child: _buildPhoneMockup(page, isDark),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneMockup(_OnboardingPage page, bool isDark) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 450),
        child: AspectRatio(
          aspectRatio: 9 / 16,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.15)
                    : Colors.black.withValues(alpha: 0.12),
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: page.gradient.first.withValues(alpha: 0.15),
                  blurRadius: 30,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
                child: Image.asset(
                  page.screenshot,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            page.gradient.first.withValues(alpha: 0.08),
                            page.gradient.last.withValues(alpha: 0.08),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: page.gradient,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Icon(
                              page.icon,
                              size: 28,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            page.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? AppColors.textSecondaryDark
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OnboardingPage {
  final IconData icon;
  final List<Color> gradient;
  final String title;
  final String description;
  final String screenshot;

  const _OnboardingPage({
    required this.icon,
    required this.gradient,
    required this.title,
    required this.description,
    required this.screenshot,
  });
}

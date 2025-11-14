import 'package:flutter/material.dart';
import 'admin_login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  int stage = 1;
  late AnimationController _logoController;
  late Animation<double> _logoAnimation;
  bool showLoading = true;
  bool showWelcome = false;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _logoAnimation = CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeInOutCubic,
    );

    _startSplashSequence();
  }

  void _startSplashSequence() async {
    // Stage 1: Loading bar (2s)
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    setState(() {
      stage = 2;
      showLoading = false;
      showWelcome = true;
    });

    // Stage 2: Welcome message (2s)
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    // Start logo fly animation
    _logoController.forward();

    // Stage 3: Navigate to login
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const AdminLogin(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 800),
        ),
      );
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo with animation
            AnimatedBuilder(
              animation: _logoAnimation,
              builder: (context, child) {
                if (_logoAnimation.value > 0) {
                  return Transform.translate(
                    offset:
                        Offset(
                          -MediaQuery.of(context).size.width * 0.5 + 24,
                          -MediaQuery.of(context).size.height * 0.5 + 34,
                        ) *
                        _logoAnimation.value,
                    child: Transform.scale(
                      scale: 1 - (0.69 * _logoAnimation.value),
                      child: child,
                    ),
                  );
                }
                return child!;
              },
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('assets/logo.png', fit: BoxFit.cover),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Loading bar
            if (showLoading)
              TweenAnimationBuilder<double>(
                duration: const Duration(seconds: 2),
                tween: Tween(begin: 0.0, end: 1.0),
                builder: (context, value, child) {
                  return Container(
                    width: 320,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: value,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF950606), Color(0xFFa31414)],
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  );
                },
              ),

            // Welcome text
            if (showWelcome) ...[
              const SizedBox(height: 20),
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 1000),
                tween: Tween(begin: 0.0, end: 1.0),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 20 * (1 - value)),
                      child: child,
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Text(
                        'Welcome to our NeoBank!',
                        style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF950606),
                          letterSpacing: -0.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 5),
                      Text(
                        'NeoBank में आपका स्वागत है !',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF444444),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}


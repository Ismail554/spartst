
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spartst/features/onboarding/ui/screen/splash_screen.dart';

// ---------------------------------------------------------------------------
// Navigator Keys
// ---------------------------------------------------------------------------

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GlobalKey<NavigatorState> _shellHomeKey = GlobalKey<NavigatorState>(
  debugLabel: 'home',
);

// ---------------------------------------------------------------------------
// Router
// ---------------------------------------------------------------------------

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/splash',
  routes: [
    // ========
    // Splash
    // ========
    
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),

    // ================
    // Onboarding
    // ================


    // GoRoute(
    //   path: '/onboarding',
    //   builder: (context, state) => const Step1Onboarding(),
    //   routes: [
    //     GoRoute(
    //       path: 'step2',
    //       builder: (context, state) => const Step2Onboarding(),
    //     ),
    //     GoRoute(
    //       path: 'step3',
    //       builder: (context, state) => const Step3Onboarding(),
    //     ),
    //   ],
    // ),

  ],
);

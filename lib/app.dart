import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:mobile/calendar/calendar_screen.dart';
import 'package:mobile/chat/chat_screen.dart';
import 'package:mobile/forgot_password/forgot_password_screen.dart';
import 'package:mobile/infos/info_screen.dart';
import 'package:mobile/login/login_screen.dart';
import 'package:mobile/more/more_screen.dart';
import 'package:mobile/register/register_screen.dart';
import 'package:mobile/reset_password/reset_password_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final _router = GoRouter(
  initialLocation: '/login',
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/login',
      pageBuilder: (context, state) {
        return const NoTransitionPage(child: LoginScreen());
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/register',
      pageBuilder: (context, state) {
        return const NoTransitionPage(child: RegisterScreen());
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/forgot-password',
      pageBuilder: (context, state) {
        return const NoTransitionPage(child: ForgotPasswordScreen());
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/reset-password/:code',
      pageBuilder: (context, state) {
        return NoTransitionPage(
            child: ResetPasswordScreen(
          code: state.pathParameters['code'] ?? "",
        ));
      },
    ),
    ShellRoute(
        navigatorKey: _shellNavigatorKey,
        pageBuilder: (context, state, child) {
          return NoTransitionPage(
            child: NavigationBar(
              child: child,
            ),
          );
        },
        routes: [
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/',
            pageBuilder: (context, state) {
              return const NoTransitionPage(child: CalendarScreen());
            },
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/infos',
            pageBuilder: (context, state) {
              return const NoTransitionPage(child: InfoScreen());
            },
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/chat',
            pageBuilder: (context, state) {
              return const NoTransitionPage(child: ChatScreen());
            },
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/more',
            pageBuilder: (context, state) {
              return const NoTransitionPage(child: MoreCoursesScreen());
            },
          ),
        ])
  ],
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: true,
      title: "Studies",
      // routes: {
      //   '/calendar': (context) => const CalendarScreen(),
      // },
      // initialRoute: '/calendar',
      // home: const NavigationBar(),
      theme: ThemeData(
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            elevation: 0,
            selectedItemColor: Color.fromRGBO(109, 53, 172, 1),
            unselectedLabelStyle:
                TextStyle(color: Color.fromRGBO(190, 191, 190, 1)),
            unselectedItemColor: Color.fromRGBO(190, 191, 190, 1),
            unselectedIconTheme:
                IconThemeData(color: Color.fromRGBO(190, 191, 190, 1)),
            selectedIconTheme:
                IconThemeData(color: Color.fromRGBO(109, 53, 172, 1))),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Colors.amber,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class NavigationBar extends StatefulWidget {
  const NavigationBar({super.key, required this.child});

  final Widget child;

  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int _selectedIndex = 0;

  static const List<MyCustomBottomNavBarItem> tabs = [
    MyCustomBottomNavBarItem(
      icon: HeroIcon(HeroIcons.calendarDays),
      label: 'Calendar',
      initialLocation: '/',
    ),
    MyCustomBottomNavBarItem(
      icon: HeroIcon(HeroIcons.megaphone),
      label: 'Infos',
      initialLocation: '/infos',
    ),
    MyCustomBottomNavBarItem(
      icon: HeroIcon(HeroIcons.chatBubbleBottomCenterText),
      label: 'Chat',
      initialLocation: '/chat',
    ),
    MyCustomBottomNavBarItem(
      icon: HeroIcon(HeroIcons.ellipsisHorizontal),
      label: 'Plus',
      initialLocation: '/more',
    ),
  ];

  void _goOtherTab(BuildContext context, int index) {
    if (index == _selectedIndex) return;
    GoRouter router = GoRouter.of(context);
    String location = tabs[index].initialLocation;

    setState(() {
      _selectedIndex = index;
    });
    // if (index == 3) {
    //   context.push('/login');
    // } else {
    router.go(location);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: widget.child),
      bottomNavigationBar: BottomNavigationBar(
          items: tabs,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          currentIndex: _selectedIndex,
          onTap: (index) {
            _goOtherTab(context, index);
          }),
    );
  }
}

class MyCustomBottomNavBarItem extends BottomNavigationBarItem {
  final String initialLocation;

  const MyCustomBottomNavBarItem(
      {required this.initialLocation, required Widget icon, String? label})
      : super(icon: icon, label: label);
}

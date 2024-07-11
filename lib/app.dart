import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:mobile/attendances/attendances_screen.dart';
import 'package:mobile/calendar/calendar_screen.dart';
import 'package:mobile/chat/chat_screen.dart';
import 'package:mobile/forgot_password/forgot_password_screen.dart';
import 'package:mobile/chat/message_screen.dart';
import 'package:mobile/documents/documents_screen.dart';
import 'package:mobile/infos/info_screen.dart';
import 'package:mobile/invitation_register/invitation_register_screen.dart';
import 'package:mobile/login/blocs/auth_bloc.dart';
import 'package:mobile/login/blocs/auth_event.dart';
import 'package:mobile/login/login_screen.dart';
import 'package:mobile/login/services/auth_service.dart';
import 'package:mobile/more/more_screen.dart';
import 'package:mobile/register/register_screen.dart';
import 'package:mobile/reset_password/reset_password_screen.dart';
import 'package:mobile/profile/profile_screen.dart';
import 'package:mobile/projects/projects_screen.dart';
import 'package:mobile/schedule/schedule_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final _router = GoRouter(
  initialLocation: '/login',
  navigatorKey: _rootNavigatorKey,
  redirect: (context, state) async {
    final jwt = await AuthService.init();
    if (state.fullPath == '/login' && jwt != null) {
      return '/';
    }
  },
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
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/invite/:code',
      pageBuilder: (context, state) {
        return NoTransitionPage(
            child: InvitationRegisterScreen(
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
            path: '/calendar/:id',
            pageBuilder: (context, state) {
              return NoTransitionPage(
                  child: ScheduleScreen(
                id: int.parse(state.pathParameters['id'] ?? '0'),
              ));
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
            path: '/chat/message',
            pageBuilder: (context, state) {
              return const NoTransitionPage(child: MessageScreen());
            },
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/more',
            pageBuilder: (context, state) {
              return const NoTransitionPage(child: ProfileScreen());
            },
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/documents',
            pageBuilder: (context, state) {
              return const NoTransitionPage(child: DocumentsScreen());
            },
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/courses',
            pageBuilder: (context, state) {
              return const NoTransitionPage(child: MoreCoursesScreen());
            },
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/attendances',
            pageBuilder: (context, state) {
              return const NoTransitionPage(child: AttendancesScreen());
            },
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/profile',
            pageBuilder: (context, state) {
              return const NoTransitionPage(child: ProfileScreen());
            },
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/projects',
            pageBuilder: (context, state) {
              return const NoTransitionPage(child: ProjectsScreen());
            },
          ),
        ]),
  ],
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc()..add(AuthInit()),
      child: MaterialApp.router(
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
      label: 'Calendrier',
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
    if (index == _selectedIndex) {
      if (index == 3) {
        _showBottomSheet(context);
      }
      return;
    }

    GoRouter router = GoRouter.of(context);
    String location = tabs[index].initialLocation;

    setState(() {
      _selectedIndex = index;
    });

    if (index == 3) {
      _showBottomSheet(context);
    } else {
      router.go(location);
    }
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const HeroIcon(
                  HeroIcons.folderOpen,
                  color: Color.fromRGBO(247, 159, 2, 1),
                ),
                title: const Text(
                  "Documents",
                  style: TextStyle(color: Color.fromRGBO(72, 2, 151, 1)),
                ),
                onTap: () {
                  Navigator.pop(context);
                  GoRouter.of(context).go('/documents');
                },
              ),
              ListTile(
                leading: const HeroIcon(
                  HeroIcons.bookOpen,
                  color: Color.fromRGBO(247, 159, 2, 1),
                ),
                title: const Text(
                  "Matières",
                  style: TextStyle(color: Color.fromRGBO(72, 2, 151, 1)),
                ),
                onTap: () {
                  Navigator.pop(context);
                  GoRouter.of(context).go('/courses');
                },
              ),
              ListTile(
                leading: const HeroIcon(
                  HeroIcons.tag,
                  color: Color.fromRGBO(247, 159, 2, 1),
                ),
                title: const Text(
                  "Mes absences",
                  style: TextStyle(color: Color.fromRGBO(72, 2, 151, 1)),
                ),
                onTap: () {
                  Navigator.pop(context);
                  GoRouter.of(context).go('/attendances');
                },
              ),
              ListTile(
                leading: const HeroIcon(
                  HeroIcons.academicCap,
                  color: Color.fromRGBO(247, 159, 2, 1),
                ),
                title: const Text(
                  "Projets",
                  style: TextStyle(color: Color.fromRGBO(72, 2, 151, 1)),
                ),
                onTap: () {
                  Navigator.pop(context);
                  GoRouter.of(context).go('/projects');
                },
              ),
              ListTile(
                leading: const HeroIcon(
                  HeroIcons.userCircle,
                  color: Color.fromRGBO(247, 159, 2, 1),
                ),
                title: const Text(
                  "Profil",
                  style: TextStyle(color: Color.fromRGBO(72, 2, 151, 1)),
                ),
                onTap: () {
                  Navigator.pop(context);
                  GoRouter.of(context).go('/profile');
                },
              ),
              ListTile(
                leading: const HeroIcon(
                  HeroIcons.arrowLeftStartOnRectangle,
                  color: Color.fromRGBO(247, 159, 2, 1),
                ),
                title: const Text(
                  "Déconnexion",
                  style: TextStyle(color: Color.fromRGBO(72, 2, 151, 1)),
                ),
                onTap: () {
                  Navigator.pop(context);
                  GoRouter.of(context).go('/login');
                },
              ),
            ],
          ),
        );
      },
    );
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
        },
      ),
    );
  }
}

class MyCustomBottomNavBarItem extends BottomNavigationBarItem {
  final String initialLocation;

  const MyCustomBottomNavBarItem({
    required this.initialLocation,
    required Widget icon,
    String? label,
  }) : super(icon: icon, label: label);
}

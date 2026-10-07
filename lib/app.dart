import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/di/injection.dart';
import 'features/waiting_list/presentation/pages/waiting_list_page.dart';
import 'features/waiting_list/presentation/providers/waiting_provider.dart';

class App extends StatelessWidget {
  final AppDependencies dependencies;

  const App({
    super.key,
    required this.dependencies,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => WaitingProvider(
            addGroup: dependencies.addGroup,
            getWaitingGroups: dependencies.getWaitingGroups,
            removeGroup: dependencies.removeGroup,
            markAsSeated: dependencies.markAsSeated,
            getGroupsAhead: dependencies.getGroupsAhead,
          )..loadGroups(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Restaurant Waitlist',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const WaitingListPage(),
      ),
    );
  }
}
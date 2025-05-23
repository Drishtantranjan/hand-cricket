import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_cricket/bloc/game_bloc.dart';
import 'package:hand_cricket/presentation/screens/game_screen.dart';
import 'package:hand_cricket/repositories/game_repositories.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await RiveFile.initialize();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );

  runApp(
    MultiProvider(
      providers: [
        Provider<GameRepository>(
          create: (_) => GameRepository(),
        ),
        Provider<GameBloc>(
          create: (context) => GameBloc(context.read<GameRepository>()),
          dispose: (_, bloc) => bloc.close(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hand Cricket',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BlocProvider(
          create: (_) => GameBloc(GameRepository()),
          child: const GameScreen(),
        ));
  }
}

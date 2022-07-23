import 'package:breaking_bad/business_logic/cubit/cubit.dart';
import 'package:breaking_bad/data/models/characters.dart';
import 'package:breaking_bad/data/repositories/chraacter_repository.dart';
import 'package:breaking_bad/data/web_services/character_web_services.dart';
import 'package:breaking_bad/presentation/screens/characters_screen.dart';
import 'package:breaking_bad/presentation/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants.dart';

class AppRouter {
  late CharacterRepository characterRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    characterRepository = CharacterRepository(CharacterWebServices());
    charactersCubit = CharactersCubit(characterRepository);
  }

  Route<dynamic>? onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => charactersCubit,
            child: const CharactersScreen(),
          ),
        );

      case detailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => CharactersCubit(characterRepository),
            child: DetailsScreen(
              character: character,
            ),
          ),
        );
    }
    return null;
  }
}

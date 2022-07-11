import 'package:breaking_bad/presentation/screens/characters_screen.dart';
import 'package:breaking_bad/presentation/screens/details_screen.dart';
import 'package:breaking_bad/utilities/routes.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerate(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.charactersScreen:
      return MaterialPageRoute(builder: (_) => const CharactersScreen());

    case AppRoutes.detailsScreen:
      return MaterialPageRoute(builder: (_) => const DetailsScreen());

    default:
      return MaterialPageRoute(builder: (_) => const CharactersScreen());
  }
}

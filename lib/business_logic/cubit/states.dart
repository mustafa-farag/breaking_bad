import '../../data/models/characters.dart';

abstract class AppStates {}

class InitialState extends AppStates {}

class CharacterLoadedState extends AppStates {
  final List<Character> characters;

  CharacterLoadedState(this.characters);
}

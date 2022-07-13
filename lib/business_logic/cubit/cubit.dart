import 'package:breaking_bad/business_logic/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/characters.dart';
import '../../data/repositories/chraacter_repository.dart';

class CharactersCubit extends Cubit<AppStates> {
  final CharacterRepository characterRepository;
  late List<Character> characters;

  CharactersCubit(this.characterRepository) : super(InitialState());

  List<Character> getAllCharacters() {
    characterRepository.getAllCharacters().then((characters) {
      emit(CharacterLoadedState(characters));
      this.characters = characters;
    });
    return characters;
  }
}

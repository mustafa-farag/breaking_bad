import 'package:breaking_bad/business_logic/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/characters.dart';
import '../../data/repositories/chraacter_repository.dart';

class CharactersCubit extends Cubit<AppStates> {
  final CharacterRepository characterRepository;
  List<Character> characters = [];
  List<Character> searchedCharacters = [];
  bool isSearch = false;

  CharactersCubit(this.characterRepository) : super(InitialState());
  static CharactersCubit get(context) => BlocProvider.of(context);

  List<Character> getAllCharacters() {
    characterRepository.getAllCharacters().then((characters) {
      emit(CharacterLoadedState(characters));
      this.characters = characters;
    });
    return characters;
  }

  void getQuote(String charName) {
    characterRepository.getQuote(charName).then((quote) {
      emit(QuoteLoadedState(quote));
    });
  }

  void getSearchedCharacters(String text) {
    searchedCharacters = characters
        .where((character) => character.name.toLowerCase().startsWith(text))
        .toList();
    emit(GetSearchedCharactersState(searchedCharacters));
  }

  void setDefaultList(){
    emit(CharacterLoadedState(characters));
  }

}

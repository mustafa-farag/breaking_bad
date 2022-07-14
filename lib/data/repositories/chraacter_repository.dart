import 'package:breaking_bad/data/web_services/character_web_services.dart';
import '../models/characters.dart';

class CharacterRepository{
  final CharacterWebServices characterWebServices;

  CharacterRepository(this.characterWebServices);

  Future<List<Character>> getAllCharacters() async{
    final characters = await characterWebServices.getAllCharacters();
    return characters.map((character) => Character.fromJson(character)).toList();
  }
}
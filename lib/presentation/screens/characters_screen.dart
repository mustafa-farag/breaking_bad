import 'package:breaking_bad/business_logic/cubit/cubit.dart';
import 'package:breaking_bad/data/models/characters.dart';
import 'package:breaking_bad/presentation/widgets/grid_item.dart';
import 'package:breaking_bad/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubit/states.dart';
import '../../utilities/constants.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  final controller = TextEditingController();

  Widget _buildBlocWidget() {
    return BlocBuilder<CharactersCubit, AppStates>(builder: (context, state) {
      if (state is CharacterLoadedState) {
        return _buildCharacterScreen(context, state.characters);
      } else if (state is GetSearchedCharactersState) {
        return _buildCharacterScreen(context, state.searchedCharacters);
      }
      return const Center(
        child: CircularProgressIndicator(
          color: MyColors.appBarColor,
        ),
      );
    });
  }

  Widget _buildCharacterScreen(context, List<Character> allCharacters) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (_, index) => InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, detailsScreen,
                        arguments: allCharacters[index]);
                  },
                  child: GridItem(character: allCharacters[index])),
              itemCount: allCharacters.length,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
          hintText: 'find a character ...',
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
          )),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
      onChanged: (text) =>
          CharactersCubit.get(context).getSearchedCharacters(text),
    );
  }

  List<Widget> _buildAppBarActions() {
    if (CharactersCubit.get(context).isSearch == true) {
      return [
        IconButton(
            onPressed: () {
              CharactersCubit.get(context).setDefaultList();
              setState(() {
                controller.clear();
                Navigator.pop(context);
              });
            },
            icon: const Icon(Icons.close))
      ];
    } else {
      return [
        IconButton(
            onPressed: () {
              ModalRoute.of(context)!.addLocalHistoryEntry(
                  LocalHistoryEntry(onRemove: _stopSearch));

              setState(() {
                CharactersCubit.get(context).isSearch = true;
              });
            },
            icon: const Icon(Icons.search))
      ];
    }
  }

  void _stopSearch() {
    CharactersCubit.get(context).setDefaultList();
    setState(() {
      controller.clear();
      CharactersCubit.get(context).isSearch = false;
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CharactersCubit.get(context).isSearch == true
            ? _buildSearchField()
            : const Text("Characters"),
        actions: _buildAppBarActions(),
      ),
      body: _buildBlocWidget(),
    );
  }
}

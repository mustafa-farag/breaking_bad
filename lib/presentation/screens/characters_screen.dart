import 'package:breaking_bad/business_logic/cubit/cubit.dart';
import 'package:breaking_bad/data/models/characters.dart';
import 'package:breaking_bad/presentation/widgets/grid_item.dart';
import 'package:breaking_bad/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubit/states.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  Widget _buildBlocWidget() {
    return BlocBuilder<CharactersCubit, AppStates>(builder: (context, state) {
      if (state is CharacterLoadedState) {
        return _buildCharacterScreen(context, state.characters);
      }
      return const Center(
        child: CircularProgressIndicator(color: MyColors.appBarColor,),
      );
    });
  }

  Widget _buildCharacterScreen(context, List<Character> allCharacters) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 6,
              ),
              itemBuilder: (_, index) =>
                  GridItem(character: allCharacters[index]),
              itemCount: allCharacters.length,
            )
          ],
        ),
      ),
    );
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
        title: const Text('Characters'),
      ),
      body: _buildBlocWidget(),
    );
  }
}

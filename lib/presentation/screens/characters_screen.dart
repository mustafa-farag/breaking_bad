import 'package:breaking_bad/business_logic/cubit/cubit.dart';
import 'package:breaking_bad/data/models/characters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubit/states.dart';

class CharactersScreen extends StatelessWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  Widget _buildBlocWidget() {
    return BlocBuilder<CharactersCubit, AppStates>(builder: (context, state) {
      if (state is CharacterLoadedState) {
        return _buildCharacterScreen(context);
      }
      return _showLoadingIndicator();
    });
  }

  Widget _showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildCharacterScreen(context) {
    final cubit = CharactersCubit.get(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
            ),
            itemBuilder: (_, index) => _buildGridItem(cubit.characters[index]),
            itemCount: cubit.characters.length,
          )
        ],
      ),
    );
  }

  Widget _buildGridItem(Character character) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          FadeInImage.assetNetwork(
              placeholder: 'assets/images/loading.gif',
              placeholderScale: 1.2,
              placeholderFit: BoxFit.none,
              image: character.image,
              fit: BoxFit.cover,
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  "assets/images/something-went-wrong.gif",
                  scale: 2,
                  fit: BoxFit.cover,
                );
              }),
          Container(
            width: double.infinity,
            color: Colors.black.withOpacity(0.2),
            child: Text(
              character.actorName,
              style: const TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
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

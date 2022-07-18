import 'package:breaking_bad/data/models/characters.dart';
import 'package:breaking_bad/utilities/colors.dart';
import 'package:flutter/material.dart';

class GridItem extends StatelessWidget {
  final Character character;
  const GridItem({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: MyColors.myWhite,
        )
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          FadeInImage.assetNetwork(
            width: double.infinity,
              height: double.infinity,
              placeholder: 'assets/images/loading.gif',
              image: character.image,
              fit: BoxFit.cover,
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  "assets/images/something-went-wrong.gif",
                  scale: 2,
                  height: double.infinity,
                  fit: BoxFit.cover,
                );
              }),
          Container(
            width: double.infinity,
            height: 30,
            color: Colors.black.withOpacity(0.5),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                character.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}

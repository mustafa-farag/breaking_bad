import 'package:breaking_bad/utilities/colors.dart';
import 'package:flutter/material.dart';

import '../../data/models/characters.dart';

class DetailsScreen extends StatelessWidget {
  final Character character;

  const DetailsScreen({Key? key, required this.character}) : super(key: key);

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.appBarColor,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(character.nickName),
        background: Hero(
            tag: character.charId,
            child: Image.network(
              character.image,
              fit: BoxFit.cover,
            )),
      ),
    );
  }

  Widget _buildCharacterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
              text: title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
          TextSpan(
              text: value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              )),
        ],
      ),
    );
  }

  Widget _buildDivider(double endIndent) {
    return Divider(
      height: 25,
      endIndent: endIndent,
      color: MyColors.appBarColor,
      thickness: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildSliverAppBar(),
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCharacterInfo('Job : ', character.jobs.join(" / ")),
                  _buildDivider(290),
                  _buildCharacterInfo(
                      'Appeared in : ', character.categoryForTwoSeries),
                  _buildDivider(220),
                  _buildCharacterInfo(
                      'Status : ', character.statusIfDeadOrAlive),
                  _buildDivider(265),
                  if (character.appearanceOfSeasons.isNotEmpty)
                    _buildCharacterInfo('Seasons : ',
                        character.appearanceOfSeasons.join(" / ")),
                  if (character.appearanceOfSeasons.isNotEmpty)
                    _buildDivider(250),
                  if (character.betterCallSaulAppearance.isNotEmpty)
                    _buildCharacterInfo('Better Call Saul Seasons : ',
                        character.betterCallSaulAppearance.join(" / ")),
                  if (character.betterCallSaulAppearance.isNotEmpty)
                    _buildDivider(120),
                  _buildCharacterInfo('Actor/Actress : ', character.actorName),
                  _buildDivider(210),
                ],
              ),
            ),
            const SizedBox(
              height: 400,
            )
          ])),
        ],
      ),
    );
  }
}

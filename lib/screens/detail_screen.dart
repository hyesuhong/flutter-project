import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/toon_detail_model.dart';
import 'package:flutter_application_1/models/toon_episode_model.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:flutter_application_1/styles/font.dart';
import 'package:flutter_application_1/widgets/episode_item.dart';
import 'package:flutter_application_1/widgets/header_bar.dart';
import 'package:flutter_application_1/widgets/thumbnail.dart';

class DetailScreen extends StatefulWidget {
  final String id, title, thumb;
  const DetailScreen({
    super.key,
    required this.id,
    required this.title,
    required this.thumb,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<ToonDetailModel> toon;
  late Future<List<ToonEpisodeModel>> episodes;

  @override
  void initState() {
    super.initState();

    toon = ApiService.getToonById(widget.id);
    episodes = ApiService.getLatestEpisodesById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(
        title: widget.title,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Thumbnail(
                  id: widget.id,
                  thumbUrl: widget.thumb,
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            FutureBuilder(
              future: toon,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Column(
                      children: [
                        Text(
                          snapshot.data!.about,
                          style: TextStyle(
                            fontSize: 14,
                            fontVariations: [NotoSansKRWeight.w300],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              '장르',
                              style: TextStyle(
                                fontVariations: [NotoSansKRWeight.w300],
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Text.rich(
                              TextSpan(
                                text: '',
                                children:
                                    buildGenresWidget(snapshot.data!.genre),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '연령',
                              style: TextStyle(
                                fontVariations: [NotoSansKRWeight.w300],
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              snapshot.data!.age,
                              style: TextStyle(
                                fontVariations: [NotoSansKRWeight.w300],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                }
                return Text('...');
              },
            ),
            SizedBox(
              height: 24,
            ),
            FutureBuilder(
              future: episodes,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return buildEpisodesList(snapshot.data!, widget.id);
                  // return Column(
                  //   children: [
                  //     for (var episode in snapshot.data!)
                  //       Text('${episode.title} ${episode.rating}'),
                  //   ],
                  // );
                }
                return Text('...');
              },
            )
          ],
        ),
      ),
    );
  }
}

List<TextSpan> buildGenresWidget(List<String> genres) {
  List<TextSpan> genreText = [];
  final int totalGenres = genres.length;

  for (int i = 0; i < totalGenres; i++) {
    TextSpan genre = TextSpan(
      text: genres[i],
      style: TextStyle(
        fontVariations: [NotoSansKRWeight.w300],
      ),
    );

    if (i + 1 == totalGenres) {
      genreText.add(genre);
    } else {
      TextSpan seperator = TextSpan(
        text: ' | ',
        style: TextStyle(color: Colors.grey),
      );
      genreText.addAll([
        genre,
        seperator,
      ]);
    }
  }

  return genreText;
}

Widget buildEpisodesList(List<ToonEpisodeModel> episodes, String toonId) {
  return ListView.separated(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: episodes.length,
    itemBuilder: (context, index) {
      return EpisodeItem(
        episode: episodes[index],
        toonId: toonId,
      );
    },
    separatorBuilder: (context, index) {
      return SizedBox(height: 10);
    },
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/toon_episode_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

class EpisodeItem extends StatelessWidget {
  final ToonEpisodeModel episode;
  final String toonId;

  const EpisodeItem({
    super.key,
    required this.episode,
    required this.toonId,
  });

  void onTap() async {
    await launchUrlString(
        'https://comic.naver.com/webtoon/detail?titleId=$toonId&no=${episode.id}');
    print('tap');
  }

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      highlightShape: BoxShape.rectangle,
      containedInkWell: true,
      child: Container(
        height: 64,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: InkWell(
          child: Row(
            children: [
              SizedBox(
                width: 80,
                child: Image.network(
                  episode.thumb,
                  headers: const {
                    "User-Agent":
                        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                  },
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      episode.title,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(episode.date),
                  ],
                ),
              ),
              SizedBox(
                width: 40,
                height: 40,
                child: Icon(
                  Icons.chevron_right,
                  color: Colors.grey[500],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

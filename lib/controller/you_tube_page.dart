import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YouTubePage {
  static Future<List<VideoQalityUrls>?>  getYoutubeUrls(String youtubeIdOrUrl, {
    bool live = false,
  }) {

    return VideoApis.getYoutubeVideoQualityUrls(youtubeIdOrUrl, live);
  }
}

class VideoQalityUrls {
  int quality;
  String url;

  VideoQalityUrls({
    required this.quality,
    required this.url,
  });

  @override
  String toString() => 'VideoQalityUrls(quality: $quality, urls: $url)';
}

String podErrorString(String val) {
  return '*\n------error------\n\n$val\n\n------end------\n*';
}

class VideoApis {
  static Future<List<VideoQalityUrls>?> getYoutubeVideoQualityUrls(
      String youtubeIdOrUrl,
      bool live,) async {
    try {
      final yt = YoutubeExplode();
      final urls = <VideoQalityUrls>[];
      if (live) {
        final url = await yt.videos.streamsClient.getHttpLiveStreamUrl(
          VideoId(youtubeIdOrUrl),
        );
        urls.add(
          VideoQalityUrls(
            quality: 720,
            url: url,
          ),
        );
      } else {
        final manifest =
        await yt.videos.streamsClient.getManifest(youtubeIdOrUrl);
        urls.addAll(
          manifest.muxed.map(
                (element) =>
                VideoQalityUrls(
                  quality: int.parse(element.qualityLabel.split('p')[0]),
                  url: element.url.toString(),
                ),
          ),
        );
      }
      // Close the YoutubeExplode's http client.
      yt.close();
      return urls;
    } catch (error) {
      if (error.toString().contains('XMLHttpRequest')) {
        log(
          podErrorString(
            '(INFO) To play youtube video in WEB, Please enable CORS in your browser',
          ),
        );
      }

    }
  }
}

external void log(String message, {
  DateTime? time,
  int? sequenceNumber,
  int level = 0,
  String name = '',
  Object? error,
  StackTrace? stackTrace,
});


import 'dart:convert';
import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:eh_redux/models/content_warning_exception.dart';
import 'package:eh_redux/models/gallery.dart';
import 'package:eh_redux/models/image.dart';
import 'package:eh_redux/models/request_exception.dart';
import 'package:eh_redux/repositories/ehentai_client.dart';
import 'package:eh_redux/stores/session.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';

import '../test_utils/http.dart';
import '../test_utils/io.dart';

class MockSessionStore extends Mock implements SessionStore {}

void main() {
  MockHttpClient httpClient;
  EHentaiClient client;

  setUp(() {
    httpClient = MockHttpClient();
    client = EHentaiClient(
      httpClient: httpClient.client,
      sessionStore: MockSessionStore(),
    );
  });

  group('getGalleryIds', () {
    group('when server respond 200', () {
      setUp(() async {
        httpClient.handle(
          request: ExpectedRequest(url: Uri.parse('${EHentaiClient.baseUrl}/')),
          response: Response(
            await readProjectFileAsString(
                'test/repositories/fixtures/index.html'),
            HttpStatus.ok,
            headers: {
              HttpHeaders.contentTypeHeader: MockHttpClient.htmlContentType,
            },
          ),
        );
      });

      test('should return gallery ids', () async {
        final actual = await client.getGalleryIds('/');
        expect(
            actual,
            equals(<GalleryId>[
              const GalleryId(id: 1663094, token: '8a3917594c'),
              const GalleryId(id: 1663074, token: 'b09d849b4a'),
              const GalleryId(id: 1663093, token: '5f5ce4d611'),
              const GalleryId(id: 1651072, token: '185e216043'),
              const GalleryId(id: 1663077, token: '241dc40744'),
              const GalleryId(id: 1663095, token: 'a9858b9f82'),
              const GalleryId(id: 1663068, token: '93ad902d30'),
              const GalleryId(id: 1663088, token: '34e8a96a3f'),
              const GalleryId(id: 1663067, token: 'a3becc14c0'),
              const GalleryId(id: 1663091, token: '560510958f'),
              const GalleryId(id: 1663089, token: '37ecd23bcb'),
              const GalleryId(id: 1663092, token: 'cdab917112'),
              const GalleryId(id: 1663090, token: 'f77cd8f436'),
              const GalleryId(id: 1662987, token: '9050776675'),
              const GalleryId(id: 1663086, token: 'bc91e854cd'),
              const GalleryId(id: 1663087, token: '14a7bacd51'),
              const GalleryId(id: 1663084, token: '6581dc69fa'),
              const GalleryId(id: 1663085, token: 'eb9998e0e4'),
              const GalleryId(id: 1663064, token: '7325cce288'),
              const GalleryId(id: 1663079, token: '1cd08c8705'),
              const GalleryId(id: 1663082, token: '2b5fdec9b0'),
              const GalleryId(id: 1663076, token: 'c4210d8673'),
              const GalleryId(id: 1659335, token: 'e30c2d70f3'),
              const GalleryId(id: 1663066, token: 'ca8c161486'),
              const GalleryId(id: 1662455, token: 'd0af5dc691'),
            ]));
      });
    });

    group('when server respond 404', () {
      setUp(() {
        httpClient.handle(
          request: ExpectedRequest(url: Uri.parse('${EHentaiClient.baseUrl}/')),
          response: Response('', HttpStatus.notFound),
        );
      });

      test('should throw an exception', () async {
        expect(client.getGalleryIds('/'), throwsRequestException);
      });
    });

    group('when search no hit', () {
      setUp(() async {
        httpClient.handle(
          request: ExpectedRequest(url: Uri.parse('${EHentaiClient.baseUrl}/')),
          response: Response(
            await readProjectFileAsString(
                'test/repositories/fixtures/search_no_hit.html'),
            HttpStatus.ok,
            headers: {
              HttpHeaders.contentTypeHeader: MockHttpClient.htmlContentType,
            },
          ),
        );
      });

      test('should return an empty array', () async {
        expect(await client.getGalleryIds('/'), isEmpty);
      });
    });
  });

  group('getGalleriesData', () {
    group('when server respond 200', () {
      setUp(() async {
        httpClient.handle(
          request: ExpectedRequest(
            url: Uri.parse(EHentaiClient.apiUrl),
            method: 'POST',
            body: jsonEncode({
              'method': 'gdata',
              'gidlist': [
                [1663099, 'd76bb5e89a'],
                [1663615, 'acf3f209ac'],
              ],
              'namespace': '1',
            }),
          ),
          response: Response(
            await readProjectFileAsString(
                'test/repositories/fixtures/gallery_list.json'),
            HttpStatus.ok,
            headers: {
              HttpHeaders.contentTypeHeader: MockHttpClient.jsonContentType,
            },
          ),
        );
      });

      test('should return galleries', () async {
        final actual = await client.getGalleriesData([
          const GalleryId(id: 1663099, token: 'd76bb5e89a'),
          const GalleryId(id: 1663615, token: 'acf3f209ac')
        ]);
        expect(
            actual,
            equals(<Gallery>[
              Gallery(
                id: const GalleryId(id: 1663099, token: 'd76bb5e89a'),
                title:
                    '[PigPanPan (Ikura Nagisa)] 12 Seiza yandere kokuhaku [Chinese] [绅士仓库汉化] [Digital]',
                titleJpn: '[PigPanPan (伊倉ナギサ)] 12星座ヤンデレ コクハク [中国翻訳] [DL版]',
                category: 'Non-H',
                thumbnail:
                    'https://ehgt.org/f5/b6/f5b64c9c924fb032ce1e21c383c9db5edbaedc62-3865428-2508-3541-jpg_l.jpg',
                uploader: 'BlossomPlus',
                fileCount: 26,
                fileSize: 79698072,
                expunged: false,
                rating: 4.65,
                tags: BuiltList<GalleryTag>.of([
                  const GalleryTag(namespace: 'language', tag: 'chinese'),
                  const GalleryTag(namespace: 'language', tag: 'translated'),
                  const GalleryTag(namespace: 'group', tag: 'pigpanpan'),
                  const GalleryTag(namespace: 'artist', tag: 'ikura nagisa'),
                  const GalleryTag(namespace: '', tag: 'full color'),
                ]),
                posted: DateTime.parse('2020-06-17 13:45:15Z'),
              ),
              Gallery(
                id: const GalleryId(id: 1663615, token: 'acf3f209ac'),
                title:
                    '[Sagamani. (Sagami Inumaru)] MY TRUE FEELINGS ARE A SECRET (Kill Me Baby) [Chinese] [后悔的神官个人汉化] [Digital]',
                titleJpn:
                    '[サガマニ。 (佐上犬丸)] MY TRUE FEELINGS ARE A SECRET (キルミーベイベー) [中国翻訳] [DL版]',
                category: 'Non-H',
                thumbnail:
                    'https://ehgt.org/b1/9c/b19cf368b5863145308c1c04bcb1d3e4829f1b70-243924-740-1035-jpg_l.jpg',
                uploader: '乐·黑',
                fileCount: 16,
                fileSize: 5450803,
                expunged: false,
                rating: 4.5,
                tags: BuiltList<GalleryTag>.of([
                  const GalleryTag(namespace: 'language', tag: 'chinese'),
                  const GalleryTag(namespace: 'language', tag: 'translated'),
                  const GalleryTag(namespace: 'parody', tag: 'kill me baby'),
                  const GalleryTag(namespace: 'character', tag: 'sonya'),
                  const GalleryTag(namespace: 'character', tag: 'yasuna oribe'),
                  const GalleryTag(namespace: 'group', tag: 'sagamani'),
                  const GalleryTag(namespace: 'artist', tag: 'sagami inumaru'),
                  const GalleryTag(namespace: 'female', tag: 'females only'),
                  const GalleryTag(
                      namespace: 'female', tag: 'schoolgirl uniform'),
                  const GalleryTag(namespace: 'female', tag: 'twintails'),
                ]),
                posted: DateTime.parse('2020-06-18 08:37:04Z'),
              )
            ]));
      });
    });

    group('when server respond 404', () {
      setUp(() {
        httpClient.handle(
          request: ExpectedRequest(
            url: Uri.parse(EHentaiClient.apiUrl),
            method: 'POST',
          ),
          response: Response('', HttpStatus.notFound),
        );
      });

      test('should throw an exception', () async {
        expect(
            client.getGalleriesData([
              const GalleryId(id: 1663099, token: 'd76bb5e89a'),
            ]),
            throwsRequestException);
      });
    });

    group('when gallery token is incorrect', () {
      setUp(() async {
        httpClient.handle(
          request: ExpectedRequest(
            url: Uri.parse(EHentaiClient.apiUrl),
            method: 'POST',
          ),
          response: Response(
            await readProjectFileAsString(
                'test/repositories/fixtures/gallery_list_incorrect_token.json'),
            HttpStatus.ok,
            headers: {
              HttpHeaders.contentTypeHeader: MockHttpClient.jsonContentType,
            },
          ),
        );
      });

      test('should return an empty array', () async {
        final actual = await client.getGalleriesData([
          const GalleryId(id: 1663099, token: 'd76bb5e89a'),
        ]);
        expect(actual, isEmpty);
      });
    });

    group('when gallery not found', () {
      setUp(() async {
        httpClient.handle(
          request: ExpectedRequest(
            url: Uri.parse(EHentaiClient.apiUrl),
            method: 'POST',
          ),
          response: Response(
            await readProjectFileAsString(
                'test/repositories/fixtures/gallery_list_not_found.json'),
            HttpStatus.ok,
            headers: {
              HttpHeaders.contentTypeHeader: MockHttpClient.jsonContentType,
            },
          ),
        );
      });

      test('should return an empty array', () async {
        final actual = await client.getGalleriesData([
          const GalleryId(id: 1663099, token: 'd76bb5e89a'),
        ]);
        expect(actual, isEmpty);
      });
    });
  });

  group('getGalleryDetails', () {
    const galleryId = GalleryId(id: 1664213, token: '283b2421c3');

    group('when server respond 200', () {
      setUp(() async {
        httpClient.handle(
          request: ExpectedRequest(
            url: Uri.parse(
                '${EHentaiClient.baseUrl}/g/${galleryId.id}/${galleryId.token}'),
          ),
          response: Response(
            await readProjectFileAsString(
                'test/repositories/fixtures/gallery.html'),
            HttpStatus.ok,
            headers: {
              HttpHeaders.contentTypeHeader: MockHttpClient.htmlContentType,
            },
          ),
        );
      });

      test('should return gallery details', () async {
        final details = await client.getGalleryDetails(galleryId);

        expect(
            details,
            equals(const GalleryDetails(
              ratingCount: 135,
              favoritesCount: 670,
              currentFavorite: -1,
            )));
      });
    });

    group('when server respond 404', () {
      setUp(() {
        httpClient.handle(
          request: ExpectedRequest(
            url: Uri.parse(
                '${EHentaiClient.baseUrl}/g/${galleryId.id}/${galleryId.token}'),
          ),
          response: Response(
            '',
            HttpStatus.notFound,
          ),
        );
      });

      test('should throw an exception', () async {
        expect(client.getGalleryDetails(galleryId), throwsRequestException);
      });
    });

    group('when token is incorrect', () {
      setUp(() {
        httpClient.handle(
          request: ExpectedRequest(
            url: Uri.parse(
                '${EHentaiClient.baseUrl}/g/${galleryId.id}/${galleryId.token}'),
          ),
          response: Response(
            'Key missing, or incorrect key provided.',
            HttpStatus.ok,
            headers: {
              HttpHeaders.contentTypeHeader: MockHttpClient.htmlContentType,
            },
          ),
        );
      });

      test('should throw an exception', () async {
        expect(
            client.getGalleryDetails(galleryId),
            throwsA(equals(RequestException(
              message: 'Gallery not found',
              statusCode: HttpStatus.ok,
              body: 'Key missing, or incorrect key provided.',
              url: Uri.parse(
                  '${EHentaiClient.baseUrl}/g/${galleryId.id}/${galleryId.token}'),
              method: 'GET',
            ))));
      });
    });

    group('when gallery is flagged', () {
      setUp(() async {
        httpClient.handle(
          request: ExpectedRequest(
            url: Uri.parse(
                '${EHentaiClient.baseUrl}/g/${galleryId.id}/${galleryId.token}'),
          ),
          response: Response(
            await readProjectFileAsString(
                'test/repositories/fixtures/gallery_content_warning.html'),
            HttpStatus.ok,
            headers: {
              HttpHeaders.contentTypeHeader: MockHttpClient.htmlContentType,
            },
          ),
        );
      });

      test('should throw an exception', () async {
        expect(
            client.getGalleryDetails(galleryId),
            throwsA(equals(const ContentWarningException(
              galleryId: galleryId,
              reason: 'Offensive For Everyone',
            ))));
      });
    });
  });

  group('getFavoriteStatus', () {});

  group('addToFavorite', () {});

  group('deleteFromFavorite', () {});

  group('getGalleryUrl', () {
    test('should return a string', () {
      const id = GalleryId(id: 1234567, token: 'abcdefgh');
      expect(client.getGalleryUrl(id),
          equals('${EHentaiClient.baseUrl}/g/${id.id}/${id.token}'));
    });
  });

  group('getImageUrl', () {
    test('should return a string', () {
      const id = ImageId(
        galleryId: GalleryId(id: 1234567, token: 'abcdefgh'),
        page: 46,
        key: 'qwerwetw',
      );
      expect(
          client.getImageUrl(id),
          equals(
              '${EHentaiClient.baseUrl}/s/${id.key}/${id.galleryId.id}-${id.page}'));
    });
  });

  group('getImageIds', () {
    const galleryId = GalleryId(
      id: 1663321,
      token: '4af85ee87d',
    );

    group('when respond 200', () {
      setUp(() async {
        httpClient.handle(
          request: ExpectedRequest(
            url: Uri.parse(
                '${EHentaiClient.baseUrl}/g/${galleryId.id}/${galleryId.token}/?p=0'),
          ),
          response: Response(
            await readProjectFileAsString(
                'test/repositories/fixtures/gallery_image_list.html'),
            HttpStatus.ok,
            headers: {
              HttpHeaders.contentTypeHeader: MockHttpClient.htmlContentType,
            },
          ),
        );
      });

      test('should return image ids', () async {
        final ids = await client.getImageIds(galleryId, 0);
        expect(
            ids,
            equals(const <ImageId>[
              ImageId(galleryId: galleryId, page: 1, key: '331c1f2ce7'),
              ImageId(galleryId: galleryId, page: 2, key: '23ba74f3b8'),
            ]));
      });
    });

    group('when respond 404', () {
      setUp(() {
        httpClient.handle(
          request: ExpectedRequest(
            url: Uri.parse(
                '${EHentaiClient.baseUrl}/g/${galleryId.id}/${galleryId.token}/?p=0'),
          ),
          response: Response(
            '',
            HttpStatus.notFound,
          ),
        );
      });

      test('should throw an exception', () async {
        expect(client.getImageIds(galleryId, 0), throwsRequestException);
      });
    });

    group('when token is incorrect', () {
      setUp(() {
        httpClient.handle(
          request: ExpectedRequest(
            url: Uri.parse(
                '${EHentaiClient.baseUrl}/g/${galleryId.id}/${galleryId.token}/?p=0'),
          ),
          response: Response(
            'Key missing, or incorrect key provided.',
            HttpStatus.ok,
            headers: {
              HttpHeaders.contentTypeHeader: MockHttpClient.htmlContentType,
            },
          ),
        );
      });

      test('should throw an exception', () async {
        expect(
            client.getImageIds(galleryId, 0),
            throwsA(equals(RequestException(
              message: 'Gallery not found',
              statusCode: HttpStatus.ok,
              body: 'Key missing, or incorrect key provided.',
              url: Uri.parse(
                  '${EHentaiClient.baseUrl}/g/${galleryId.id}/${galleryId.token}/?p=0'),
              method: 'GET',
            ))));
      });
    });

    group('when gallery is flagged', () {
      setUp(() async {
        httpClient.handle(
          request: ExpectedRequest(
            url: Uri.parse(
                '${EHentaiClient.baseUrl}/g/${galleryId.id}/${galleryId.token}/?p=0'),
          ),
          response: Response(
            await readProjectFileAsString(
                'test/repositories/fixtures/gallery_content_warning.html'),
            HttpStatus.ok,
            headers: {
              HttpHeaders.contentTypeHeader: MockHttpClient.htmlContentType,
            },
          ),
        );
      });

      test('should throw an exception', () async {
        expect(
            client.getImageIds(galleryId, 0),
            throwsA(equals(const ContentWarningException(
              galleryId: galleryId,
              reason: 'Offensive For Everyone',
            ))));
      });
    });
  });

  group('getImageData', () {
    const imageId = ImageId(
      galleryId: GalleryId(id: 1662914, token: 'ewreasda'),
      page: 1,
      key: '8ad5ea61cf',
    );

    group('when respond 200', () {
      setUp(() async {
        httpClient.handle(
          request: ExpectedRequest(
            url: Uri.parse(
                '${EHentaiClient.baseUrl}/s/${imageId.key}/${imageId.galleryId.id}-${imageId.page}'),
          ),
          response: Response(
            await readProjectFileAsString(
                'test/repositories/fixtures/image.html'),
            HttpStatus.ok,
            headers: {
              HttpHeaders.contentTypeHeader: MockHttpClient.htmlContentType,
            },
          ),
        );
      });

      test('should return image data', () async {
        expect(
            await client.getImageData(imageId),
            equals(const Image(
              id: imageId,
              url:
                  'https://funavbn.bvopscljbepc.hath.network/h/db2eba6e239a86d1db5b4bcf62d2726846a68ee5-522532-1280-1816-jpg/keystamp=1592409300-395fc82bf2;fileindex=81435369;xres=1280/65_gb_231764_65.jpg',
              width: 1280,
              height: 1816,
              reloadKey: '15309-442335',
            )));
      });
    });

    group('when respond 404', () {
      setUp(() {
        httpClient.handle(
          request: ExpectedRequest(
            url: Uri.parse(
                '${EHentaiClient.baseUrl}/s/${imageId.key}/${imageId.galleryId.id}-${imageId.page}'),
          ),
          response: Response(
            '',
            HttpStatus.notFound,
            headers: {
              HttpHeaders.contentTypeHeader: MockHttpClient.htmlContentType,
            },
          ),
        );
      });

      test('should throw an exception', () async {
        expect(client.getImageData(imageId), throwsRequestException);
      });
    });

    group('when key is incorrect', () {
      setUp(() {
        httpClient.handle(
          request: ExpectedRequest(
            url: Uri.parse(
                '${EHentaiClient.baseUrl}/s/${imageId.key}/${imageId.galleryId.id}-${imageId.page}'),
          ),
          response: Response(
            'Invalid page.',
            HttpStatus.ok,
            headers: {
              HttpHeaders.contentTypeHeader: MockHttpClient.htmlContentType,
            },
          ),
        );
      });

      test('should throw an exception', () async {
        expect(
            client.getImageData(imageId),
            throwsA(equals(RequestException(
              message: 'Image not found',
              statusCode: 200,
              body: 'Invalid page.',
              url: Uri.parse(
                  '${EHentaiClient.baseUrl}/s/${imageId.key}/${imageId.galleryId.id}-${imageId.page}'),
              method: 'GET',
            ))));
      });
    });

    group('when onerror attribute is not set on the image element', () {
      setUp(() async {
        httpClient.handle(
          request: ExpectedRequest(
            url: Uri.parse(
                '${EHentaiClient.baseUrl}/s/${imageId.key}/${imageId.galleryId.id}-${imageId.page}'),
          ),
          response: Response(
            await readProjectFileAsString(
                'test/repositories/fixtures/image_without_onerror.html'),
            HttpStatus.ok,
            headers: {
              HttpHeaders.contentTypeHeader: MockHttpClient.htmlContentType,
            },
          ),
        );
      });

      test('should return image data', () async {
        expect(
            await client.getImageData(imageId),
            equals(const Image(
              id: imageId,
              url:
                  'https://lwujxhaydlqtdzxawoti.hath.network/om/81435369/8ad5ea61cf05856ef29d2121c4be18d0a09fd3c9-4020849-1748-2480-png/db2eba6e239a86d1db5b4bcf62d2726846a68ee5-522532-1280-1816-jpg/1280/8tjfd9qdbygcce4ikr/65_gb_231764_65.jpg',
              width: 1280,
              height: 1816,
            )));
      });
    });
  });
}

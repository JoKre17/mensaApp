import 'package:flutter_test/flutter_test.dart';
import 'package:mensa_app/rss_service.dart';

void main() {
  test('Test to fetch the canteen RSS feed.', () async {
    final service = CanteenRssService();

    // fetch menu from main canteen (Hauptmensa Hannover)
    Future<void> _rssFeedTest =
        service.getMenu(2, MenuDate.today).then((entries) {
      expect(entries.length > 0, true);
      //DayEntry dayEntry = entries[0];
    });

    await Future.wait([_rssFeedTest]);
  });
}

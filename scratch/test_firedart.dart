import 'package:firedart/firedart.dart' as fd;

void test(fd.Page<fd.Document> page) {
  bool hasNext = page.hasNextPage;
  String token = page.nextPageToken;
  print("hasNextPage: $hasNext, nextPageToken: $token");
}

void main() {
  print("Compiles fine!");
}

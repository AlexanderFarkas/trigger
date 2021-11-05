abstract class MultiValform<T> {
  bool get isSealed;
  bool get isNotSealed;
  T? access(key, {required ownerId});
}
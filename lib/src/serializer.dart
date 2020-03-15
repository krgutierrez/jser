
abstract class Serializer<T> {
  T serialize(Map<String, dynamic> json);
}

abstract class Deserializer<T> {
  Map<String, dynamic> deserialize(T data);
}

import 'package:jser/jser.dart';

class SerializerFactory {

  SerializerFactory._internal();

  static final Map<Type, Serializer> _serializerMapping = {};

  static Serializer<T> get<T>() {
    final Serializer<T> serializer = _serializerMapping[T];
    if (serializer == null) {
      throw ArgumentError.value(T, 'There is no registered serializer for Type $T');
    }
    return serializer;
  }

  static void register<T>(Serializer<T> serializer) {
    _serializerMapping[T] = serializer;
  }
}

library jser;

import 'package:build/build.dart';
import 'package:jser/src/serializable.dart';
import 'package:jser/src/serializable_builder.dart';
import 'package:source_gen/source_gen.dart';

export 'src/serializable.dart' show Serializable, Deserializable;
export 'src/serializer.dart';

Builder serializableBuilder(BuilderOptions options) =>
    SharedPartBuilder([SerializableBuilder()], 'serializable');

Builder deserializableBuilder(BuilderOptions options) => SharedPartBuilder([DeSerializableBuilder()], 'deserializable');

//Builder factoryBuilder(BuilderOptions options) => LibraryBuilder(FactoryBuilder());

//class FactoryBuilder extends Generator {
//
//
//  @override
//  Future<String> generate(LibraryReader library, BuildStep buildStep) async {
//    final classes = library.classes.where((cls) => cls.metadata.contains(Serializable));
//    print('Classes: $classes');
//    return 'class SerializableFactory {}';
//  }
//}
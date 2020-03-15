import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:jser/src/serializable.dart';
import 'package:source_gen/source_gen.dart';

class SerializableBuilder extends GeneratorForAnnotation<Serializable> {

  @override
  dynamic generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element.kind != ElementKind.CLASS) {
      throw UnsupportedError(
          'Annotation serializable should only be use on classes');
    }
    final clsElement = element as ClassElement;
    final name = clsElement.name;
    final fields = clsElement.fields;
    final serializerName = '${name}Serializer';
    return [
      'class $serializerName implements Serializer<$name> {',
      '@override '
          '$name serialize(Map<String, dynamic> json) {',
      'return ${name}(${_generateParameterFields(fields)});'
          '}'
          '}'
    ];
  }

  String _generateParameterFields(List<FieldElement> fields) {
    return fields.fold<String>('', (previousValue, field) {
      final name = field.name;
      return previousValue += '$name: json[\'$name\'], ';
    });
  }
}

class DeSerializableBuilder extends GeneratorForAnnotation<Deserializable> {
  @override
  dynamic generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element.kind != ElementKind.CLASS) {
      throw UnsupportedError(
          'Annotation serializable should only be use on classes');
    }
    final clsElement = element as ClassElement;
    final name = clsElement.name;
    final fields = clsElement.fields;
    return
      'class ${name}Deserializer implements Deserializer<$name> {'
        '@override '
        'Map<String, dynamic> deserialize($name data) {'
         'return {${_generateParameters(fields).join(', ')}};'
        '}'
      '}'
    ;
  }

  List<String> _generateParameters(List<FieldElement> fields) {
    return fields.map<String>((field) {
      final name =field.name;
      return '\'$name\': data.$name';
    }).toList();
  }
}

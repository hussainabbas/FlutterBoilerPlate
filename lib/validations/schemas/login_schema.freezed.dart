// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_schema.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LoginSchema {
  Field<String> get email => throw _privateConstructorUsedError;
  Field<String> get password => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginSchemaCopyWith<LoginSchema> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginSchemaCopyWith<$Res> {
  factory $LoginSchemaCopyWith(
          LoginSchema value, $Res Function(LoginSchema) then) =
      _$LoginSchemaCopyWithImpl<$Res, LoginSchema>;
  @useResult
  $Res call({Field<String> email, Field<String> password});

  $FieldCopyWith<String, $Res> get email;
  $FieldCopyWith<String, $Res> get password;
}

/// @nodoc
class _$LoginSchemaCopyWithImpl<$Res, $Val extends LoginSchema>
    implements $LoginSchemaCopyWith<$Res> {
  _$LoginSchemaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as Field<String>,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as Field<String>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FieldCopyWith<String, $Res> get email {
    return $FieldCopyWith<String, $Res>(_value.email, (value) {
      return _then(_value.copyWith(email: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $FieldCopyWith<String, $Res> get password {
    return $FieldCopyWith<String, $Res>(_value.password, (value) {
      return _then(_value.copyWith(password: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_LoginSchemaCopyWith<$Res>
    implements $LoginSchemaCopyWith<$Res> {
  factory _$$_LoginSchemaCopyWith(
          _$_LoginSchema value, $Res Function(_$_LoginSchema) then) =
      __$$_LoginSchemaCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Field<String> email, Field<String> password});

  @override
  $FieldCopyWith<String, $Res> get email;
  @override
  $FieldCopyWith<String, $Res> get password;
}

/// @nodoc
class __$$_LoginSchemaCopyWithImpl<$Res>
    extends _$LoginSchemaCopyWithImpl<$Res, _$_LoginSchema>
    implements _$$_LoginSchemaCopyWith<$Res> {
  __$$_LoginSchemaCopyWithImpl(
      _$_LoginSchema _value, $Res Function(_$_LoginSchema) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_$_LoginSchema(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as Field<String>,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as Field<String>,
    ));
  }
}

/// @nodoc

class _$_LoginSchema implements _LoginSchema {
  const _$_LoginSchema({required this.email, required this.password});

  @override
  final Field<String> email;
  @override
  final Field<String> password;

  @override
  String toString() {
    return 'LoginSchema(email: $email, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LoginSchema &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LoginSchemaCopyWith<_$_LoginSchema> get copyWith =>
      __$$_LoginSchemaCopyWithImpl<_$_LoginSchema>(this, _$identity);
}

abstract class _LoginSchema implements LoginSchema {
  const factory _LoginSchema(
      {required final Field<String> email,
      required final Field<String> password}) = _$_LoginSchema;

  @override
  Field<String> get email;
  @override
  Field<String> get password;
  @override
  @JsonKey(ignore: true)
  _$$_LoginSchemaCopyWith<_$_LoginSchema> get copyWith =>
      throw _privateConstructorUsedError;
}

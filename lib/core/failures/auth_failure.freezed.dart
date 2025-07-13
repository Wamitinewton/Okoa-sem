// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthFailure {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure()';
}


}

/// @nodoc
class $AuthFailureCopyWith<$Res>  {
$AuthFailureCopyWith(AuthFailure _, $Res Function(AuthFailure) __);
}


/// Adds pattern-matching-related methods to [AuthFailure].
extension AuthFailurePatterns on AuthFailure {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _ServerError value)?  serverError,TResult Function( _NetworkError value)?  networkError,TResult Function( _Cancelled value)?  cancelled,TResult Function( _UserDisabled value)?  userDisabled,TResult Function( _UserNotFound value)?  userNotFound,TResult Function( _WrongPassword value)?  wrongPassword,TResult Function( _InvalidEmail value)?  invalidEmail,TResult Function( _EmailAlreadyInUse value)?  emailAlreadyInUse,TResult Function( _WeakPassword value)?  weakPassword,TResult Function( _TooManyRequests value)?  tooManyRequests,TResult Function( _OperationNotAllowed value)?  operationNotAllowed,TResult Function( _AccountExistsWithDifferentCredential value)?  accountExistsWithDifferentCredential,TResult Function( _InvalidCredential value)?  invalidCredential,TResult Function( _UnknownError value)?  unknownError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServerError() when serverError != null:
return serverError(_that);case _NetworkError() when networkError != null:
return networkError(_that);case _Cancelled() when cancelled != null:
return cancelled(_that);case _UserDisabled() when userDisabled != null:
return userDisabled(_that);case _UserNotFound() when userNotFound != null:
return userNotFound(_that);case _WrongPassword() when wrongPassword != null:
return wrongPassword(_that);case _InvalidEmail() when invalidEmail != null:
return invalidEmail(_that);case _EmailAlreadyInUse() when emailAlreadyInUse != null:
return emailAlreadyInUse(_that);case _WeakPassword() when weakPassword != null:
return weakPassword(_that);case _TooManyRequests() when tooManyRequests != null:
return tooManyRequests(_that);case _OperationNotAllowed() when operationNotAllowed != null:
return operationNotAllowed(_that);case _AccountExistsWithDifferentCredential() when accountExistsWithDifferentCredential != null:
return accountExistsWithDifferentCredential(_that);case _InvalidCredential() when invalidCredential != null:
return invalidCredential(_that);case _UnknownError() when unknownError != null:
return unknownError(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _ServerError value)  serverError,required TResult Function( _NetworkError value)  networkError,required TResult Function( _Cancelled value)  cancelled,required TResult Function( _UserDisabled value)  userDisabled,required TResult Function( _UserNotFound value)  userNotFound,required TResult Function( _WrongPassword value)  wrongPassword,required TResult Function( _InvalidEmail value)  invalidEmail,required TResult Function( _EmailAlreadyInUse value)  emailAlreadyInUse,required TResult Function( _WeakPassword value)  weakPassword,required TResult Function( _TooManyRequests value)  tooManyRequests,required TResult Function( _OperationNotAllowed value)  operationNotAllowed,required TResult Function( _AccountExistsWithDifferentCredential value)  accountExistsWithDifferentCredential,required TResult Function( _InvalidCredential value)  invalidCredential,required TResult Function( _UnknownError value)  unknownError,}){
final _that = this;
switch (_that) {
case _ServerError():
return serverError(_that);case _NetworkError():
return networkError(_that);case _Cancelled():
return cancelled(_that);case _UserDisabled():
return userDisabled(_that);case _UserNotFound():
return userNotFound(_that);case _WrongPassword():
return wrongPassword(_that);case _InvalidEmail():
return invalidEmail(_that);case _EmailAlreadyInUse():
return emailAlreadyInUse(_that);case _WeakPassword():
return weakPassword(_that);case _TooManyRequests():
return tooManyRequests(_that);case _OperationNotAllowed():
return operationNotAllowed(_that);case _AccountExistsWithDifferentCredential():
return accountExistsWithDifferentCredential(_that);case _InvalidCredential():
return invalidCredential(_that);case _UnknownError():
return unknownError(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _ServerError value)?  serverError,TResult? Function( _NetworkError value)?  networkError,TResult? Function( _Cancelled value)?  cancelled,TResult? Function( _UserDisabled value)?  userDisabled,TResult? Function( _UserNotFound value)?  userNotFound,TResult? Function( _WrongPassword value)?  wrongPassword,TResult? Function( _InvalidEmail value)?  invalidEmail,TResult? Function( _EmailAlreadyInUse value)?  emailAlreadyInUse,TResult? Function( _WeakPassword value)?  weakPassword,TResult? Function( _TooManyRequests value)?  tooManyRequests,TResult? Function( _OperationNotAllowed value)?  operationNotAllowed,TResult? Function( _AccountExistsWithDifferentCredential value)?  accountExistsWithDifferentCredential,TResult? Function( _InvalidCredential value)?  invalidCredential,TResult? Function( _UnknownError value)?  unknownError,}){
final _that = this;
switch (_that) {
case _ServerError() when serverError != null:
return serverError(_that);case _NetworkError() when networkError != null:
return networkError(_that);case _Cancelled() when cancelled != null:
return cancelled(_that);case _UserDisabled() when userDisabled != null:
return userDisabled(_that);case _UserNotFound() when userNotFound != null:
return userNotFound(_that);case _WrongPassword() when wrongPassword != null:
return wrongPassword(_that);case _InvalidEmail() when invalidEmail != null:
return invalidEmail(_that);case _EmailAlreadyInUse() when emailAlreadyInUse != null:
return emailAlreadyInUse(_that);case _WeakPassword() when weakPassword != null:
return weakPassword(_that);case _TooManyRequests() when tooManyRequests != null:
return tooManyRequests(_that);case _OperationNotAllowed() when operationNotAllowed != null:
return operationNotAllowed(_that);case _AccountExistsWithDifferentCredential() when accountExistsWithDifferentCredential != null:
return accountExistsWithDifferentCredential(_that);case _InvalidCredential() when invalidCredential != null:
return invalidCredential(_that);case _UnknownError() when unknownError != null:
return unknownError(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? message)?  serverError,TResult Function()?  networkError,TResult Function()?  cancelled,TResult Function()?  userDisabled,TResult Function()?  userNotFound,TResult Function()?  wrongPassword,TResult Function()?  invalidEmail,TResult Function()?  emailAlreadyInUse,TResult Function()?  weakPassword,TResult Function()?  tooManyRequests,TResult Function()?  operationNotAllowed,TResult Function()?  accountExistsWithDifferentCredential,TResult Function()?  invalidCredential,TResult Function( String? message)?  unknownError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServerError() when serverError != null:
return serverError(_that.message);case _NetworkError() when networkError != null:
return networkError();case _Cancelled() when cancelled != null:
return cancelled();case _UserDisabled() when userDisabled != null:
return userDisabled();case _UserNotFound() when userNotFound != null:
return userNotFound();case _WrongPassword() when wrongPassword != null:
return wrongPassword();case _InvalidEmail() when invalidEmail != null:
return invalidEmail();case _EmailAlreadyInUse() when emailAlreadyInUse != null:
return emailAlreadyInUse();case _WeakPassword() when weakPassword != null:
return weakPassword();case _TooManyRequests() when tooManyRequests != null:
return tooManyRequests();case _OperationNotAllowed() when operationNotAllowed != null:
return operationNotAllowed();case _AccountExistsWithDifferentCredential() when accountExistsWithDifferentCredential != null:
return accountExistsWithDifferentCredential();case _InvalidCredential() when invalidCredential != null:
return invalidCredential();case _UnknownError() when unknownError != null:
return unknownError(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? message)  serverError,required TResult Function()  networkError,required TResult Function()  cancelled,required TResult Function()  userDisabled,required TResult Function()  userNotFound,required TResult Function()  wrongPassword,required TResult Function()  invalidEmail,required TResult Function()  emailAlreadyInUse,required TResult Function()  weakPassword,required TResult Function()  tooManyRequests,required TResult Function()  operationNotAllowed,required TResult Function()  accountExistsWithDifferentCredential,required TResult Function()  invalidCredential,required TResult Function( String? message)  unknownError,}) {final _that = this;
switch (_that) {
case _ServerError():
return serverError(_that.message);case _NetworkError():
return networkError();case _Cancelled():
return cancelled();case _UserDisabled():
return userDisabled();case _UserNotFound():
return userNotFound();case _WrongPassword():
return wrongPassword();case _InvalidEmail():
return invalidEmail();case _EmailAlreadyInUse():
return emailAlreadyInUse();case _WeakPassword():
return weakPassword();case _TooManyRequests():
return tooManyRequests();case _OperationNotAllowed():
return operationNotAllowed();case _AccountExistsWithDifferentCredential():
return accountExistsWithDifferentCredential();case _InvalidCredential():
return invalidCredential();case _UnknownError():
return unknownError(_that.message);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? message)?  serverError,TResult? Function()?  networkError,TResult? Function()?  cancelled,TResult? Function()?  userDisabled,TResult? Function()?  userNotFound,TResult? Function()?  wrongPassword,TResult? Function()?  invalidEmail,TResult? Function()?  emailAlreadyInUse,TResult? Function()?  weakPassword,TResult? Function()?  tooManyRequests,TResult? Function()?  operationNotAllowed,TResult? Function()?  accountExistsWithDifferentCredential,TResult? Function()?  invalidCredential,TResult? Function( String? message)?  unknownError,}) {final _that = this;
switch (_that) {
case _ServerError() when serverError != null:
return serverError(_that.message);case _NetworkError() when networkError != null:
return networkError();case _Cancelled() when cancelled != null:
return cancelled();case _UserDisabled() when userDisabled != null:
return userDisabled();case _UserNotFound() when userNotFound != null:
return userNotFound();case _WrongPassword() when wrongPassword != null:
return wrongPassword();case _InvalidEmail() when invalidEmail != null:
return invalidEmail();case _EmailAlreadyInUse() when emailAlreadyInUse != null:
return emailAlreadyInUse();case _WeakPassword() when weakPassword != null:
return weakPassword();case _TooManyRequests() when tooManyRequests != null:
return tooManyRequests();case _OperationNotAllowed() when operationNotAllowed != null:
return operationNotAllowed();case _AccountExistsWithDifferentCredential() when accountExistsWithDifferentCredential != null:
return accountExistsWithDifferentCredential();case _InvalidCredential() when invalidCredential != null:
return invalidCredential();case _UnknownError() when unknownError != null:
return unknownError(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _ServerError implements AuthFailure {
  const _ServerError([this.message]);
  

 final  String? message;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServerErrorCopyWith<_ServerError> get copyWith => __$ServerErrorCopyWithImpl<_ServerError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServerError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AuthFailure.serverError(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ServerErrorCopyWith<$Res> implements $AuthFailureCopyWith<$Res> {
  factory _$ServerErrorCopyWith(_ServerError value, $Res Function(_ServerError) _then) = __$ServerErrorCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class __$ServerErrorCopyWithImpl<$Res>
    implements _$ServerErrorCopyWith<$Res> {
  __$ServerErrorCopyWithImpl(this._self, this._then);

  final _ServerError _self;
  final $Res Function(_ServerError) _then;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(_ServerError(
freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _NetworkError implements AuthFailure {
  const _NetworkError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NetworkError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure.networkError()';
}


}




/// @nodoc


class _Cancelled implements AuthFailure {
  const _Cancelled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Cancelled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure.cancelled()';
}


}




/// @nodoc


class _UserDisabled implements AuthFailure {
  const _UserDisabled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserDisabled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure.userDisabled()';
}


}




/// @nodoc


class _UserNotFound implements AuthFailure {
  const _UserNotFound();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserNotFound);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure.userNotFound()';
}


}




/// @nodoc


class _WrongPassword implements AuthFailure {
  const _WrongPassword();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WrongPassword);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure.wrongPassword()';
}


}




/// @nodoc


class _InvalidEmail implements AuthFailure {
  const _InvalidEmail();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InvalidEmail);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure.invalidEmail()';
}


}




/// @nodoc


class _EmailAlreadyInUse implements AuthFailure {
  const _EmailAlreadyInUse();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmailAlreadyInUse);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure.emailAlreadyInUse()';
}


}




/// @nodoc


class _WeakPassword implements AuthFailure {
  const _WeakPassword();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeakPassword);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure.weakPassword()';
}


}




/// @nodoc


class _TooManyRequests implements AuthFailure {
  const _TooManyRequests();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TooManyRequests);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure.tooManyRequests()';
}


}




/// @nodoc


class _OperationNotAllowed implements AuthFailure {
  const _OperationNotAllowed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OperationNotAllowed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure.operationNotAllowed()';
}


}




/// @nodoc


class _AccountExistsWithDifferentCredential implements AuthFailure {
  const _AccountExistsWithDifferentCredential();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountExistsWithDifferentCredential);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure.accountExistsWithDifferentCredential()';
}


}




/// @nodoc


class _InvalidCredential implements AuthFailure {
  const _InvalidCredential();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InvalidCredential);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure.invalidCredential()';
}


}




/// @nodoc


class _UnknownError implements AuthFailure {
  const _UnknownError([this.message]);
  

 final  String? message;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnknownErrorCopyWith<_UnknownError> get copyWith => __$UnknownErrorCopyWithImpl<_UnknownError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnknownError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AuthFailure.unknownError(message: $message)';
}


}

/// @nodoc
abstract mixin class _$UnknownErrorCopyWith<$Res> implements $AuthFailureCopyWith<$Res> {
  factory _$UnknownErrorCopyWith(_UnknownError value, $Res Function(_UnknownError) _then) = __$UnknownErrorCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class __$UnknownErrorCopyWithImpl<$Res>
    implements _$UnknownErrorCopyWith<$Res> {
  __$UnknownErrorCopyWithImpl(this._self, this._then);

  final _UnknownError _self;
  final $Res Function(_UnknownError) _then;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(_UnknownError(
freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

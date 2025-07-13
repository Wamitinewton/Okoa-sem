// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent()';
}


}

/// @nodoc
class $AuthEventCopyWith<$Res>  {
$AuthEventCopyWith(AuthEvent _, $Res Function(AuthEvent) __);
}


/// Adds pattern-matching-related methods to [AuthEvent].
extension AuthEventPatterns on AuthEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _AuthStateChanged value)?  authStateChanged,TResult Function( _CheckAuthStatus value)?  checkAuthStatus,TResult Function( _SignInWithGoogle value)?  signInWithGoogle,TResult Function( _SignInWithEmail value)?  signInWithEmail,TResult Function( _RegisterWithEmail value)?  registerWithEmail,TResult Function( _SignOut value)?  signOut,TResult Function( _SendPasswordReset value)?  sendPasswordReset,TResult Function( _SendEmailVerification value)?  sendEmailVerification,TResult Function( _ReloadUser value)?  reloadUser,TResult Function( _DeleteAccount value)?  deleteAccount,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthStateChanged() when authStateChanged != null:
return authStateChanged(_that);case _CheckAuthStatus() when checkAuthStatus != null:
return checkAuthStatus(_that);case _SignInWithGoogle() when signInWithGoogle != null:
return signInWithGoogle(_that);case _SignInWithEmail() when signInWithEmail != null:
return signInWithEmail(_that);case _RegisterWithEmail() when registerWithEmail != null:
return registerWithEmail(_that);case _SignOut() when signOut != null:
return signOut(_that);case _SendPasswordReset() when sendPasswordReset != null:
return sendPasswordReset(_that);case _SendEmailVerification() when sendEmailVerification != null:
return sendEmailVerification(_that);case _ReloadUser() when reloadUser != null:
return reloadUser(_that);case _DeleteAccount() when deleteAccount != null:
return deleteAccount(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _AuthStateChanged value)  authStateChanged,required TResult Function( _CheckAuthStatus value)  checkAuthStatus,required TResult Function( _SignInWithGoogle value)  signInWithGoogle,required TResult Function( _SignInWithEmail value)  signInWithEmail,required TResult Function( _RegisterWithEmail value)  registerWithEmail,required TResult Function( _SignOut value)  signOut,required TResult Function( _SendPasswordReset value)  sendPasswordReset,required TResult Function( _SendEmailVerification value)  sendEmailVerification,required TResult Function( _ReloadUser value)  reloadUser,required TResult Function( _DeleteAccount value)  deleteAccount,}){
final _that = this;
switch (_that) {
case _AuthStateChanged():
return authStateChanged(_that);case _CheckAuthStatus():
return checkAuthStatus(_that);case _SignInWithGoogle():
return signInWithGoogle(_that);case _SignInWithEmail():
return signInWithEmail(_that);case _RegisterWithEmail():
return registerWithEmail(_that);case _SignOut():
return signOut(_that);case _SendPasswordReset():
return sendPasswordReset(_that);case _SendEmailVerification():
return sendEmailVerification(_that);case _ReloadUser():
return reloadUser(_that);case _DeleteAccount():
return deleteAccount(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _AuthStateChanged value)?  authStateChanged,TResult? Function( _CheckAuthStatus value)?  checkAuthStatus,TResult? Function( _SignInWithGoogle value)?  signInWithGoogle,TResult? Function( _SignInWithEmail value)?  signInWithEmail,TResult? Function( _RegisterWithEmail value)?  registerWithEmail,TResult? Function( _SignOut value)?  signOut,TResult? Function( _SendPasswordReset value)?  sendPasswordReset,TResult? Function( _SendEmailVerification value)?  sendEmailVerification,TResult? Function( _ReloadUser value)?  reloadUser,TResult? Function( _DeleteAccount value)?  deleteAccount,}){
final _that = this;
switch (_that) {
case _AuthStateChanged() when authStateChanged != null:
return authStateChanged(_that);case _CheckAuthStatus() when checkAuthStatus != null:
return checkAuthStatus(_that);case _SignInWithGoogle() when signInWithGoogle != null:
return signInWithGoogle(_that);case _SignInWithEmail() when signInWithEmail != null:
return signInWithEmail(_that);case _RegisterWithEmail() when registerWithEmail != null:
return registerWithEmail(_that);case _SignOut() when signOut != null:
return signOut(_that);case _SendPasswordReset() when sendPasswordReset != null:
return sendPasswordReset(_that);case _SendEmailVerification() when sendEmailVerification != null:
return sendEmailVerification(_that);case _ReloadUser() when reloadUser != null:
return reloadUser(_that);case _DeleteAccount() when deleteAccount != null:
return deleteAccount(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  authStateChanged,TResult Function()?  checkAuthStatus,TResult Function()?  signInWithGoogle,TResult Function( String email,  String password)?  signInWithEmail,TResult Function( String email,  String password,  String displayName)?  registerWithEmail,TResult Function()?  signOut,TResult Function( String email)?  sendPasswordReset,TResult Function()?  sendEmailVerification,TResult Function()?  reloadUser,TResult Function()?  deleteAccount,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthStateChanged() when authStateChanged != null:
return authStateChanged();case _CheckAuthStatus() when checkAuthStatus != null:
return checkAuthStatus();case _SignInWithGoogle() when signInWithGoogle != null:
return signInWithGoogle();case _SignInWithEmail() when signInWithEmail != null:
return signInWithEmail(_that.email,_that.password);case _RegisterWithEmail() when registerWithEmail != null:
return registerWithEmail(_that.email,_that.password,_that.displayName);case _SignOut() when signOut != null:
return signOut();case _SendPasswordReset() when sendPasswordReset != null:
return sendPasswordReset(_that.email);case _SendEmailVerification() when sendEmailVerification != null:
return sendEmailVerification();case _ReloadUser() when reloadUser != null:
return reloadUser();case _DeleteAccount() when deleteAccount != null:
return deleteAccount();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  authStateChanged,required TResult Function()  checkAuthStatus,required TResult Function()  signInWithGoogle,required TResult Function( String email,  String password)  signInWithEmail,required TResult Function( String email,  String password,  String displayName)  registerWithEmail,required TResult Function()  signOut,required TResult Function( String email)  sendPasswordReset,required TResult Function()  sendEmailVerification,required TResult Function()  reloadUser,required TResult Function()  deleteAccount,}) {final _that = this;
switch (_that) {
case _AuthStateChanged():
return authStateChanged();case _CheckAuthStatus():
return checkAuthStatus();case _SignInWithGoogle():
return signInWithGoogle();case _SignInWithEmail():
return signInWithEmail(_that.email,_that.password);case _RegisterWithEmail():
return registerWithEmail(_that.email,_that.password,_that.displayName);case _SignOut():
return signOut();case _SendPasswordReset():
return sendPasswordReset(_that.email);case _SendEmailVerification():
return sendEmailVerification();case _ReloadUser():
return reloadUser();case _DeleteAccount():
return deleteAccount();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  authStateChanged,TResult? Function()?  checkAuthStatus,TResult? Function()?  signInWithGoogle,TResult? Function( String email,  String password)?  signInWithEmail,TResult? Function( String email,  String password,  String displayName)?  registerWithEmail,TResult? Function()?  signOut,TResult? Function( String email)?  sendPasswordReset,TResult? Function()?  sendEmailVerification,TResult? Function()?  reloadUser,TResult? Function()?  deleteAccount,}) {final _that = this;
switch (_that) {
case _AuthStateChanged() when authStateChanged != null:
return authStateChanged();case _CheckAuthStatus() when checkAuthStatus != null:
return checkAuthStatus();case _SignInWithGoogle() when signInWithGoogle != null:
return signInWithGoogle();case _SignInWithEmail() when signInWithEmail != null:
return signInWithEmail(_that.email,_that.password);case _RegisterWithEmail() when registerWithEmail != null:
return registerWithEmail(_that.email,_that.password,_that.displayName);case _SignOut() when signOut != null:
return signOut();case _SendPasswordReset() when sendPasswordReset != null:
return sendPasswordReset(_that.email);case _SendEmailVerification() when sendEmailVerification != null:
return sendEmailVerification();case _ReloadUser() when reloadUser != null:
return reloadUser();case _DeleteAccount() when deleteAccount != null:
return deleteAccount();case _:
  return null;

}
}

}

/// @nodoc


class _AuthStateChanged implements AuthEvent {
  const _AuthStateChanged();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthStateChanged);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.authStateChanged()';
}


}




/// @nodoc


class _CheckAuthStatus implements AuthEvent {
  const _CheckAuthStatus();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckAuthStatus);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.checkAuthStatus()';
}


}




/// @nodoc


class _SignInWithGoogle implements AuthEvent {
  const _SignInWithGoogle();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignInWithGoogle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.signInWithGoogle()';
}


}




/// @nodoc


class _SignInWithEmail implements AuthEvent {
  const _SignInWithEmail({required this.email, required this.password});
  

 final  String email;
 final  String password;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignInWithEmailCopyWith<_SignInWithEmail> get copyWith => __$SignInWithEmailCopyWithImpl<_SignInWithEmail>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignInWithEmail&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'AuthEvent.signInWithEmail(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class _$SignInWithEmailCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$SignInWithEmailCopyWith(_SignInWithEmail value, $Res Function(_SignInWithEmail) _then) = __$SignInWithEmailCopyWithImpl;
@useResult
$Res call({
 String email, String password
});




}
/// @nodoc
class __$SignInWithEmailCopyWithImpl<$Res>
    implements _$SignInWithEmailCopyWith<$Res> {
  __$SignInWithEmailCopyWithImpl(this._self, this._then);

  final _SignInWithEmail _self;
  final $Res Function(_SignInWithEmail) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,}) {
  return _then(_SignInWithEmail(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _RegisterWithEmail implements AuthEvent {
  const _RegisterWithEmail({required this.email, required this.password, required this.displayName});
  

 final  String email;
 final  String password;
 final  String displayName;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterWithEmailCopyWith<_RegisterWithEmail> get copyWith => __$RegisterWithEmailCopyWithImpl<_RegisterWithEmail>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisterWithEmail&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.displayName, displayName) || other.displayName == displayName));
}


@override
int get hashCode => Object.hash(runtimeType,email,password,displayName);

@override
String toString() {
  return 'AuthEvent.registerWithEmail(email: $email, password: $password, displayName: $displayName)';
}


}

/// @nodoc
abstract mixin class _$RegisterWithEmailCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$RegisterWithEmailCopyWith(_RegisterWithEmail value, $Res Function(_RegisterWithEmail) _then) = __$RegisterWithEmailCopyWithImpl;
@useResult
$Res call({
 String email, String password, String displayName
});




}
/// @nodoc
class __$RegisterWithEmailCopyWithImpl<$Res>
    implements _$RegisterWithEmailCopyWith<$Res> {
  __$RegisterWithEmailCopyWithImpl(this._self, this._then);

  final _RegisterWithEmail _self;
  final $Res Function(_RegisterWithEmail) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,Object? displayName = null,}) {
  return _then(_RegisterWithEmail(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SignOut implements AuthEvent {
  const _SignOut();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignOut);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.signOut()';
}


}




/// @nodoc


class _SendPasswordReset implements AuthEvent {
  const _SendPasswordReset({required this.email});
  

 final  String email;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendPasswordResetCopyWith<_SendPasswordReset> get copyWith => __$SendPasswordResetCopyWithImpl<_SendPasswordReset>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendPasswordReset&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'AuthEvent.sendPasswordReset(email: $email)';
}


}

/// @nodoc
abstract mixin class _$SendPasswordResetCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$SendPasswordResetCopyWith(_SendPasswordReset value, $Res Function(_SendPasswordReset) _then) = __$SendPasswordResetCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class __$SendPasswordResetCopyWithImpl<$Res>
    implements _$SendPasswordResetCopyWith<$Res> {
  __$SendPasswordResetCopyWithImpl(this._self, this._then);

  final _SendPasswordReset _self;
  final $Res Function(_SendPasswordReset) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(_SendPasswordReset(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SendEmailVerification implements AuthEvent {
  const _SendEmailVerification();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendEmailVerification);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.sendEmailVerification()';
}


}




/// @nodoc


class _ReloadUser implements AuthEvent {
  const _ReloadUser();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReloadUser);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.reloadUser()';
}


}




/// @nodoc


class _DeleteAccount implements AuthEvent {
  const _DeleteAccount();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteAccount);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.deleteAccount()';
}


}




// dart format on

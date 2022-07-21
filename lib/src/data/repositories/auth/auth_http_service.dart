// import 'package:cubex/src/core/utils/endpoints.dart';
// import 'package:cubex/src/data/datasources/remote/auth/auth_service.dart';
// import 'package:cubex/src/data/datasources/remote/base_http.dart';

// import 'package:dio/dio.dart';

// class AuthHttpService extends AlsBaseHttpService implements AuthService {
//   @override
//   Future<Response> login({required Map<String, dynamic> data}) async {
//     try {
//       final res = await http.post(CbEndpoints.login, data: data);
//       return res;
//     } on DioError catch (e) {
//       throw e;
//     } on Exception catch (e) {
//       throw e;
//     }
//   }

//   @override
//   Future<Response> register({required Map<String, dynamic> data}) async {
//     try {
//       final res = await http.post(CbEndpoints.register, data: data);
//       return res;
//     } on DioError catch (e) {
//       throw e;
//     } on Exception catch (e) {
//       throw e;
//     }
//   }

//   @override
//   Future<Response> fetchUser() async {
//     try {
//       final res = await http.get(CbEndpoints.fetchUser);
//       return res;
//     } on DioError catch (e) {
//       throw e;
//     } on Exception catch (e) {
//       throw e;
//     }
//   }

//   @override
//   Future<Response> fetchUserBy({required String username}) async {
//     try {
//       final res = await http.get(CbEndpoints.fetchUserBy + '?email=$username');
//       return res;
//     } on DioError catch (e) {
//       throw e;
//     } on Exception catch (e) {
//       throw e;
//     }
//   }

//   @override
//   Future<Response> updateUser({required Map<String, dynamic> data}) async {
//     try {
//       print('updateUser: $data');
//       print(CbEndpoints.editUserDetails);
//       final res = await http.put(CbEndpoints.editUserDetails, data: data);
//       print(res.data);
//       print(res.statusCode);
//       return res;
//     } on DioError catch (e) {
//       throw e;
//     } on Exception catch (e) {
//       throw e;
//     }
//   }

//   @override
//   Future<Response> changePassword({required Map<String, dynamic> data}) async {
//     try {
//       final res = await http.post(CbEndpoints.changePassword, data: data);
//       return res;
//     } on DioError catch (e) {
//       throw e;
//     } on Exception catch (e) {
//       throw e;
//     }
//   }

//   @override
//   Future<Response> forgotPassword({required Map<String, dynamic> data}) async {
//     try {
//       final res = await http.post(CbEndpoints.forgotPassword, data: data);
//       return res;
//     } on DioError catch (e) {
//       throw e;
//     } on Exception catch (e) {
//       throw e;
//     }
//   }

//   @override
//   Future<Response> resetPassword({required String code}) async {
//     try {
//       final res = await http.get(
//         CbEndpoints.validateResetCode + code,
//       );
//       return res;
//     } on DioError catch (e) {
//       throw e;
//     } on Exception catch (e) {
//       throw e;
//     }
//   }

//   @override
//   Future<Response> resendEmailCode() async {
//     try {
//       final res = await http.get(
//         CbEndpoints.resendVerifyEmail,
//       );
//       return res;
//     } on DioError catch (e) {
//       throw e;
//     } on Exception catch (e) {
//       throw e;
//     }
//   }

//   @override
//   Future<Response> verifyEmail({required String code}) async {
//     try {
//       final res = await http.get(CbEndpoints.verifyEmail + code);
//       return res;
//     } on DioError catch (e) {
//       throw e;
//     } on Exception catch (e) {
//       throw e;
//     }
//   }
// }

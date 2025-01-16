import 'package:clean_code_app/core/entities/user.dart';
import 'package:clean_code_app/core/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late UserModel validUserModel;
  late Map<String, dynamic> validJson;

  setUpAll(() {
    validUserModel = const UserModel(
        id: '1', name: 'paras shakya', email: 'paras@gmail.com');
    validJson = {
      "_id": "1",
      "username": "paras shakya",
      "email": "paras@gmail.com"
    };
  });

  group("subclass test", () {
    test("[UserModel] should be a subclass of [User] entity", () {
      //arrange
      //act

      //assert
      expect(validUserModel, isA<User>());
    });
  });
  group("fromJSON and toJSON Valid cases", () {
    group("fromJson", () {
      test("should convert valid [JSON] to valid [UserModel]", () {
        //Arrange

        //Act
        final result = UserModel.fromJson(validJson);

        //Assert
        expect(result, equals(validUserModel));
      });
    });

    group("toJSON", () {
      test("should convert valid [UserModel] to valid [JSON]", () {
        //Arrange

        //Act
        final result = validUserModel.toJson();

        //Assert
        expect(result, equals(validJson));
      });
    });
  });

  group("fromJSON and toJSON Invalid cases", () {
    test(
        "should throw an Exception when [JSON] with missing [username] is converted to [UserModel]",
        () {
      //json with missing username field
      final json = {"_id": "4", "email": "paras@gmail.com"};
      expect(() => UserModel.fromJson(json), throwsA(isA<Exception>()));
    });

    test(
        "should throw an Exception when [JSON] with missing [id] is converted to [UserModel]",
        () {
      //json with missing id field
      final json = {"username": "bibek shakya", "email": "bibek@gmail.com"};

      expect(() => UserModel.fromJson(json), throwsA(isA<Exception>()));
    });

    test(
        "should throw an Exception when [JSON] with missing [email] is converted to [UserModel]",
        () {
      //json with missing email field
      final json = {"username": "bibek shakya", "_id": "2"};

      expect(() => UserModel.fromJson(json), throwsA(isA<Exception>()));
    });

    test(
        "should throw an Exception when [UserModel] with empty [id] is converted to [JSON]",
        () {
      //user with empty id field
      final userModel =
          UserModel(id: '', name: 'paras', email: 'paras@gmail.com');
      expect(() => userModel.toJson(), throwsA(isA<Exception>()));
    });
    test(
        "should throw an Exception when [UserModel] with empty [username] is converted to [JSON]",
        () {
      //user with empty id field
      final userModel =
          UserModel(id: '3423', name: '', email: 'paras@gmail.com');
      expect(() => userModel.toJson(), throwsA(isA<Exception>()));
    });

    test(
        "should throw an Exception when [UserModel] with empty [email] is converted to [JSON]",
        () {
      //user with empty id field
      final userModel = UserModel(id: '234', name: 'paras', email: '');
      expect(() => userModel.toJson(), throwsA(isA<Exception>()));
    });

    test(
        "should throw an Exception when [UserModel] with all empty fields is converted to [JSON]",
        () {
      //user with empty id field
      final userModel = UserModel(id: '', name: '', email: '');
      expect(() => userModel.toJson(), throwsA(isA<Exception>()));
    });
  });
}

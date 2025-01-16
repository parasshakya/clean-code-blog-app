import 'package:clean_code_app/features/blog/data/models/blog_model.dart';
import 'package:clean_code_app/features/blog/domain/entities/blog.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late BlogModel validBlogModel;
  late Map<String, dynamic> validJson;
  late Blog validBlogEntity;

  setUpAll(() {
    validBlogModel = const BlogModel(
        id: "12",
        title: "title",
        content: "content",
        imageUrl: "imageUrl",
        topics: ["topic"],
        userId: "2312");

    validJson = {
      "_id": "12",
      "title": "title",
      "content": "content",
      "imageUrl": "imageUrl",
      "topics": ["topic"],
      "userId": "2312"
    };

    validBlogEntity = const Blog(
        id: "12",
        title: "title",
        content: "content",
        imageUrl: "imageUrl",
        topics: ["topic"],
        userId: "2312");
  });

  group("subclass test", () {
    test("[BlogModel] should be a subclass of [Blog] entity", () {
      //arrange
      //act

      //assert
      expect(validBlogModel, isA<Blog>());
    });
  });

  group("fromDomain", () {
    test('fromDomain should return a valid BlogModel from a Blog entity', () {
      // Act
      final result = BlogModel.fromDomain(validBlogEntity);

      // Assert
      expect(result, equals(validBlogModel));
    });
  });

  group("toDomain", () {
    test('toDomain should return a valid Blog entity from a BlogModel', () {
      // Act
      final result = validBlogModel.toDomain();

      // Assert
      expect(result, equals(validBlogEntity));
    });
  });

  group("fromJSON and toJSON Valid cases", () {
    group("fromJSON", () {
      test("should convert valid [JSON] to valid [BlogModel]", () {
        //Arrange

        //Act
        final result = BlogModel.fromJson(validJson);

        //Assert
        expect(result, equals(validBlogModel));
      });
    });
    group("toJSON", () {
      test("should convert valid [BlogModel] to valid [JSON]", () {
        //Arrange

        //Act
        final result = validBlogModel.toJson();

        //Assert
        expect(result, equals(validJson));
      });
    });
  });

  group("fromJSON and toJSON Invalid cases", () {
    group("fromJSON", () {
      test(
          "should throw an Exception when [JSON] with missing [title] is converted to [BlogModel]",
          () {
        //json with missing title field
        final json = {
          "_id": "12",
          "content": "content",
          "imageUrl": "imageUrl",
          "topics": ["topic"],
          "userId": "2312"
        };

        expect(() => BlogModel.fromJson(json), throwsA(isA<Exception>()));
      });

      test(
          "should throw an Exception when [JSON] with missing [id] is converted to [BlogModel]",
          () {
        //json with missing id field
        final json = {
          "content": "content",
          "imageUrl": "imageUrl",
          "topics": ["topic"],
          "userId": "2312",
          "title": "title"
        };

        expect(() => BlogModel.fromJson(json), throwsA(isA<Exception>()));
      });

      test(
          "should throw an Exception when [JSON] with missing [content] is converted to [BlogModel]",
          () {
        //json with missing content field
        final json = {
          "_id": "12",
          "title": "title",
          "imageUrl": "imageUrl",
          "topics": ["topic"],
          "userId": "2312"
        };

        expect(() => BlogModel.fromJson(json), throwsA(isA<Exception>()));
      });
      test(
          "should throw an Exception when [JSON] with missing [imageUrl] is converted to [BlogModel]",
          () {
        //json with missing imageUrl field
        final json = {
          "_id": "12",
          "title": "title",
          "content": "content",
          "topics": ["topic"],
          "userId": "2312"
        };

        expect(() => BlogModel.fromJson(json), throwsA(isA<Exception>()));
      });
      test(
          "should throw an Exception when [JSON] with missing [topics] is converted to [BlogModel]",
          () {
        //json with missing topics field
        final json = {
          "_id": "12",
          "title": "title",
          "content": "content",
          "userId": "2312",
          "imageUrl": "imageUrl"
        };

        expect(() => BlogModel.fromJson(json), throwsA(isA<Exception>()));
      });

      test(
          "should throw an Exception when [JSON] with missing [userId] is converted to [BlogModel]",
          () {
        //json with missing userId field
        final json = {
          "_id": "12",
          "title": "title",
          "content": "content",
          "imageUrl": "imageUrl",
          "topics": ["topic"]
        };

        expect(() => BlogModel.fromJson(json), throwsA(isA<Exception>()));
      });
      test(
          "should throw an Exception when empty [JSON] is converted to [BlogModel]",
          () {
        //json missing all fields
        final Map<String, dynamic> json = {};

        expect(() => BlogModel.fromJson(json), throwsA(isA<Exception>()));
      });
    });
    group("toJSON", () {
      test(
          "should throw an Exception when [BlogModel] with empty [id] is converted to [JSON]",
          () {
        //blog with empty id field
        const blogModel = BlogModel(
            id: '',
            title: 'title',
            content: 'content',
            imageUrl: 'imageUrl',
            topics: ['topics'],
            userId: '2312');
        expect(() => blogModel.toJson(), throwsA(isA<Exception>()));
      });
      test(
          "should throw an Exception when [BlogModel] with empty [content] is converted to [JSON]",
          () {
        //blog with empty content field
        const blogModel = BlogModel(
            id: '12',
            title: 'title',
            content: '',
            imageUrl: 'imageUrl',
            topics: ['topic'],
            userId: '2312');
        expect(() => blogModel.toJson(), throwsA(isA<Exception>()));
      });

      test(
          "should throw an Exception when [BlogModel] with empty [title] is converted to [JSON]",
          () {
        //blog with empty title field
        const blogModel = BlogModel(
            id: '12',
            title: '',
            content: 'content',
            imageUrl: 'imageUrl',
            topics: ['topic'],
            userId: '2312');

        expect(() => blogModel.toJson(), throwsA(isA<Exception>()));
      });
      test(
          "should throw an Exception when [BlogModel] with empty [imageUrl] is converted to [JSON]",
          () {
        //blog with empty imageUrl field
        const blogModel = BlogModel(
            id: '123',
            title: 'title',
            content: 'content',
            imageUrl: '',
            topics: ['topics'],
            userId: '2312');

        expect(() => blogModel.toJson(), throwsA(isA<Exception>()));
      });
      test(
          "should throw an Exception when [BlogModel] with empty [topics] is converted to [JSON]",
          () {
        //blog with empty topics field
        const blogModel = BlogModel(
            id: '123',
            title: 'title',
            content: 'content',
            imageUrl: 'imageUrl',
            topics: [],
            userId: '2312');
        expect(() => blogModel.toJson(), throwsA(isA<Exception>()));
      });
      test(
          "should throw an Exception when [BlogModel] with empty [userId] is converted to [JSON]",
          () {
        //blog with empty userId field
        const blogModel = BlogModel(
            id: '',
            title: 'title',
            content: 'content',
            imageUrl: 'imageUrl',
            topics: ['topics'],
            userId: '');
        expect(() => blogModel.toJson(), throwsA(isA<Exception>()));
      });

      test(
          "should throw an Exception when [BlogModel] with all empty fields is converted to [JSON]",
          () {
        //blog with all empty fields
        const blogModel = BlogModel(
            id: '',
            title: '',
            content: '',
            imageUrl: '',
            topics: [],
            userId: '');
        expect(() => blogModel.toJson(), throwsA(isA<Exception>()));
      });
    });
  });
}

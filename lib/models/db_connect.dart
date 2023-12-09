import 'package:http/http.dart' as http; // The http package
import './question_model.dart';
import 'dart:convert';

class DBconnect {
  // Create  a function to add a question to database.
  // Declare the name of the table to create and add .json as suffix
  final url = Uri.parse(
      'https://simplequizapp-af44b-default-rtdb.firebaseio.com/questions.json');

  // Fetch the data from database
  Future<List<Question>> fetchQuestions() async {
    // Got the data from just using this. Print it to see what got.
    return http.get(url).then((response) {
      // The 'then' method returns a 'response' which is data.
      // To whats inside have to decode it first.
      var data = json.decode(response.body) as Map<String, dynamic>;
      List<Question> newQuestions = [];
      data.forEach((key, value) {
        var newQuestion = Question(
          id: key, // The encrypted key/the title gave to data
          title: value['title'], // Title of the question
          options: Map.castFrom(value['options']), // Options of the question
        );
        // Add to newQuestions
        newQuestions.add(newQuestion);
      });
      return newQuestions;
    });
  }
}
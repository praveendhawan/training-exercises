$(function() {
  var requirement1 = {container: $('div.container:first'), min: 0, max: 10, totalQuestions: 2, timeLimit: 20, operators: ['+', '-'] };
  var requirement2 = {container: $('div.container:last'), min: 10, max: 20, totalQuestions: 5, timeLimit: 10, operators: ['+', '-', '*', '/'] };
  var quiz1 = new Quiz(requirement1);
  quiz1.init();
  var quiz2 = new Quiz(requirement2);
  quiz2.init();
})


// 1. maintain the collectoin of all question
// 2. try to run 2 quiz on a same page.
// 3. pass arguments to the quiz

// new Quiz({container: container, min: 4, max: 60, no_of_questions: 30, time: 5, operators: ['+', '-']})

function Quiz(argumentHash) {
  this.timerContainer = argumentHash.container.find('p.timer');
  this.questionContainer = argumentHash.container.find('div.label label');
  this.answerArea = argumentHash.container.find('.answer');
  this.nextButton = argumentHash.container.find('.btn-next');
  this.quitButton = argumentHash.container.find('.btn-quit');
  this.scoreboard = argumentHash.container.find('span.score');
  this.wrongquestionsContainer = argumentHash.container.find('div.wrongQuestions');
  this.min = argumentHash.min;
  this.max = argumentHash.max;
  this.totalQuestions = argumentHash.totalQuestions;
  this.timeLimit = argumentHash.timeLimit;
  this.operators = argumentHash.operators;
}

Quiz.prototype.init = function() {
  this.score = this.questionCounter = 0;
  this.bindEvents();
  this.resetTimer();
  this.questionsDetails = { quizQuestions: [] };
  this.showQuestion();
  this.intervalTimer = setInterval(this.setTimer(this), 1000);
};

Quiz.prototype.bindEvents = function() {
  this.nextButton.on('click', this.trackScore());
};

Quiz.prototype.showQuestion = function() {
  // make questionsDetails to a json/hash so that you can have something like {quizQuestions: [{question: question object, user_answer: useranswer}]}
  this.currentQuestion = this.generateQuestion();
  this.resetQuizArea();
  this.questionCounter++;
};

Quiz.prototype.generateQuestion = function() {
  return (new Question(this.min, this.max, this.operators));
};

Quiz.prototype.resetQuizArea = function() {
  this.questionContainer.text(this.currentQuestion.question);
  this.answerArea.val('').trigger('focus');
  this.resetTimer();
};

Quiz.prototype.resetTimer = function() {
  this.timeLeft = this.timeLimit;
  this.timerContainer.text(this.timeLeft);
};

Quiz.prototype.setTimer = function(quizScope) {
  return function() {
    if(quizScope.timeLeft) {
      quizScope.timerContainer.text(--quizScope.timeLeft);
    } else {
      quizScope.resetTimer();
      quizScope.storeUserAnswer();
      quizScope.showQuestion();
    }
  }
};

Quiz.prototype.trackScore = function() {
  var _this = this;
  return function() {
    _this.storeUserAnswer();
    _this.incrementScore();
    _this.questionsDetails.quizQuestions.length < _this.totalQuestions ? _this.showQuestion() : _this.showResult();
  }
};

Quiz.prototype.storeUserAnswer = function() {
  var user_answer = this.answerArea.val() ? this.answerArea.val() : undefined;
  this.questionsDetails.quizQuestions.push({
    question: this.currentQuestion,
    userAnswer: user_answer
  });
  console.log(this.questionsDetails)
};

Quiz.prototype.incrementScore = function() {
  if(this.evaluateUserAnswer(this.questionCounter - 1)) {
    this.scoreboard.text(++this.score);
  }
};

Quiz.prototype.evaluateUserAnswer = function(index) {
  return (this.questionsDetails.quizQuestions[index].question.actualResult == this.questionsDetails.quizQuestions[index].userAnswer)
};

Quiz.prototype.showResult = function() {
  alert(this.score);
  window.clearInterval(this.intervalTimer);
  this.wrongquestionsContainer.siblings(':not(#wrongQuestions, #wrongQuestions p, h2)').remove();
  this.showWrongAnsweredQuestions();
};

Quiz.prototype.showWrongAnsweredQuestions = function() {
  var _this = this;
  $(this.questionsDetails.quizQuestions).each(function(index, element) {
    if(!_this.evaluateUserAnswer(index)) {
      _this.wrongquestionsContainer.append($('<p/>', { text: `Question: ${ this.question.question } Result: ${ this.question.actualResult } Your Answer: ${ this.userAnswer }` }));
    }
  })
};
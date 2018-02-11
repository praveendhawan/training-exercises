function User(name, age){
  this.name = name;
  this.age = age;
}

User.prototype.compare = function(user) {
  var content = `${ user.name } is older than ${ this.name }`;
  if (this.age > user.age) {
    content = `${ this.name } is older than ${ user.name }`;
  };
  document.getElementById("show").innerHTML = content;
}

window.onload = function(){
  user1 = new User("Ram", 21);
  user2 = new User("Shyam", 34);
  user1.compare(user2);
};
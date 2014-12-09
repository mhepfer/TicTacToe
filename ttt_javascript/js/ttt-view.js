(function () {
  if (typeof TTT === "undefined") {
    window.TTT = {};
  }

  var View = TTT.View = function (game, $el) {
    this.game = game;
    this.$el = $el;
    this.bindEvents();
    this.grid = this.setupBoard();
  };

  View.prototype.bindEvents = function () {
    this.$el.on("click", ".square", this.makeMove.bind(this));
  };

  View.prototype.makeMove = function ($square) {
    var $currentSquare = $($square.currentTarget);

    var posString = $currentSquare.data("pos");
    var arr = posString.split(",")
    var row = parseInt(arr[0]);
    var col = parseInt(arr[1]);
    
    var pos = [row, col];
    try{
      this.game.playMove(pos);
    } catch(err) {
      alert("That is not a valid move")
    }
    var color = "";
    if(this.game.currentPlayer === "x"){
      color = 'red';
    } else {
      color = 'blue';
    }
    
    $currentSquare.css("background", color)
    if(this.game.isOver()){
      var winner = this.game.board.winner();
      if(winner){
         alert("game over: " + color +" wins! ");
      }else{
        alert("game over: cat's game")
      }
      this.$el.off("click");
    }
  };

  View.prototype.setupBoard = function () {
    var boardString = "";
    for(var i = 0; i < 3; i++){
      boardString += "<div class='row'>";
      for(var j = 0; j < 3; j++ ){
        var pos = [i,j]
        boardString += "<div class='square' data-pos="+ pos + "></div>";
      }
      boardString += "</div>";
    }
    return this.$el.html(boardString);
  };
})();

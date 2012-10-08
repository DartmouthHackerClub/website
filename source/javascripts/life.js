// Generated by CoffeeScript 1.3.3
(function() {
  var GameOfLife,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  GameOfLife = (function() {

    GameOfLife.prototype.currentCellGeneration = null;

    GameOfLife.prototype.changeList = [];

    GameOfLife.prototype.cellSize = 20;

    GameOfLife.prototype.numberOfRows = null;

    GameOfLife.prototype.numberOfColumns = null;

    GameOfLife.prototype.tickLength = 40;

    GameOfLife.prototype.spawnProbability = 0.3;

    GameOfLife.prototype.fadeSteps = 10;

    GameOfLife.prototype.canvas = null;

    GameOfLife.prototype.drawingContext = null;

    function GameOfLife() {
      this.tick = __bind(this.tick, this);
      this.createCanvas();
      this.resizeCanvas();
      this.createDrawingContext();
      this.seed();
      this.buildGliderGun();
      this.tick();
    }

    GameOfLife.prototype.createCanvas = function() {
      this.canvas = document.createElement('canvas');
      this.canvas.id = "life";
      return $("#hero").prepend(this.canvas);
    };

    GameOfLife.prototype.resizeCanvas = function() {
      var cols, documentHeight, documentWidth, rows;
      documentHeight = $("#hero").height();
      documentWidth = $("#hero").width();
      this.canvas.height = documentHeight;
      this.canvas.width = documentWidth;
      rows = Math.ceil(documentHeight / this.cellSize);
      cols = Math.ceil(documentWidth / this.cellSize);
      if (this.currentCellGeneration != null) {
        this.resizeGrid(rows, cols);
        return this.redrawGrid();
      } else {
        this.numberOfRows = rows;
        return this.numberOfColumns = cols;
      }
    };

    GameOfLife.prototype.resizeGrid = function(rows, cols) {
      var column, newCellGeneration, row, _i, _j;
      newCellGeneration = [];
      for (row = _i = 0; 0 <= rows ? _i < rows : _i > rows; row = 0 <= rows ? ++_i : --_i) {
        newCellGeneration[row] = [];
        for (column = _j = 0; 0 <= cols ? _j < cols : _j > cols; column = 0 <= cols ? ++_j : --_j) {
          if ((this.currentCellGeneration[row] != null) && (this.currentCellGeneration[row][column] != null)) {
            newCellGeneration[row][column] = this.currentCellGeneration[row][column];
          } else {
            newCellGeneration[row][column] = this.createSeedCell(row, column);
          }
        }
      }
      this.currentCellGeneration = newCellGeneration;
      this.numberOfRows = rows;
      return this.numberOfColumns = cols;
    };

    GameOfLife.prototype.handleClick = function(e) {
      var column, row;
      column = Math.floor(e.offsetX / this.cellSize);
      row = Math.floor(e.offsetY / this.cellSize);
      return this.currentCellGeneration[row][column].count = this.fadeSteps;
    };

    GameOfLife.prototype.createDrawingContext = function() {
      return this.drawingContext = this.canvas.getContext('2d');
    };

    GameOfLife.prototype.seed = function() {
      var column, row, seedCell, _i, _ref, _results;
      this.currentCellGeneration = [];
      _results = [];
      for (row = _i = 0, _ref = this.numberOfRows; 0 <= _ref ? _i < _ref : _i > _ref; row = 0 <= _ref ? ++_i : --_i) {
        this.currentCellGeneration[row] = [];
        _results.push((function() {
          var _j, _ref1, _results1;
          _results1 = [];
          for (column = _j = 0, _ref1 = this.numberOfColumns; 0 <= _ref1 ? _j < _ref1 : _j > _ref1; column = 0 <= _ref1 ? ++_j : --_j) {
            seedCell = this.createSeedCell(row, column);
            this.currentCellGeneration[row][column] = seedCell;
            _results1.push(this.changeList.push(seedCell));
          }
          return _results1;
        }).call(this));
      }
      return _results;
    };

    GameOfLife.prototype.createSeedCell = function(row, column) {
      return {
        count: 0,
        row: row,
        column: column
      };
    };

    GameOfLife.prototype.buildGliderGun = function() {
      var xcenter, ycenter;
      if (this.numberOfRows < 37) {
        this.cellSize = Math.floor($("#hero").height() / 37);
        this.resizeCanvas();
      }
      if (this.numberOfColumns < 13) {
        this.cellSize = Math.floor($("#hero").width() / 15);
        this.resizeCanvas();
      }
      xcenter = Math.floor((this.numberOfColumns - 13) / 4);
      ycenter = Math.floor((this.numberOfRows - 37) / 4);
      this.currentCellGeneration[ycenter][xcenter + 2].count = this.fadeSteps;
      this.currentCellGeneration[ycenter][xcenter + 3].count = this.fadeSteps;
      this.currentCellGeneration[ycenter + 1][xcenter + 2].count = this.fadeSteps;
      this.currentCellGeneration[ycenter + 1][xcenter + 3].count = this.fadeSteps;
      this.currentCellGeneration[ycenter + 8][xcenter + 3].count = this.fadeSteps;
      this.currentCellGeneration[ycenter + 8][xcenter + 4].count = this.fadeSteps;
      this.currentCellGeneration[ycenter + 9][xcenter + 2].count = this.fadeSteps;
      this.currentCellGeneration[ycenter + 9][xcenter + 4].count = this.fadeSteps;
      this.currentCellGeneration[ycenter + 10][xcenter + 2].count = this.fadeSteps;
      this.currentCellGeneration[ycenter + 10][xcenter + 3].count = this.fadeSteps;
      this.currentCellGeneration[ycenter + 16][xcenter + 4].count = this.fadeSteps;
      this.currentCellGeneration[ycenter + 16][xcenter + 5].count = this.fadeSteps;
      this.currentCellGeneration[ycenter + 16][xcenter + 6].count = this.fadeSteps;
      this.currentCellGeneration[ycenter + 17][xcenter + 4].count = this.fadeSteps;
      this.currentCellGeneration[ycenter + 18][xcenter + 5].count = this.fadeSteps;
      this.currentCellGeneration[ycenter + 22][xcenter + 1].count = this.fadeSteps;
      this.currentCellGeneration[ycenter + 22][xcenter + 2].count = this.fadeSteps;
      this.currentCellGeneration[ycenter + 23][xcenter + 0].count = this.fadeSteps;
      this.currentCellGeneration[ycenter + 23][xcenter + 2].count = this.fadeSteps;
      this.currentCellGeneration[ycenter + 24][xcenter + 0].count = this.fadeSteps;
      this.currentCellGeneration[ycenter + 24][xcenter + 1].count = this.fadeSteps;
      this.currentCellGeneration[ycenter + 24][xcenter + 12].count = this.fadeSteps;
      this.currentCellGeneration[ycenter + 24][xcenter + 13].count = this.fadeSteps;
      this.currentCellGeneration[ycenter + 25][xcenter + 12].count = this.fadeSteps;
      this.currentCellGeneration[ycenter + 25][xcenter + 14].count = this.fadeSteps;
      this.currentCellGeneration[ycenter + 26][xcenter + 12].count = this.fadeSteps;
      this.currentCellGeneration[ycenter + 34][xcenter].count = this.fadeSteps;
      this.currentCellGeneration[ycenter + 34][xcenter + 1].count = this.fadeSteps;
      this.currentCellGeneration[ycenter + 35][xcenter].count = this.fadeSteps;
      this.currentCellGeneration[ycenter + 35][xcenter + 1].count = this.fadeSteps;
      this.currentCellGeneration[ycenter + 35][xcenter + 7].count = this.fadeSteps;
      this.currentCellGeneration[ycenter + 35][xcenter + 8].count = this.fadeSteps;
      this.currentCellGeneration[ycenter + 35][xcenter + 9].count = this.fadeSteps;
      this.currentCellGeneration[ycenter + 36][xcenter + 7].count = this.fadeSteps;
      return this.currentCellGeneration[ycenter + 37][xcenter + 8].count = this.fadeSteps;
    };

    GameOfLife.prototype.randomizeFirstQuadrant = function() {
      var column, row, _i, _ref, _results;
      _results = [];
      for (row = _i = 0, _ref = Math.floor(this.numberOfRows / 2); 0 <= _ref ? _i < _ref : _i > _ref; row = 0 <= _ref ? ++_i : --_i) {
        _results.push((function() {
          var _j, _ref1, _ref2, _results1;
          _results1 = [];
          for (column = _j = _ref1 = Math.floor(this.numberOfColumns / 2), _ref2 = this.numberOfColumns; _ref1 <= _ref2 ? _j < _ref2 : _j > _ref2; column = _ref1 <= _ref2 ? ++_j : --_j) {
            _results1.push(this.currentCellGeneration[row][column].count = (Math.random() < this.spawnProbability) * this.fadeSteps);
          }
          return _results1;
        }).call(this));
      }
      return _results;
    };

    GameOfLife.prototype.drawGrid = function() {
      var cell, _i, _len, _ref;
      _ref = this.changeList;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        cell = _ref[_i];
        this.drawCell(cell);
      }
      return this.changeList = [];
    };

    GameOfLife.prototype.redrawGrid = function() {
      var column, row, _i, _ref, _results;
      _results = [];
      for (row = _i = 0, _ref = this.numberOfRows; 0 <= _ref ? _i < _ref : _i > _ref; row = 0 <= _ref ? ++_i : --_i) {
        _results.push((function() {
          var _j, _ref1, _results1;
          _results1 = [];
          for (column = _j = 0, _ref1 = this.numberOfColumns; 0 <= _ref1 ? _j < _ref1 : _j > _ref1; column = 0 <= _ref1 ? ++_j : --_j) {
            _results1.push(this.drawCell(this.currentCellGeneration[row][column]));
          }
          return _results1;
        }).call(this));
      }
      return _results;
    };

    GameOfLife.prototype.drawCell = function(cell) {
      var fillStyle, green, x, y;
      x = cell.column * this.cellSize;
      y = cell.row * this.cellSize;
      green = Math.round((cell.count / this.fadeSteps) * 255);
      fillStyle = "rgb(0, " + green + ", 0)";
      this.drawingContext.strokeStyle = 'rgba(0, 255, 0, 0.4)';
      this.drawingContext.strokeRect(x, y, this.cellSize, this.cellSize);
      this.drawingContext.fillStyle = fillStyle;
      return this.drawingContext.fillRect(x, y, this.cellSize, this.cellSize);
    };

    GameOfLife.prototype.tick = function() {
      this.drawGrid();
      this.evolveCellGeneration();
      return setTimeout(this.tick, this.tickLength);
    };

    GameOfLife.prototype.evolveCellGeneration = function() {
      var column, currentCell, evolvedCell, newCellGeneration, row, _i, _j, _ref, _ref1;
      newCellGeneration = [];
      for (row = _i = 0, _ref = this.numberOfRows; 0 <= _ref ? _i < _ref : _i > _ref; row = 0 <= _ref ? ++_i : --_i) {
        newCellGeneration[row] = [];
        for (column = _j = 0, _ref1 = this.numberOfColumns; 0 <= _ref1 ? _j < _ref1 : _j > _ref1; column = 0 <= _ref1 ? ++_j : --_j) {
          currentCell = this.currentCellGeneration[row][column];
          if (!(currentCell != null)) {
            return;
          }
          evolvedCell = this.evolveCell(currentCell);
          newCellGeneration[row][column] = evolvedCell;
          if (currentCell.count !== evolvedCell.count) {
            this.changeList.push(evolvedCell);
          }
        }
      }
      return this.currentCellGeneration = newCellGeneration;
    };

    GameOfLife.prototype.evolveCell = function(cell) {
      var evolvedCell, numberOfAliveNeighbors;
      evolvedCell = {
        count: cell.count,
        row: cell.row,
        column: cell.column
      };
      numberOfAliveNeighbors = this.countAliveNeighbors(cell);
      if ((cell.count === this.fadeSteps || numberOfAliveNeighbors === 3) && ((1 < numberOfAliveNeighbors && numberOfAliveNeighbors < 4))) {
        evolvedCell.count = this.fadeSteps;
      } else {
        evolvedCell.count = Math.max(0, cell.count - 1);
      }
      return evolvedCell;
    };

    GameOfLife.prototype.countAliveNeighbors = function(cell) {
      var column, currentCell, lowerColumnBound, lowerRowBound, numberOfAliveNeighbors, row, upperColumnBound, upperRowBound, _i, _j;
      lowerRowBound = Math.max(cell.row - 1, 0);
      upperRowBound = Math.min(cell.row + 1, this.numberOfRows - 1);
      lowerColumnBound = Math.max(cell.column - 1, 0);
      upperColumnBound = Math.min(cell.column + 1, this.numberOfColumns - 1);
      numberOfAliveNeighbors = 0;
      for (row = _i = lowerRowBound; lowerRowBound <= upperRowBound ? _i <= upperRowBound : _i >= upperRowBound; row = lowerRowBound <= upperRowBound ? ++_i : --_i) {
        for (column = _j = lowerColumnBound; lowerColumnBound <= upperColumnBound ? _j <= upperColumnBound : _j >= upperColumnBound; column = lowerColumnBound <= upperColumnBound ? ++_j : --_j) {
          if (row === cell.row && column === cell.column) {
            continue;
          }
          currentCell = this.currentCellGeneration[row][column];
          if ((currentCell != null) && currentCell.count === this.fadeSteps) {
            numberOfAliveNeighbors++;
          }
        }
      }
      return numberOfAliveNeighbors;
    };

    return GameOfLife;

  })();

  $(function() {
    var life, mouseDown;
    life = new GameOfLife();
    $(window).resize(function(e) {
      return life.resizeCanvas();
    });
    mouseDown = false;
    $(life.canvas).mousedown(function(e) {
      mouseDown = true;
      life.handleClick(e);
      return $(life.canvas).addClass("mouseDown");
    });
    $(life.canvas).mouseup(function(e) {
      mouseDown = false;
      return $(life.canvas).removeClass("mouseDown");
    });
    $(life.canvas).mousemove(function(e) {
      if (mouseDown) {
        return life.handleClick(e);
      }
    });
    return life.canvas.onselectstart = function() {
      return false;
    };
  });

}).call(this);

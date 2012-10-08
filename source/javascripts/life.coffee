class GameOfLife
	currentCellGeneration: null
	changeList: []
	cellSize: 20
	numberOfRows: null
	numberOfColumns: null
	tickLength: 40
	spawnProbability: 0.3
	fadeSteps: 10
	canvas: null
	drawingContext: null

	constructor: ->
		@createCanvas()
		@resizeCanvas()
		@createDrawingContext()

		@seed()
		@buildGliderGun()
		@tick()

	createCanvas: ->
		@canvas = document.createElement 'canvas'
		@canvas.id = "life"
		$("#hero").prepend @canvas

	resizeCanvas: ->
		documentHeight = $("#hero").height()
		documentWidth = $("#hero").width()
		@canvas.height = documentHeight
		@canvas.width = documentWidth
		rows = Math.ceil(documentHeight / @cellSize)
		cols = Math.ceil(documentWidth / @cellSize)
		if @currentCellGeneration?
			@resizeGrid(rows, cols)
			@redrawGrid()
		else
			@numberOfRows = rows
			@numberOfColumns = cols

	resizeGrid: (rows, cols) ->
		newCellGeneration = []

		for row in [0...rows]
			newCellGeneration[row] = []

			for column in [0...cols]
				if @currentCellGeneration[row]? and @currentCellGeneration[row][column]?
					newCellGeneration[row][column] = @currentCellGeneration[row][column]
				else
					newCellGeneration[row][column] = @createSeedCell row, column

		@currentCellGeneration = newCellGeneration
		@numberOfRows = rows
		@numberOfColumns = cols

	handleClick: (e) ->
		console.log e
		column = Math.floor(e.offsetX / @cellSize)
		row = Math.floor(e.offsetY / @cellSize)
		@currentCellGeneration[row][column].count = @fadeSteps

	createDrawingContext: ->
		@drawingContext = @canvas.getContext '2d'

	seed: ->
		@currentCellGeneration = []

		for row in [0...@numberOfRows]
			@currentCellGeneration[row] = []

			for column in [0...@numberOfColumns]
				seedCell = @createSeedCell row, column
				@currentCellGeneration[row][column] = seedCell
				@changeList.push(seedCell)

	createSeedCell: (row, column) ->
		count: 0
		row: row
		column: column

	buildGliderGun: ->
		if @numberOfRows < 37
			@cellSize = Math.floor $("#hero").height() / 37
			@resizeCanvas()
		if @numberOfColumns < 13
			@cellSize = Math.floor $("#hero").width() / 15
			@resizeCanvas()

		xcenter = Math.floor((@numberOfColumns - 13) / 4)
		ycenter = Math.floor((@numberOfRows - 37) / 4)
		@currentCellGeneration[ycenter][xcenter+2].count = @fadeSteps
		@currentCellGeneration[ycenter][xcenter+3].count = @fadeSteps
		@currentCellGeneration[ycenter+1][xcenter+2].count = @fadeSteps
		@currentCellGeneration[ycenter+1][xcenter+3].count = @fadeSteps
		@currentCellGeneration[ycenter+8][xcenter+3].count = @fadeSteps
		@currentCellGeneration[ycenter+8][xcenter+4].count = @fadeSteps
		@currentCellGeneration[ycenter+9][xcenter+2].count = @fadeSteps
		@currentCellGeneration[ycenter+9][xcenter+4].count = @fadeSteps
		@currentCellGeneration[ycenter+10][xcenter+2].count = @fadeSteps
		@currentCellGeneration[ycenter+10][xcenter+3].count = @fadeSteps
		@currentCellGeneration[ycenter+16][xcenter+4].count = @fadeSteps
		@currentCellGeneration[ycenter+16][xcenter+5].count = @fadeSteps
		@currentCellGeneration[ycenter+16][xcenter+6].count = @fadeSteps
		@currentCellGeneration[ycenter+17][xcenter+4].count = @fadeSteps
		@currentCellGeneration[ycenter+18][xcenter+5].count = @fadeSteps
		@currentCellGeneration[ycenter+22][xcenter+1].count = @fadeSteps
		@currentCellGeneration[ycenter+22][xcenter+2].count = @fadeSteps
		@currentCellGeneration[ycenter+23][xcenter+0].count = @fadeSteps
		@currentCellGeneration[ycenter+23][xcenter+2].count = @fadeSteps
		@currentCellGeneration[ycenter+24][xcenter+0].count = @fadeSteps
		@currentCellGeneration[ycenter+24][xcenter+1].count = @fadeSteps
		@currentCellGeneration[ycenter+24][xcenter+12].count = @fadeSteps
		@currentCellGeneration[ycenter+24][xcenter+13].count = @fadeSteps
		@currentCellGeneration[ycenter+25][xcenter+12].count = @fadeSteps
		@currentCellGeneration[ycenter+25][xcenter+14].count = @fadeSteps
		@currentCellGeneration[ycenter+26][xcenter+12].count = @fadeSteps
		@currentCellGeneration[ycenter+34][xcenter].count = @fadeSteps
		@currentCellGeneration[ycenter+34][xcenter+1].count = @fadeSteps
		@currentCellGeneration[ycenter+35][xcenter].count = @fadeSteps
		@currentCellGeneration[ycenter+35][xcenter+1].count = @fadeSteps
		@currentCellGeneration[ycenter+35][xcenter+7].count = @fadeSteps
		@currentCellGeneration[ycenter+35][xcenter+8].count = @fadeSteps
		@currentCellGeneration[ycenter+35][xcenter+9].count = @fadeSteps
		@currentCellGeneration[ycenter+36][xcenter+7].count = @fadeSteps
		@currentCellGeneration[ycenter+37][xcenter+8].count = @fadeSteps

	randomizeFirstQuadrant: ->
		for row in [0...Math.floor(@numberOfRows / 2)]
			for column in [Math.floor(@numberOfColumns / 2)...@numberOfColumns]
				@currentCellGeneration[row][column].count = (Math.random() < @spawnProbability) * @fadeSteps

	drawGrid: ->
		for cell in @changeList
			@drawCell cell

		@changeList = []
	
	redrawGrid: ->
		for row in [0...@numberOfRows]
			for column in [0...@numberOfColumns]
				@drawCell @currentCellGeneration[row][column]

	drawCell: (cell) ->
		x = cell.column * @cellSize
		y = cell.row * @cellSize

		green = Math.round (cell.count / @fadeSteps) * 255
		fillStyle = "rgb(0, #{green}, 0)"

		@drawingContext.strokeStyle = 'rgba(0, 255, 0, 0.4)'
		@drawingContext.strokeRect x, y, @cellSize, @cellSize

		@drawingContext.fillStyle = fillStyle
		@drawingContext.fillRect x, y, @cellSize, @cellSize

	tick: =>
		@drawGrid()
		@evolveCellGeneration()

		setTimeout @tick, @tickLength

	evolveCellGeneration: ->
		newCellGeneration = []

		for row in [0...@numberOfRows]
			newCellGeneration[row] = []

			for column in [0...@numberOfColumns]
				currentCell = @currentCellGeneration[row][column]
				if not currentCell?
					return
				evolvedCell = @evolveCell currentCell
				newCellGeneration[row][column] = evolvedCell
				if currentCell.count != evolvedCell.count
					@changeList.push evolvedCell

		@currentCellGeneration = newCellGeneration

	evolveCell: (cell) ->
		evolvedCell =
			count: cell.count
			row: cell.row
			column: cell.column

		numberOfAliveNeighbors = @countAliveNeighbors cell

		if (cell.count is @fadeSteps or numberOfAliveNeighbors is 3) and (1 < numberOfAliveNeighbors < 4)
			evolvedCell.count = @fadeSteps
		else
			evolvedCell.count = Math.max(0, cell.count - 1)

		evolvedCell

	countAliveNeighbors: (cell) ->
		lowerRowBound = Math.max cell.row - 1, 0
		upperRowBound = Math.min cell.row + 1, @numberOfRows - 1
		lowerColumnBound = Math.max cell.column - 1, 0
		upperColumnBound = Math.min cell.column + 1, @numberOfColumns - 1
		numberOfAliveNeighbors = 0

		for row in [lowerRowBound..upperRowBound]
			for column in [lowerColumnBound..upperColumnBound]
				continue if row is cell.row and column is cell.column

				currentCell = @currentCellGeneration[row][column]
				if currentCell? and currentCell.count is @fadeSteps
					numberOfAliveNeighbors++

		numberOfAliveNeighbors

$ ->
	life = new GameOfLife()
	$(window).resize (e) ->
		life.resizeCanvas()

	mouseDown = false
	$(life.canvas).mousedown (e) ->
		mouseDown = true
		life.handleClick(e)
	$(life.canvas).mouseup (e) ->
		mouseDown = false
	$(life.canvas).mousemove (e) ->
		if mouseDown
			life.handleClick(e)


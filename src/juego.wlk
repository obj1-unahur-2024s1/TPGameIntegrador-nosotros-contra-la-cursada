import wollok.game.*
object juego {
	var puntaje = 0
	var juegoFinalizado = false
	method puntaje(){
		return puntaje
	}
	method inicio(){
        game.title("collect	Coins")
		game.boardGround("fondo.jpg")
		game.cellSize(110)
		game.width(14)
		game.height(10)
	
	}
	
}

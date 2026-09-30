extends Node2D

@onready var board = get_node("board")
@onready var labelResult = get_node("labelResult")
var turn_player : bool = true
var p1 : Player
var p2 : Player
var deck

var game_over : bool = false


func generate_deck():
	var naipes = ["Copas", "Espadas", "Ouro", "Paus"]
	var cards = []
	
	# for iterador in objeto_iterado
	for naipe in naipes:
		for num in range(1, 14):
			cards.append( Card.new( num, naipe ) )
	return cards
func _ready():
	deck = generate_deck()
	p1 = Player.new("A")
	p2 = Player.new("B")
	update_board()

func update_board():
	board.text = "Vez do jogador A" if turn_player else "Vez do jogador B"
	board.text += " | Jogador A: "+ str(p1.score) +" | Jogador B: "+ str(p2.score) +"\n"
	board.text += "Mão A: " + p1.show_hand() + '\n'
	board.text += "Mão B: " + p2.show_hand() + '\n'
	board.text += "PLACAR - P1: " + str(p1.wins) + " x P2: " + str(p2.wins) + "\n"

func _on_btn_pull_button_up() -> void:
	if game_over:
		return
	if( turn_player ):
		p1.take_card( deck )
	else:
		p2.take_card( deck )
	turn_player = not turn_player

	if( p1.score == 21 or p2.score > 21 ):
		labelResult.text = 'P1 venceu'
		p1.wins += 1
		game_over = true
	elif( p2.score == 21 or p1.score > 21 ):
		labelResult.text = 'P2 venceu'
		p2.wins += 1
		game_over = true
	update_board()

func _on_btn_keep_button_up() -> void:
	if game_over:
		return
	turn_player = not turn_player
	update_board()

func _on_btn_reset_button_up() -> void:
	deck = generate_deck()
	p1.hand = []
	p2.hand = []
	p1.score = 0
	p2.score = 0
	game_over = false
	labelResult.text = ''
	update_board()

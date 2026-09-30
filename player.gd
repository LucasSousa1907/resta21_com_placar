class_name Player

var nickname: String
var hand: Array = []
var score: int = 0

var wins: int = 0

func _init( nickname ) -> void:
	self.nickname = nickname
	self.hand = []
	self.score = 0
	
func take_card( deck ):
	self.hand.append( deck[0] )
	self.score += deck[0].score
	deck.remove_at( 0 )

func show_hand():
	var view_cards = ''
	for card in self.hand:
		view_cards += card.title + " | "
	return view_cards

func reset():
	self.hand = []
	self.score = 0

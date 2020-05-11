class Turn
  attr_reader :player1,
              :player2,
              :spoils_of_war

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
  end

  def basic_type
    player1.deck.rank_of_card_at(0) != player2.deck.rank_of_card_at(0) 
  end

  def war_type
    player1.deck.rank_of_card_at(0) == player2.deck.rank_of_card_at(0) &&
    player1.deck.rank_of_card_at(2) != player2.deck.rank_of_card_at(2)
  end

  def mutually_assured_destruction_type
    player1.deck.rank_of_card_at(0) == player2.deck.rank_of_card_at(0) &&
    player1.deck.rank_of_card_at(2) == player2.deck.rank_of_card_at(2)
  end

  def type
    if mutually_assured_destruction_type
      :mutually_assured_destruction
    elsif war_type
      :war
    elsif basic_type
      :basic
    end
  end

  def winner
    if war_type
      if player1.deck.rank_of_card_at(2) > player2.deck.rank_of_card_at(2)
        player1
      else
        player2
    end
    elsif basic_type
      if player1.deck.rank_of_card_at(0) > player2.deck.rank_of_card_at(0)
        player1
      else
        player2
      end
    elsif mutually_assured_destruction_type
      "No Winner"
    end
  end

  def pile_cards
    if basic_type
      @spoils_of_war << player1.deck.remove_card
      @spoils_of_war << player2.deck.remove_card
    elsif war_type
      @spoils_of_war << player1.deck.cards.shift(3)
      @spoils_of_war << player2.deck.cards.shift(3)
      @spoils_of_war.flatten!
    else
      player1.deck.cards.shift(3)
      player2.deck.cards.shift(3)
    end
  end

  def award_spoils(winner)
    awarded = winner.deck.cards << @spoils_of_war
    awarded.flatten!
  end
end

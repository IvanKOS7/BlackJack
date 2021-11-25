class Hand
  attr_accessor :hand

  def initialize(hand = [])
    @hand = hand
  end

  def scores(cards_array, instance_var, score)
    score_numbers ||= 0
    cards_array.each do |value|
      value_int = value.gsub(/[\u2660\u2665\u2663\u2666]/, '')
      value_card = value_int.to_i
      score_numbers += if value_card != 0
                         value_card
                       elsif value_int !~ /a/
                         10
                       elsif instance_var.send(score.to_s) <= 21
                         11
                       else
                         1
                       end
    end
    instance_var.send("#{score}=", score_numbers)
  end
end

class Hand
  attr_accessor :hand

  def initialize(hand = [])
    @hand = hand
  end

  def scores(hand_arr, instance_var, get_score)
    score_numbers ||= 0
    hand_arr.each do |value|
      value_card = value.card_value
      value_number = value_card.to_i
      score_numbers += if value_number != 0
                         value_number
                       elsif value_card !~ /a/
                         10
                       elsif (instance_var.send(get_score.to_s) + 11) <= 21
                         11
                       else
                         1
                       end
    end
    instance_var.send("#{get_score}=", score_numbers)
  end
end

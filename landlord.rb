deck = *(1..23)

deck << 'white'
deck << 'white'
deck << 'white'
deck << 'white'
deck << 'white'
deck << 'white'
deck << 'white'
deck << 'all'
deck << 'white/red'
deck << 'red'

deck << 'white/black'
deck << 'white/black'

deck << 'red'
deck << 'black'
deck << 'black'
deck << 'black'

white_in_opening_hand = 0
black_in_opening_hand = 0
red_in_opening_hand = 0

white_by_turn_5 = 0
black_by_turn_5 = 0
red_by_turn_5 = 0

occurance_wbt5 = 0
occurance_bbt5 = 0
occurance_rbt5 = 0

total_lands = 0

RUNS = 10000

RUNS.times do 
  num_lands = 0
  while (num_lands == 0) || (num_lands == 7)
    a = deck.shuffle
    num_lands = a[0..6].tally.each.reject {|keypair| keypair[0].class.to_s == "Integer"}.sum {|arr| arr[1]}
  end
  # only evaluate a free one
  if num_lands < 3 
    num_lands = 0
    while (num_lands == 0) || (num_lands == 7)
      a = deck.shuffle
      num_lands = a[0..6].tally.each.reject {|keypair| keypair[0].class.to_s == "Integer"}.sum {|arr| arr[1]}
    end
  end
  first_five_turns = a[0..11].tally
  total_lands += first_five_turns.each.reject {|keypair| keypair[0].class.to_s == "Integer"}.sum {|arr| arr[1]}
  lands = a[0..6].tally
  white_in_opening_hand += lands['white'].to_i + lands['white/black'].to_i + lands['white/red'].to_i + lands['all'].to_i
  black_in_opening_hand += lands['black'].to_i + lands['white/black'].to_i + lands['all'].to_i
  red_in_opening_hand += lands['red'].to_i + lands['white/red'].to_i + lands['all'].to_i

  white_by_turn_5 += first_five_turns['white'].to_i + first_five_turns['white/black'].to_i + first_five_turns['white/red'].to_i + first_five_turns['all'].to_i
  black_by_turn_5 += first_five_turns['black'].to_i + first_five_turns['white/black'].to_i + first_five_turns['all'].to_i
  red_by_turn_5 += first_five_turns['red'].to_i + first_five_turns['white/red'].to_i + first_five_turns['all'].to_i

  occurance_wbt5 += 1 if (first_five_turns['white'].to_i + first_five_turns['white/black'].to_i + first_five_turns['white/red'].to_i + first_five_turns['all'].to_i > 0) 
  occurance_bbt5 += 1 if (first_five_turns['black'].to_i + first_five_turns['white/black'].to_i + first_five_turns['all'].to_i > 0) 
  occurance_rbt5 += 1 if (first_five_turns['red'].to_i + first_five_turns['white/red'].to_i + first_five_turns['all'].to_i > 0) 
end

puts "Average # of white sources in opening hand: #{white_in_opening_hand / RUNS.to_f}"
puts "Average # of black sources in opening hand: #{black_in_opening_hand / RUNS.to_f}"
puts "Average # of red sources in opening hand: #{red_in_opening_hand / RUNS.to_f}"
puts "---------"
puts "% games with white source in first 5 turns: #{occurance_wbt5 / RUNS.to_f}"
puts "% games with black source in first 5 turns: #{occurance_bbt5 / RUNS.to_f}"
puts "% games with red source in first 5 turns: #{occurance_rbt5 / RUNS.to_f}"
puts "---------"
puts "Average number of lands drawn by turn 5: #{total_lands / RUNS.to_f}"



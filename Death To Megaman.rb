run_file '/Users/xlogicx/Documents/sonic/NESSFX/Game Sound Demos/players.rb'
use_bpm 40
use_random_seed 27
beats = 0.0625
reverse_max = 3    # How long can a phrase be to be considered for reversal.

#0:2 - Kick/Crash
#2:2 - Kick/Crash II
#4:2 - Snare
#6:1 - Ride
#7:1 - Snare(End Ride)
#8:1 - Ride
#9:1 - Snare(End Ride)
#10:1 - Kick/Ride
#11:1 - Low Kick
#12:2 - Snare
#14:1 - Ride
#15:1 - Snare(End Ride)

# Nice 4 beat repetitions
#[0,4,1]
#[[1,4,1]]
#[[4,4,1]]
#[[9,4,1]]
#[[12,4,1]]

# Nice 8 beat repetitions
#[[0,8,1]]
#[[1,8,1]]

# Main patterns I like
#   [[0,13,1],[1,3,1]] === 0
#   [[0,2,1],[8,4,1],[4,4,1],[6,6,1]] === 3
#   [[5, 1, 1], [7, 1, 1], [0, 5, 1], [5, 9, 1]] === 7 (standard sounding)
#   [[1, 14, 1], [7, 2, 1]] === 9
#   [[7, 2, -1], [9, 2, 1], [3, 12, 1]] === 10 (good reversal)
#   [[4, 2, -1], [0, 14, 1]] === 19
#   [[6, 1, 1], [13, 1, 1], [12, 1, 1], [4, 12, 1], [0, 1, 1]] === 20
#   [[10, 3, 1], [11, 4, 1], [14, 2, -1], [9, 5, 1], [5, 2, -1]] === 23
#   [[2, 14, 1], [14, 2, -1]] === 27

# Breaks I like
#   [[8, 6, 1], [13, 2, 1], [0, 3, 1], [9, 5, 1]] === 24


# s = which of the 0-15 beats to start on
#        16 - hh_kick
# f = how many beats to use from there
# b = how many beats total out of 16
# r = for s=0-15, its reverse. If s>15, it's the note
define :aslice do |s, b, r|
  if s == 16
    in_thread do hh_kick(r) end
    sleep (beats)*b
  elsif s == 17
    sleep (beats)*b
  else
    s = s * beats
    f = s + (beats * b)
    with_fx :nhpf, mix: 0.4 do
      with_fx :distortion, pre_amp: 2 do
        sample :loop_amen, rate: r, start: s, finish: f, beat_stretch: 1, amp: 2
      end
    end
    sleep (beats)*b
  end
end

define :bslice do |s, b, r|
  if s == 16
    in_thread do hh_kick(r) end
    sleep (beats)*b
  elsif s == 17
    sleep (beats)*b
  else
    s = s * beats
    f = s + (beats * b)
    with_fx :bitcrusher, bits: 8, sample_rate: 12000 do
      sample :loop_amen, rate: r, start: s, finish: f, beat_stretch: 1, amp: 2
    end
    sleep (beats)*b
  end
end

define :introslice do |s, b, r|
  if s == 16
    in_thread do hh_kick(r) end
    sleep (beats)*b
  elsif s == 17
    sleep (beats)*b
  else
    s = s * beats
    f = s + (beats * b)
    sample :loop_amen, rate: r, start: s, finish: f, beat_stretch: 1, amp: 2
    sleep (beats)*b
  end
end

# Build an array of durations of each amen component/slice (totaling 16 beats)
define :slicebar do
  durations = []
  total_length = 0
  while total_length != 16
    duration = rrand_i(1,16-total_length)
    durations.append(duration)
    total_length += duration
  end
  
  slices = []
  for slice in durations.shuffle
    start = rrand_i(0,16-slice)
    if slice < reverse_max then
      r = (rrand_i(0,reverse_max))
      if r < (reverse_max/2) then rate = -1 else rate = 1 end
    else
      rate = 1
    end
    slices.append([start,slice,rate])
  end
  return slices
end

define :slice_player do |pattern,repetitions,type|
  slices = pattern
  repetitions.times do
    for slice in slices
      if type == 0 then introslice(slice[0],slice[1],slice[2]) end
      if type == 1 then aslice(slice[0],slice[1],slice[2]) end
      if type == 2 then bslice(slice[0],slice[1],slice[2]) end
    end
  end
end

define :hh_kick do |start|
  # Original SFX default is 1117 for Pulse1 and 1044 for Pulse2
  ratios = [1.1,1.1,1.1,1.1,1.1,1.1,1.1,1.1,1.1,1.1,1.1,1.1]
  notes = [start]
  12.times do |index|
    notes = notes + [(notes[-1]/ratios[index]).round]
  end
  volumes = ([1.0]*13)
  duties = [0.5]*13
  pulse_player(notes,volumes,duties)
end

define :intro do
  # 16 total bars
  slice_player([[12,4,1]]*4,6,0) # 6 bars of simple 2 beat repetition
  slice_player([[12,4,1],[4,4,1]]*4,2,0)  # 2 bars 2 different alternating 2 beat repetitions
  slice_player([[16,2,100],[10,6,1]]*2,4,0) # 4 bars of happyhardcore (hh) kick mixed with some amen
  slice_player([[16,2,100]]*8,2,0) # 2 bars of just the happyhardcore kick
  slice_player([[16,2,100],[16,2,200]]*4,1,0) # 1 bar of hh kick of alternating note
  slice_player([[16,2,100],[16,2,150],[16,2,200],[16,2,250],[16,1,300],[16,1,350],[16,1,400],
    [16,1,450],[16,1,500],[16,1,550],[16,1,600],[16,1,650]],1,0) # 1 bar of increased pitch hh kick
end

define :partA do
  # 16 bars
    slice_player([[2, 14, 1], [14, 2, -1]],7,1) # 7 bars of main beat
    slice_player([[8, 6, 1], [13, 2, 1], [0, 3, 1], [9, 5, 1]],1,1) # 1 bar of break
    slice_player([[2, 14, 1], [14, 2, -1]],6,1) # 6 bars of main beat
    slice_player([[0,8,1]]*2,2,1) # 2 bars of simple break
end

define :partB do
  # 16 bars
    slice_player([[7, 2, -1], [9, 2, 1], [3, 12, 1]],7,2) # 7 bars of main beat
    slice_player([[8, 6, 1], [13, 2, 1], [0, 3, 1], [9, 5, 1]],1,2) # 1 bar of break
    slice_player([[4, 2, -1], [0, 14, 1]],6,2) # 7 bars of main beat
    slice_player([[0,8,-1]]*2,1,2) # 1 bars of simple break
end

define :metalbreak do
  # 10.5 bars
  slice_player([[11, 1, 1]],16,1)  # repeating fast kick
  slice_player([[2, 1, 1]],16,1)   # repeating fast kick (different kick)
  slice_player([[2, 1, 1],[11,1,1]],8,1)  # fast alternating kick
  # Basic Metal Triplet Beat with 11 Kick Triplet
  for i in [[2,0],[4,0],[2,0],[9,9],[2,0],[12,0],[2,0],[4,4]] do
    slice_player([[i[0],1,1],[11,1,1],[11,1,1],[i[1],1,1],[11,1,1],[11,1,1]],4,1)
  end
end

define :bridge do
  # 16 bars
  slice_player([[12,4,1]]*4,2,0) # 2 bars of simple 2 beat repetition
  slice_player([[12,4,1],[4,4,1]]*2,2,0)  # 2 bars 2 different alternating 2 beat repetitions
  slice_player([[4,4,1]]*4,2,0) # 2 bars of simple 2 beat repetition
  slice_player([[4,4,1],[12,4,1]]*2,2,0)  # 2 bars 2 different alternating 2 beat repetitions
  slice_player([[12,4,1]]*4,2,0) # 1 bar of simple 2 beat repetition
  slice_player([[12,4,1],[4,4,1]]*2,2,0)  # 2 bars 2 different alternating 2 beat repetitions
  slice_player([[12,4,1],[4,8,1],[12,4,1]],2,0)  # 2 bars, closer to amen
  slice_player([[0,4,1]]*4,1,0)  # 1 bar of kicks
  slice_player([[4,2,1]]*8,1,0)  # 1 bar of snares
  slice_player([[4,1,1]]*16,1,0)  # 1 bar of fast snares
end 

define :outro do
  pattern = [[12,4,1,1],[4,4,1,0.975],[12,4,1,0.95],[4,4,1,0.925],[12,4,1,0.9],[4,4,1,0.8],[12,4,1,0.75],
    [4,4,1,0.7],[12,4,1,0.65],[4,4,1,0.6],[12,4,1,0.55],[4,4,1,0.5],[12,4,1,0.4],[4,4,1,0.3],
    [12,4,1,0.2],[4,4,1,0.1]]
  slices = pattern
  for slice in slices
    s = slice[0] * beats
    f = s + (beats * slice[1])
    sample :loop_amen, rate: slice[2], start: s, finish: f, beat_stretch: 1, amp: slice[3]
    sleep (beats)*slice[1]
  end
end

intro
partA
partB
metalbreak
partA
partB
bridge
partA
outro

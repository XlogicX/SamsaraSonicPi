# Monural Beats
# Because no one peice of the kit is playing a beat at the same time as another.
#
# Looper Section
#    Defines the 'bar' function wich plays a measure of the drum pattern
#    subdivided into a resolution 32 beats. The main argument supplied to
#    this routine is 'complexity,' which does what you might think it would.
#    There are certain beats that are more consistent than others, like the
#    first beat is always going to be a :bd_tek kick. Other beats wont even
#    exist until the complexity reaches above a certain amount. Once those
#    beats do exist, an increased complexity will further diversify which
#    peices of the kit to use on that beat. The higher the complexity = more
#    active beats in the 32 available, and even more variety of the kit used.
#
# Arrangements
#    This is the section that has some routines that describe how to implement
#    a few bars, as in: play the bar at a certain complexity with specific fx.
#
# Song Implementation
#    The highest order logic that arranges the 'arrangments' into the form
#    of a full 'songs' worth of rhytm.


# -------------------------------- NES DEFS --------------------------------#
define :sweep_player do |note, volumes, duties, period, updown, shift|
  tick_dur = 6000/current_bpm
  use_synth(:pulse)
  duration = volumes.length() * 2
  divider = period
  sweep_note = play(note: hz_to_midi(note), amp: volumes[0], sustain: duration*(1/tick_dur), release: 0, pulse_width: duties[0])
  (duration - 1).times do |index|
    sleep 1/tick_dur
    if divider > 0 then
      divider = divider - 1
    else
      if updown == 0 then
        note = note - (note >> shift)
      else
        note = note + (note >> shift)
      end
      divider = period
      if note <= 10 then
        note = 10
        next
      end
      if note >= 13981 then
        note = 13981
        next
      end
    end
    control sweep_note, note: hz_to_midi(note), pulse_width: duties[index/2], amp: volumes[index/2]
  end
  return note
end

define :pulse_player do |notes, volumes, duties|
  tick_dur = 3000/current_bpm
  use_synth(:pulse)
  cycles = duties.length()
  smack_sound = play(note: hz_to_midi(notes[0]), amp: volumes[0], sustain: cycles*(1/tick_dur), release: 0, pulse_width: duties[0])
  (cycles - 1).times do |index|
    sleep 1/tick_dur
    control smack_sound, pulse_width: duties[index+1], amp: volumes[index+1], note: hz_to_midi(notes[index+1])
  end
end

define :bump do
  note = sweep_player(211,[0.9375]*4,[0.50]*4,1,0,3)
  note = sweep_player(note,[0.9375],[0.50],3,0,3)
  note = sweep_player(note,[0.5],[0.50],7,1,7)
  note = sweep_player(note,[0.4375],[0.50],7,1,7)
end

define :coin do
  notes = ([1140]*3) + ([1074]*2) + ([1433]*38)
  volumes = ([0.375]) + ([0.875]*3) + ([0.8125]*3) + ([0.75]*3) + ([0.6875]*3) + ([0.625]*3) + ([0.5625]*3) + ([0.5]*3) + ([0.4375]*3) + ([0.375]*3) + ([0.3125]*3) + ([0.25]*3) + ([0.1875]*3) + ([0.125]*3) + ([0.0625]*3)
  puts volumes.length()
  duties = [0.5]*43
  pulse_player(notes, volumes, duties)
end

# -------------------------------- Looper --------------------------------#
define :bar do |complexity|
  beat = 0
  32.times do
    # Downbeat Kick
    if beat == 0 then sample(:bd_tek) end
    
    # Off cymbal/hats
    if beat == 1 or beat==5 or beat == 9 or beat == 13 or beat == 17 or beat == 21 or beat == 25 or beat == 29
      c_rand = rand(complexity)
      if c_rand > 3 and c_rand < 5 then sample(:drum_cymbal_closed, amp: 0.5) end
      if c_rand > 5 and c_rand < 7 then sample(:drum_cymbal_soft, amp: 0.5) end
      if c_rand > 9 then sample(:drum_cymbal_pedal, amp: 0.5) end
    end
    
    # Toms to fill other beats
    if beat == 2 or beat == 6 or beat == 10 or beat == 14 or beat == 16 or beat == 22 or beat == 26
      c_rand = rand(complexity)
      if c_rand > 5 and c_rand < 6 then sample(:drum_tom_mid_soft, amp: 0.7) end
      if c_rand > 6 and c_rand < 7 then sample(:drum_tom_lo_soft, amp: 0.7) end
      if c_rand > 7 and c_rand < 8 then sample(:drum_tom_hi_soft, amp: 0.7) end
      if c_rand > 8 and c_rand < 9 then sample(:elec_fuzz_tom) end
      if c_rand > 9 and c_rand < 10 then sample(:elec_tick) end
      if c_rand > 10 then sample(:perc_swash) end
    end
    
    # Main Cymbal/Hat beat
    if beat == 3 or beat == 7 or beat ==11 or beat == 19 or beat == 23 or beat == 27
      c_rand = rand(complexity)
      if c_rand > 0.1 and c_rand < 5 then sample(:drum_cymbal_closed) end
      if c_rand > 5 and c_rand < 7 then sample(:drum_cymbal_soft) end
      if c_rand > 9 then sample(:drum_cymbal_pedal) end
    end
    
    # Alternate Kick
    if beat == 4
      c_rand = rand(complexity)
      if c_rand > 1 and c_rand < 3 then sample(:bd_tek) end
      if c_rand > 3 and c_rand < 4 then sample(:bd_ada) end
      if c_rand > 4 and c_rand < 5 then sample(:bd_zum) end
      if c_rand > 5 and c_rand < 6 then sample(:bd_sone) end
      if c_rand > 6 and c_rand < 7 then sample(:bd_klub) end
      if c_rand > 7 and c_rand < 9 then sample(:bd_boom) end
      if c_rand > 9 then sample(:bd_fat) end
    end
    
    # 1st Snare
    if beat == 8 then sample(:drum_snare_hard) end
    
    # Alternate Snaring
    if beat == 12
      c_rand = rand(complexity)
      if c_rand > 3 and c_rand < 5 then sample(:drum_snare_hard) end
      if c_rand > 5 and c_rand < 6 then sample(:drum_snare_dolf) end
      if c_rand > 6 and c_rand < 7 then sample(:elec_hi_snare) end
      if c_rand > 7 and c_rand < 8 then sample(:sn_generic) end
      if c_rand > 8 and c_rand < 9 then sample(:sn_zome) end
      if c_rand > 9 and c_rand < 10 then sample(:drum_dub) end
      if c_rand > 10 then sample(:drum_snare_soft) end
    end
    
    # Alternate upbeat snare
    if beat == 18
      c_rand = rand(complexity)
      if c_rand > 3 and c_rand < 5 then sample(:drum_snare_hard) end
      if c_rand > 5 and c_rand < 6 then sample(:drum_snare_dolf) end
      if c_rand > 6 and c_rand < 7 then sample(:elec_hi_snare) end
      if c_rand > 7 and c_rand < 8 then sample(:sn_generic) end
      if c_rand > 8 and c_rand < 9 then sample(:sn_zome) end
      if c_rand > 9 and c_rand < 10 then sample(:drum_dub) end
      if c_rand > 10 then sample(:drum_snare_soft) end
    end
    
    if beat == 20 then sample(:bd_tek) end
    
    if beat == 24 then sample(:drum_snare_hard) end
    
    if beat == 28
      c_rand = rand(complexity)
      if c_rand > 2 then sample(:drum_snare_hard) end
    end
    
    # Alternate upbeat snare
    if beat == 30
      c_rand = rand(complexity)
      if c_rand > 3 and c_rand < 5 then sample(:drum_snare_hard) end
      if c_rand > 5 and c_rand < 6 then sample(:drum_snare_dolf) end
      if c_rand > 6 and c_rand < 7 then sample(:elec_hi_snare) end
      if c_rand > 7 and c_rand < 8 then sample(:sn_generic) end
      if c_rand > 8 and c_rand < 9 then sample(:sn_zome) end
      if c_rand > 9 and c_rand < 10 then sample(:drum_dub) end
      if c_rand > 10 then sample(:drum_snare_soft) end
    end
    
    # Snaring with Crash sometimes
    if beat == 31
      c_rand = rand(complexity)
      if c_rand > 0.1 and c_rand < 5 then sample(:drum_cymbal_closed) end
      if c_rand > 5 and c_rand < 7 then sample(:drum_cymbal_soft) end
      if c_rand > 7 and c_rand < 8 then sample(:drum_splash_soft) end
      if c_rand > 8 and c_rand < 9 then sample(:drum_cymbal_open) end
      if c_rand > 9 then sample(:drum_cymbal_pedal) end
    end
    
    beat = beat + 1
    sleep (current_beat_duration / 4)
  end
end

# ------------------------------- Arangements ----------------------------#

# Just Intro an uncomplex beat with some sweeping effects via :ixi_techno
define :intro do
  with_fx :ixi_techno do
    3.times do
      bar(0)
    end
  end
  with_fx [:hpf, :lpf, :krush, :bitcrusher, :distortion, :flanger, :nbpf, :nhpf, :normaliser, :nrbpf, :octaver, :reverb, :whammy].sample do
    bar(2)
  end
end

# This is the workhorse arrangment, hence the name.
# It is recommended to do 1-12 iterations. An itteration is 3 standard bars with 1 random special fx bar.
# with +4 complexity relative to that iteration. Even though each bar is somewhat random, the 3
# standard bars within an iteration try and lock-in a consistent pattern.

# start: a value of 0 will produce 12 iterations, setting the value higher will lower the amount
#    of iterations. 4 will do 8 iterations, and 8 will do 4. Not confusing at all.
# e_mod: a modifier for some of the main fx, it is contextual to the effect being used.
# effect: the actual fx to use for the main 3 bar part of pattern
define :arrangement do |start,e_mod,effect|
  i = start
  (12-start).times do
    with_fx effect, krunch: e_mod, bits: e_mod, res: e_mod do
      seed_restore = rand_i
      3.times do
        use_random_seed = seed_restore
        bar(i)
      end
    end
    i = i+4
    with_fx [:hpf, :lpf, :krush, :bitcrusher, :distortion, :flanger, :nbpf, :nhpf, :normaliser, :nrbpf, :octaver, :reverb, :whammy].sample do
      bar(i)
    end
    i = i-3
  end
end

define :outro do
  with_fx :ixi_techno do
    4.times do
      bar(0)
    end
  end
end

define :empty do
  sleep (current_beat_duration * 32)
end

define :growl do |note, loudness|
  4.times do
    sample(:bass_dnb_f, rate: note, amp: loudness)
    sleep (current_beat_duration * 32)
  end
end

define :buzz do
  3.times do
    sleep (current_beat_duration * 8)
  end
  sample(:glitch_bass_g, rate: 0.5)
  sleep (current_beat_duration * 8)
end

# ----------------------- Song Implementation ----------------------------#
# Beats
in_thread do
  use_random_seed 6
  use_bpm 150
  intro
  arrangement(0,1,:tanh)
  arrangement(8,6,:bitcrusher)
  arrangement(4,3,:tanh)
  arrangement(0,0.1,:nrbpf)
  arrangement(10,5,:tanh)
  arrangement(10,5,:tanh)
  arrangement(10,0.2,:nbpf)
  arrangement(10,0.2,:nbpf)
  outro
end

# FX
in_thread do
  use_bpm 150
  empty
  4.times do buzz end
  growl(1,1)
  4.times do empty end
  growl(1.3,1.5)
  growl(1,1)
  4.times do empty end
  growl(0.7,2)
  growl(0.7,2)
  4.times do empty end
  growl(1,1)
  growl(0.7,3)
end

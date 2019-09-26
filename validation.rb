# Song to have background music to accompany a video demo of a boot sector game (Validation)
# This song has a lead, harmony synths, bassline, and drums
# When running from sonic pi, will likely have to import as file, as it's too big
# or some kind of noise. So import something like this from SonicPi:
# run_file "/Users/xlogicx/Documents/sonic/validation.rb"
#-----------------------------------------------#
#                 INITS                         #
#-----------------------------------------------#
use_debug false
use_bpm 150
use_random_seed 5
measure_count = 0
bass_complexity = 0    # Increases as song progresses

#-----------------------------------------------#
#                 LEAD Functions                #
#-----------------------------------------------#
# This function plays one note with a heavily processed zawa synth, parameters provided by calling function
define :leadz do |note, lres, lcutoff, lphase, lwave, lpulse, lrange, lbits, lsmooth, slwave, slpulse, lmix|
  shift = (rrand_i(-1,1)) * 12 # Shift up or down an octave, or none
  with_fx :bitcrusher, bits: lbits do
    with_fx :slicer, smooth: lsmooth, wave: slwave, pulse_width: slpulse, mix: lmix do
      use_synth :zawa
      lead = play (note), cutoff: lcutoff, res: lres, phase: lphase, wave: lwave, range: lrange, pulse_width: lpulse, note_slide: 16, attack: 0.5, attack_level: 1, decay: 9, sustain_level: 0.9, sustain: 2, release: 0.5
      sleep current_beat_duration * 16
      control lead, note: note + shift
      sleep current_beat_duration * 16
    end
  end
end

# Randomizes parameters and calls for the note to be played (note provided by calling function)
#define :leadplay do |note|
#  1.times do leadz note, res, cutoff, phase, wave, pulsewidth, lrange, lbits, lsmooth, slwave, slpulse, lmix end
#end

#-----------------------------------------------#
#                 BASS Functions                #
#-----------------------------------------------#
# The bassline, random notes from chord
define :bass_line do |root, type|
  with_fx :octaver, pre_amp: 1.2 do
    use_synth :dtri

    # Which Type of Routine to play
    rtype = rrand_i(0, bass_complexity)

    # Standard quarter notes
    if rtype == 0
      play choose(chord(root,type)), detune: 0.1, amp: 2
      sleep current_beat_duration * 4
    # 8th notes
    elsif (rtype > 1) and (rtype < 4)
      play choose(chord(root,type)), detune: 0.1, amp: 2
      sleep current_beat_duration * 2
      play choose(chord(root,type)), detune: 0.1, amp: 2
      sleep current_beat_duration * 2
    # Quarter Rest
    elsif (rtype > 3) and (rtype < 7)
      sleep current_beat_duration * 4
    # 16th Notes
    elsif  (rtype > 6) and (rtype < 11)
      play choose(chord(root+12,type)), detune: 0.1, amp: 2
      sleep current_beat_duration
      play choose(chord(root+12,type)), detune: 0.1, amp: 2
      sleep current_beat_duration
      play choose(chord(root+12,type)), detune: 0.1, amp: 2
      sleep current_beat_duration
      play choose(chord(root+12,type)), detune: 0.1, amp: 2
      sleep current_beat_duration      
    # Triplets
    elsif rtype > 10
      play choose(chord(root+12,type)), detune: 0.1, amp: 2
      sleep current_beat_duration * (4.0/3.0)
      play choose(chord(root+12,type)), detune: 0.1, amp: 1
      sleep current_beat_duration * (4.0/3.0)
      play choose(chord(root+12,type)), detune: 0.1, amp: 2
      sleep current_beat_duration * (4.0/3.0)      
    end
  end
end

define :bassline_prog_play do |root, type|
  chord_i = 0
  rootx = root[0]  # First (of 4) root notes provided
  typex = type[0]  # First (of 4) types of scales (major,minor,ect...)
  4.times do    
    8.times do bass_line rootx, typex end
    chord_i = chord_i + 1 
    if chord_i == 4 then break end
    rootx = rootx + root[chord_i]   
    typex = type[chord_i]     
  end
  # Increase Baseline complexity, up to a point, then reset to simple every now and then
  bass_complexity += 1
  if bass_complexity > 12
    bass_complexity = 0
  end
end

#-----------------------------------------------#
#                 CHORDS                        #
#-----------------------------------------------#


define :progression_play do |root, type|
  chord_i = 0
  rootx = root[0]
  typex = type[0]
  4.times do
    4.times do chords rootx, typex end
    chord_i = chord_i + 1 
    if chord_i == 4 then break end
    rootx = rootx + root[chord_i]  
    typex = type[chord_i]   
  end
end

# The coords
define :chords do |root, type|
  use_synth :dsaw
  play chord(root, type), sustain: current_beat_duration * 6, release: current_beat_duration * 2, amp: 0.9
  sleep current_beat_duration * 8
end

#-----------------------------------------------#
#                 BEATZ                         #
#-----------------------------------------------#
# Standared bass drum pattern
define :dnb_bd_standard do
  beat = 0
  16.times do
    if beat == 0 then sample :drum_bass_hard, amp: 2 end
    if beat == 10 then sample :drum_bass_hard, amp: 2 end
    beat = inc beat
    sleep (current_beat_duration / 2)
  end
end

# Standard snare pattern
define :dnb_snr_standard do
  beat = 0
  bits = rrand_i(4, 10)
  s_rate = rrand_i(100,32000)
  with_fx :bitcrusher, bits: 4, sample_rate: s_rate do
    16.times do
      if beat == 4 then sample :sn_generic end
      if beat == 12 then sample :sn_generic end
      beat = inc beat
      sleep (current_beat_duration / 2)
    end
  end
end

# Standard hat pattern
define :dnb_hats_standard do
  beat = 0
  16.times do
    if beat == 0 then sample :drum_cymbal_closed end
    if beat == 1 then sample :drum_cymbal_closed, amp: 0.5 end
    if beat == 2 then sample :drum_cymbal_closed end
    if beat == 3 then sample :drum_cymbal_closed, amp: 0.5 end
    if beat == 4 then sample :drum_cymbal_closed end
    if beat == 5 then sample :drum_cymbal_closed, amp: 0.5 end
    if beat == 6 then sample :drum_cymbal_closed end
    if beat == 7 then sample :drum_cymbal_closed, amp: 0.5 end
    if beat == 8 then sample :drum_cymbal_closed end
    if beat == 9 then sample :drum_cymbal_closed, amp: 0.5 end
    if beat == 10 then sample :drum_cymbal_closed end
    if beat == 11 then sample :drum_cymbal_closed, amp: 0.5 end
    if beat == 12 then sample :drum_cymbal_closed end
    if beat == 13 then sample :drum_cymbal_closed, amp: 0.5 end
    if beat == 14 then sample :drum_cymbal_closed end
    if beat == 15 then sample :drum_cymbal_closed, amp: 0.5 end
    beat = inc beat
    sleep (current_beat_duration / 2)
  end
end

# 1st Hat break pattern
define :dnb_hats_brk1 do
  beat = 0
  gain = rrand_i(2, 8)
  cutoff = rrand_i(90, 130)
  res = rrand(0, 0.99)
  with_fx :krush, res: res, gain: gain, cutoff: cutoff do
    16.times do
      if beat == 0 then sample :drum_cymbal_closed end
      if beat == 1 then sample :drum_cymbal_closed, amp: 0.5 end
      if beat == 2 then sample :drum_cymbal_closed end
      if beat == 3 then sample :drum_cymbal_closed, amp: 0.5 end
      if beat == 4 then sample :drum_cymbal_closed end
      if beat == 5 then sample :drum_cymbal_closed, amp: 0.5 end
      if beat == 6 then sample :drum_cymbal_closed end
      if beat == 7 then sample :drum_cymbal_closed, amp: 0.5 end
      if beat == 8 then sample :drum_cymbal_closed end
      if beat == 9 then sample :drum_cymbal_closed, amp: 0.5 end
      if beat == 10 then sample :drum_cymbal_closed end
      if beat == 11 then sample :drum_cymbal_closed, amp: 0.5 end
      if beat == 12 then sample :drum_cymbal_closed end
      if beat == 13 then sample :drum_cymbal_closed, amp: 0.5 end
      if beat == 14 then sample :drum_cymbal_closed end
      if beat == 15 then sample :drum_cymbal_closed, amp: 0.5 end
      beat = inc beat
      sleep (current_beat_duration / 2)
    end
  end
end

# 2nd hat break pattern
define :dnb_hats_brk2 do
  beat = 0
  gain = rrand_i(2, 8)
  cutoff = rrand_i(90, 130)
  res = rrand(0, 0.99)
  with_fx :krush, res: res, gain: gain, cutoff: cutoff do
    16.times do
      if beat == 0 then sample :drum_cymbal_closed end
      if beat == 4 then sample :drum_cymbal_closed end
      if beat == 8 then sample :drum_cymbal_closed end
      if beat == 12 then sample :drum_cymbal_closed end
      beat = inc beat
      sleep (current_beat_duration / 2)
    end
  end
end

# 3rd hat break pattern
define :dnb_hats_brk3 do
  beat = 0
  16.times do
    if beat == 0 then sample :drum_cymbal_closed end
    if beat == 2 then sample :drum_cymbal_closed end
    if beat == 4 then sample :drum_cymbal_closed end
    if beat == 6 then sample :drum_cymbal_closed end
    if beat == 8 then sample :drum_cymbal_closed end
    if beat == 10 then sample :drum_cymbal_closed end
    if beat == 12 then sample :drum_cymbal_closed end
    if beat == 14 then sample :drum_cymbal_closed end
    beat = inc beat
    sleep (current_beat_duration / 2)
  end
end

# Just silence for 16 beats
define :silence do
  beat = 0
  16.times do
    beat = inc beat
    sleep (current_beat_duration / 2)
  end
end

# snare break pattern
define :dnb_snr_brk do
  beat = 0
  16.times do
    if beat == 4 then sample :sn_generic end
    if beat == 7 then sample :sn_generic end
    if beat == 12 then sample :sn_generic end
    if beat == 15
      lastbeat = rrand_i(0, 1)
      if lastbeat == 1
      sample :sn_generic end
    end
    beat = inc beat
    sleep (current_beat_duration / 2)
  end
end

# 1st bass drum break pattern
define :dnb_bd_brk1 do
  beat = 0
  16.times do
    if beat == 0 then sample :drum_bass_hard, amp: 2 end
    if beat == 4 then sample :drum_bass_hard, amp: 2 end
    if beat == 8 then sample :drum_bass_hard, amp: 2 end
    if beat == 12 then sample :drum_bass_hard, amp: 2 end
    beat = inc beat
    sleep (current_beat_duration / 2)
  end
end

# 2nd bass drum break pattern
define :dnb_bd_brk2 do
  beat = 0
  16.times do
    if beat == 0 then sample :drum_bass_hard, amp: 2 end
    if beat == 1 then sample :drum_bass_hard, amp: 1 end
    if beat == 2 then sample :drum_bass_hard, amp: 2 end
    if beat == 3 then sample :drum_bass_hard, amp: 1 end
    if beat == 8 then sample :drum_bass_hard, amp: 2 end
    if beat == 9 then sample :drum_bass_hard, amp: 1 end
    if beat == 10 then sample :drum_bass_hard, amp: 2 end
    if beat == 11 then sample :drum_bass_hard, amp: 1 end
    beat = inc beat
    sleep (current_beat_duration / 2)
  end
end

#3rd bass drum break pattern
define :dnb_bd_brk3 do
  beat = 0
  16.times do
    if beat == 0 then sample :drum_bass_hard, amp: 2 end
    if beat == 3 then sample :drum_bass_hard, amp: 1 end
    if beat == 6 then sample :drum_bass_hard, amp: 2 end
    if beat == 9 then sample :drum_bass_hard, amp: 1 end
    if beat == 12 then sample :drum_bass_hard, amp: 2 end
    if beat == 15 then sample :drum_bass_hard, amp: 1 end
    beat = inc beat
    sleep (current_beat_duration / 2)
  end
end


#-----------------------------------------------#
#            THE LINEAR PART                    #
#-----------------------------------------------#
in_thread do
  1.times do
    8.times do bass_line :B1, :m end
    8.times do bass_line :E1, :m end
    8.times do bass_line :Fs1, :m end
    8.times do bass_line :B0, :m end
  end
end

sleep current_beat_duration * 128

in_thread do
  4.times do dnb_hats_standard end
end
in_thread do
  8.times do bass_line :B0, :m end
end
in_thread do
  use_synth :dsaw
  play chord(:B1, :m), sustain: current_beat_duration * 30, release: current_beat_duration * 2, amp: 0.8
  sleep current_beat_duration * 32
end

sleep current_beat_duration * 32

# Loop 4 measure bassline progression

live_loop :bass_prog_player do
  #progression_play progression1, prog_keys1
  use_bpm 150  
  bassline_prog_play [:B0,-7,2,-7], [:m,:m,:m,:m]
  bassline_prog_play [:B0,-7,2,-7], [:m,:m,:m,:m]
  bassline_prog_play [:B0,-7,2,-7], [:m,:m,:m,:m]
  bassline_prog_play [:B0,-7,2,-7], [:m,:m,:m,:m]
end

# Loop 4 measure chord progression

live_loop :prog_player do
  #progression_play progression1, prog_keys1
  use_bpm 150   
  progression_play [:B2,-7,2,-7], [:m,:m,:m,:m]
  progression_play [:B2,-7,2,-7], [:m,:m,:m,:m]
  progression_play [:B2,-7,2,-7], [:m,:m,:m,:m]
  progression_play [:B2,-7,2,-7], [:m,:m,:m,:m]
end

# 4 measure bass drum pattern.
# 3 standard measures and a special random break
live_loop :bass_drumz do 
  4.times do  
    dnb_bd_standard
    dnb_bd_standard
    dnb_bd_standard
    silent = rrand_i(0, 15)
    if silent == 0 then silence
    elsif ((silent > 0) and (silent < 4)) then dnb_bd_brk1
    elsif ((silent > 3) and (silent < 8)) then dnb_bd_brk2
    elsif ((silent > 7) and (silent < 12)) then dnb_bd_brk3
    else dnb_bd_standard end
  end
end

# 4 measure snare pattern.
# 3 standard measures and a special random break
live_loop :snare_drumz do
  1.times do
    dnb_snr_standard
    dnb_snr_standard
    dnb_snr_standard
    silent = rrand_i(0, 10)
    if silent == 0 then silence
    elsif ((silent > 0) and (silent < 8)) then dnb_snr_brk
    else dnb_snr_standard end
  end
end

# 4 measure hat pattern.
# 3 standard measures and a special random break
live_loop :hat_drumz do
  1.times do
    dnb_hats_standard
    dnb_hats_standard
    dnb_hats_standard
    silent = rrand_i(0, 10)
    if silent == 0 then silence
    elsif ((silent > 0) and (silent < 6)) then dnb_hats_brk1
    elsif ((silent == 6) or (silent == 7)) then dnb_hats_brk2
    elsif ((silent == 8) or (silent == 9)) then dnb_hats_brk3
    else dnb_hats_standard end
  end
  measure_count = measure_count + 1
end
  
live_loop :lead do
  16.times do silence end
  res = rrand(0, 0.99)
  cutoff = rrand_i(90, 130)
  phase = rrand(8,16)
  wave = rrand_i(0,3)
  pulsewidth = rrand(0,0.5)
  lrange = rrand(20,40)
  lbits = rrand_i(3,8)
  lsmooth = rrand(0,1.5)
  slwave = rrand_i(0,3)
  slpulse = rrand(0.3,0.5)
  lmix = rrand(0.2,1)    
  1.times do leadz :B4, res, cutoff, phase, wave, pulsewidth, lrange, lbits, lsmooth, slwave, slpulse, lmix end
  1.times do leadz (:B4 - 7), res, cutoff, phase, wave, pulsewidth, lrange, lbits, lsmooth, slwave, slpulse, lmix end
  1.times do leadz (:B4 + 2), res, cutoff, phase, wave, pulsewidth, lrange, lbits, lsmooth, slwave, slpulse, lmix end
  1.times do leadz (:B2), res, cutoff, phase, wave, pulsewidth, lrange, lbits, lsmooth, slwave, slpulse, lmix end
end  

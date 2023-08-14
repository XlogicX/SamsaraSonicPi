# When running from sonic pi, will likely have to import as file, as it's too big
# or some kind of noise. So import something like this from SonicPi:
# run_file "/Users/xlogicx/Documents/sonic/wmd_beats.rb"
#-----------------------------------------------#
#                 INITS                         #
#-----------------------------------------------#
use_debug false
use_bpm 150
use_random_seed 5
measure_count = 0
slice8 = 0.125
slice16 = 0.0625
a_kicksnare = 0
a_snare = 2
a_qsnare = 7
a_hat = 8
a_kick = 11



#-----------------------------------------------#
#                 BEATZ                         #
#-----------------------------------------------#
define :dnb_bd_standard do
  beat = 0
  16.times do
    if beat == 0 then
      s = a_kicksnare * slice8
      f = s + slice8
      sample :loop_amen, start: s, finish: f
    end
    if beat == 10 then
      s = a_kicksnare * slice8
      f = s + slice8
      sample :loop_amen, start: s, finish: f
    end
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
      if beat == 4 then
        s = a_snare * slice8
        f = s + slice8
        sample :loop_amen, start: s, finish: f
      end
      if beat == 12 then
        s = a_snare * slice8
        f = s + slice8
        sample :loop_amen, start: s, finish: f
      end
      beat = inc beat
      sleep (current_beat_duration / 2)
    end
  end
end

# Standard hat pattern
define :dnb_hats_standard do
  beat = 0
  16.times do
    if beat == 0 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f
    end
    if beat == 1 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f, amp: 0.5
    end    
    if beat == 2 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f
    end
    if beat == 3 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f, amp: 0.5
    end 
    if beat == 4 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f
    end
    if beat == 5 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f, amp: 0.5
    end 
    if beat == 6 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f
    end
    if beat == 7 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f, amp: 0.5
    end 
    if beat == 8 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f
    end
    if beat == 9 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f, amp: 0.5
    end 
    if beat == 10 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f
    end
    if beat == 11 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f, amp: 0.5
    end 
    if beat == 12 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f
    end
    if beat == 13 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f, amp: 0.5
    end 
    if beat == 14 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f
    end
    if beat == 15 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f, amp: 0.5
    end                         
    beat = inc beat
    sleep (current_beat_duration / 2)
  end
end

# Standard half hat pattern
define :dnb_hats_half do
  beat = 0
  16.times do
    if beat == 0 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f
    end   
    if beat == 2 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f
    end
    if beat == 4 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f
    end
    if beat == 6 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f
    end
    if beat == 8 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f
    end
    if beat == 10 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f
    end
    if beat == 12 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f
    end
    if beat == 14 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f
    end                       
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
    if beat == 0 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f
    end
    if beat == 1 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f, amp: 0.5
    end    
    if beat == 2 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f
    end
    if beat == 3 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f, amp: 0.5
    end 
    if beat == 4 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f
    end
    if beat == 5 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f, amp: 0.5
    end 
    if beat == 6 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f
    end
    if beat == 7 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f, amp: 0.5
    end 
    if beat == 8 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f
    end
    if beat == 9 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f, amp: 0.5
    end 
    if beat == 10 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f
    end
    if beat == 11 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f, amp: 0.5
    end 
    if beat == 12 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f
    end
    if beat == 13 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f, amp: 0.5
    end 
    if beat == 14 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f
    end
    if beat == 15 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f, amp: 0.5
    end  
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
      if beat == 0 then
        s = a_hat * slice16
        f = s + slice16
        sample :loop_amen, start: s, finish: f
      end
      if beat == 4 then
        s = a_hat * slice16
        f = s + slice16
        sample :loop_amen, start: s, finish: f
      end
      if beat == 8 then
        s = a_hat * slice16
        f = s + slice16
        sample :loop_amen, start: s, finish: f
      end
      if beat == 12 then
        s = a_hat * slice16
        f = s + slice16
        sample :loop_amen, start: s, finish: f
      end            
      beat = inc beat
      sleep (current_beat_duration / 2)
    end
  end
end

# 3rd hat break pattern
define :dnb_hats_brk3 do
  beat = 0
  16.times do
    if beat == 0 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f
    end
    if beat == 2 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f
    end
    if beat == 4 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f
    end
    if beat == 6 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f
    end
    if beat == 8 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f
    end
    if beat == 10 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f
    end
    if beat == 12 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f
    end
    if beat == 14 then
      s = a_hat * slice16
      f = s + slice16
      sample :loop_amen, start: s, finish: f
    end                        
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
    if beat == 4 then
      s = a_snare * slice8
      f = s + slice8
      sample :loop_amen, start: s, finish: f
    end
    if beat == 7 then
      s = a_snare * slice8
      f = s + slice8
      sample :loop_amen, start: s, finish: f
    end
    if beat == 12 then
      s = a_snare * slice8
      f = s + slice8
      sample :loop_amen, start: s, finish: f
    end    
    if beat == 15
      lastbeat = rrand_i(0, 1)
      if lastbeat == 1
        s = a_snare * slice8
        f = s + slice8
        sample :loop_amen, start: s, finish: f
      end
    end
    beat = inc beat
    sleep (current_beat_duration / 2)
  end
end

# 1st bass drum break pattern
define :dnb_bd_brk1 do
  beat = 0
  16.times do
    if beat == 0 then
      s = a_kicksnare * slice8
      f = s + slice8
      sample :loop_amen, start: s, finish: f, amp: 2
    end
    if beat == 4 then
      s = a_kicksnare * slice8
      f = s + slice8
      sample :loop_amen, start: s, finish: f, amp: 2
    end
    if beat == 8 then
      s = a_kicksnare * slice8
      f = s + slice8
      sample :loop_amen, start: s, finish: f, amp: 2
    end
    if beat == 12 then
      s = a_kicksnare * slice8
      f = s + slice8
      sample :loop_amen, start: s, finish: f, amp: 2
    end        
    beat = inc beat
    sleep (current_beat_duration / 2)
  end
end

# 2nd bass drum break pattern
define :dnb_bd_brk2 do
  beat = 0
  16.times do
    if beat == 0 then
      s = a_kicksnare * slice8
      f = s + slice8
      sample :loop_amen, start: s, finish: f, amp: 2
    end
    if beat == 1 then
      s = a_kicksnare * slice8
      f = s + slice8
      sample :loop_amen, start: s, finish: f, amp: 1
    end
    if beat == 2 then
      s = a_kicksnare * slice8
      f = s + slice8
      sample :loop_amen, start: s, finish: f, amp: 2
    end
    if beat == 3 then
      s = a_kicksnare * slice8
      f = s + slice8
      sample :loop_amen, start: s, finish: f, amp: 1
    end   
    if beat == 8 then
      s = a_kicksnare * slice8
      f = s + slice8
      sample :loop_amen, start: s, finish: f, amp: 2
    end
    if beat == 9 then
      s = a_kicksnare * slice8
      f = s + slice8
      sample :loop_amen, start: s, finish: f, amp: 1
    end
    if beat == 10 then
      s = a_kicksnare * slice8
      f = s + slice8
      sample :loop_amen, start: s, finish: f, amp: 2
    end
    if beat == 11 then
      s = a_kicksnare * slice8
      f = s + slice8
      sample :loop_amen, start: s, finish: f, amp: 1
    end           	
    beat = inc beat
    sleep (current_beat_duration / 2)
  end
end

#3rd bass drum break pattern
define :dnb_bd_brk3 do
  beat = 0
  16.times do
    if beat == 0 then
      s = a_kicksnare * slice8
      f = s + slice8
      sample :loop_amen, start: s, finish: f, amp: 2
    end
    if beat == 3 then
      s = a_kicksnare * slice8
      f = s + slice8
      sample :loop_amen, start: s, finish: f, amp: 1
    end
    if beat == 6 then
      s = a_kicksnare * slice8
      f = s + slice8
      sample :loop_amen, start: s, finish: f, amp: 2
    end
    if beat == 9 then
      s = a_kicksnare * slice8
      f = s + slice8
      sample :loop_amen, start: s, finish: f, amp: 1
    end   
    if beat == 12 then
      s = a_kicksnare * slice8
      f = s + slice8
      sample :loop_amen, start: s, finish: f, amp: 2
    end
    if beat == 15 then
      s = a_kicksnare * slice8
      f = s + slice8
      sample :loop_amen, start: s, finish: f, amp: 1
    end
    beat = inc beat
    sleep (current_beat_duration / 2)
  end
end

#-----------------------------------------------#
#              Just Breaks                      #
#-----------------------------------------------#

define :bass_break do
  silent = rrand_i(0, 15)
  if silent == 0 then silence
  elsif ((silent > 0) and (silent < 4)) then dnb_bd_brk1
  elsif ((silent > 3) and (silent < 8)) then dnb_bd_brk2
  elsif ((silent > 7) and (silent < 12)) then dnb_bd_brk3
  else dnb_bd_standard end
end

define :snare_break do
  silent = rrand_i(0, 10)
  if silent == 0 then silence
  elsif ((silent > 0) and (silent < 8)) then dnb_snr_brk
  else dnb_snr_standard end
end

define :hat_break do
  silent = rrand_i(0, 10)
  if silent == 0 then silence
  elsif ((silent > 0) and (silent < 6)) then dnb_hats_brk1
  elsif ((silent == 6) or (silent == 7)) then dnb_hats_brk2
  elsif ((silent == 8) or (silent == 9)) then dnb_hats_brk3
  else dnb_hats_standard end
end

#-----------------------------------------------#
#            4 Bar Patterns                     #
#-----------------------------------------------#

# 3 standard measures and a special random break
define :bass_drumz do 
  1.times do  
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

# 3 standard measures and a special random break
define :snare_drumz do
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

# 3 standard measures and a special random break
define :hat_drumz do
  hat_type = rrand_i(0,7)
  1.times do
  	if hat_type == 0 then dnb_hats_half else dnb_hats_standard end
  	if hat_type == 0 then dnb_hats_half else dnb_hats_standard end
  	if hat_type == 0 then dnb_hats_half else dnb_hats_standard end  		
    silent = rrand_i(0, 10)
    if silent == 0 then silence
    elsif ((silent > 0) and (silent < 6)) then dnb_hats_brk1
    elsif ((silent == 6) or (silent == 7)) then dnb_hats_brk2
    elsif ((silent == 8) or (silent == 9)) then dnb_hats_brk3
    else dnb_hats_standard end
  end
  measure_count = measure_count + 1
end

#-----------------------------------------------#
#       2nd Order Arrangements                  #
#-----------------------------------------------#

live_loop :song do

  # INTRO
  use_bpm 160

  2.times do
    in_thread do dnb_bd_brk1 end
    sleep current_beat_duration * 8	
  end

  2.times do
    in_thread do dnb_bd_brk1 end
    in_thread do dnb_snr_brk end	
    sleep current_beat_duration * 8	
  end

  4.times do
    in_thread do dnb_bd_brk1 end
    in_thread do dnb_snr_brk end
    in_thread do dnb_hats_brk3 end	
    sleep current_beat_duration * 8	
  end

  8.times do
    in_thread do dnb_bd_brk1 end
    in_thread do dnb_snr_brk end
    in_thread do dnb_hats_brk1 end	
    sleep current_beat_duration * 8	
  end  

  # AMEN WITH INCREASING DISTORTION
  distorted = 0.92
  8.times do
    with_fx :distortion, distort: distorted, amp: 0.3 do
      use_bpm 210
      1.times do
        sample :loop_amen, rate: (sample_duration :loop_amen) / 4
        sleep 4
      end
    end
    distorted += 0.01
  end

  # DRUM & BASS
  use_bpm 160

  4.times do
    in_thread do bass_drumz end
    in_thread do snare_drumz end
    in_thread do hat_drumz end
    sleep current_beat_duration * 32
  end

  # AMEN ALTERNATED WITH REVERSE AMEN AND DISTORTED SLOWDOWN
  2.times do
    with_fx :distortion, distort: 0.95, amp: 0.3 do
      use_bpm 160
      1.times do
        sample :loop_amen, rate: (sample_duration :loop_amen) / 4
        sleep 4
      end

      use_bpm 160
      1.times do
        sample :loop_amen, rate: (sample_duration :loop_amen) / 4
        sleep 4
      end

      use_bpm 160
      1.times do
        sample :loop_amen, rate: -((sample_duration :loop_amen) / 4)
        sleep 4
      end

      use_bpm 160
      1.times do
        sample :loop_amen, rate: (sample_duration :loop_amen) / 4
        sleep 4
      end
    end
  end
  with_fx :distortion, distort: 0.97, amp: 0.32 do
    use_bpm 100
    1.times do
      sample :loop_amen, rate: (sample_duration :loop_amen) / 4
      sleep 4
    end
  end

  # DRUM & BASS
  use_bpm 160
  4.times do
    in_thread do bass_drumz end
    in_thread do snare_drumz end
    in_thread do hat_drumz end
    sleep current_beat_duration * 32
  end

  # STANDARD AMEN
  8.times do
    with_fx :distortion, distort: 0.95, amp: 0.3 do
      use_bpm 210
      1.times do
        sample :loop_amen, rate: (sample_duration :loop_amen) / 4
        sleep 4
      end
    end
  end

  # SLOWDOWN DRUM & BASS
  use_bpm 110
  4.times do
    in_thread do bass_drumz end
    in_thread do snare_drumz end
    in_thread do hat_drumz end
    sleep current_beat_duration * 32
  end

  # ALTERNATING DISTORTION AMEN
  distorted = 0.85
  8.times do
    with_fx :distortion, distort: distorted, amp: 0.3 do
      use_bpm 210
      1.times do
        sample :loop_amen, rate: (sample_duration :loop_amen) / 4
        sleep 4
      end
    end
    if distorted == 0.85 then distorted = 0.97 else distorted = 0.85 end
  end

  # OUTRO DRUM & BASS FOR 12 BARS
  use_bpm 160
  distorted = 0.8
  #amped = 0.15
  amped = 0.3
  12.times do
  	with_fx :distortion, distort: distorted, amp: amped do
      in_thread do bass_drumz end
      in_thread do snare_drumz end
      in_thread do hat_drumz end
      sleep current_beat_duration * 32
    end
    distorted += 0.01
    #amped += 0.01
  end

  # 4 BARS OF OUTRO BREAKS
  16.times do
  	with_fx :distortion, distort: distorted, amp: amped do
  	  in_thread do bass_break end
  	  in_thread do snare_break end
  	  in_thread do hat_break end
  	  sleep current_beat_duration * 8
    end
    distorted += 0.0025
    #amped += 0.0025
  end

  # LAST BEAT
  s = a_kicksnare * slice8
  f = s + slice8
  sample :loop_amen, start: s, finish: f

  exit

end

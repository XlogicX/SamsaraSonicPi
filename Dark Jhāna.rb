use_random_seed 4
# ------------------------------- Patterns ----------------------------#
kick_std01=           [1,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,1,0,0,0, 0,0,0,0,0,0,0,0]
kick_std02 =           [1,0,0,0,0,0,0,0, 1,0,0,0,0,0,0,0, 1,0,0,0,0,0,0,0, 1,0,0,0,0,0,0,0]
kick_std03 =           [1,0,1,0,1,0,1,0, 0,0,0,0,0,0,0,0, 1,0,1,0,1,0,1,0, 0,0,0,0,0,0,0,0]
kick_std04 =           [1,0,0,0,0,0,1,0, 0,0,0,0,1,0,0,0, 0,0,1,0,0,0,0,0, 1,0,0,0,0,0,1,0]
snare_std01 =          [0,0,0,0,0,0,0,0, 1,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 1,0,0,0,0,0,0,0]
snare_std02 =          [0,0,0,0,0,0,0,0, 1,0,0,0,0,0,1,0, 0,0,0,0,0,0,0,0, 1,0,0,0,0,0,0.5,0.4]
snare_std03 =          [0,0,0,0,0,0,0,0, 1,0,0.9,0,0.8,0,0.7,0, 0.6,0,0.5,0,0.4,0,0.3,0, 1,0,0.9,0,0.8,0,0.7,0]
snare_std04 =          [0,0,0,0,0,0,0,0, 1,0,0,0,0,0,1,0, 0,0,0,0,0,0,0,0, 1,0,0,0,0,0,0,0]
snare_std05 =          [0,0,0,0,0,0,0,0, 1,0,0,0,0,0,1,0, 0,0,0,0,0,0,0,0, 1,0,0,0,0,0,1,0]
hat_std01 =            [0.8,0,0.6,0,0.8,0,0.6,0, 0.8,0,0.6,0,0.8,0,0.6,0, 0.8,0,0.6,0,0.8,0,0.6,0, 0.8,0,0.6,0,0.8,0,0.6,0]
hat_std02 =            [1,0.7,0.8,0.7,1,0.7,0.8,0.7, 1,0.7,0.8,0.7,1,0.7,0.8,0.7, 1,0.7,0.8,0.7,1,0.7,0.8,0.7, 1,0.7,0.8,0.7,1,0.7,0.8,0.7]
hat_std03 =            [1,0,0,0,1,0,0,0, 1,0,0,0,1,0,0,0, 1,0,0,0,1,0,0,0, 1,0,0,0,1,0,0,0]
hat_std04 =            [1,0,0,0,0,0,0,0, 1,0,0,0,0,0,0,0, 1,0,0,0,0,0,0,0, 1,0,0,0,0,0,0,0]
kick_amen01a =           [2,0,1,0,0,0,0,0, 0,0,1,1,0,0,0,0, 1,0,1,0,0,0,0,0, 0,0,1,1,0,0,0,0]
kick_amen01b =           [1,0,1,0,0,0,0,0, 0,0,1,0,0,0,0,0, 0,0,1,1,0,0,0,0, 0,0,1,0,0,0,0,0]
snare_amen01a =          [0,0,0,0,1,0,0,1, 0,1,0,0,1,0,0,1, 0,0,0,0,1,0,0,1, 0,1,0,0,1,0,0,1]
snare_amen01b =          [0,0,0,0,1,0,0,1, 0,1,0,0,0,0,1,0, 0,1,0,0,1,0,0,1, 0,1,0,0,0,0,1,0]
hat_amen01a =            [1,0,1,0,1,0,1,0, 1,0,1,0,1,0,1,0, 1,0,1,0,1,0,1,0, 1,0,1,0,1,0,1,0]
hat_amen01b =            [1,0,1,0,1,0,1,0, 1,0,1,0,1,0,1,0, 1,0,1,0,1,0,1,0, 1,0,0,0,1,0,1,0]
crash_amen01a =          [0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0]
crash_amen01b =          [0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,3,0,0,0,0,0]
# ------------------------------- Implementations ----------------------------#
define :amen_kick_a do
  kick_amen01a.each do |vol|
    #sample :bd_zum, amp: vol*4      # Not for recorded version (easier to anchor downbeats)
    with_fx :bpf, centre: 40 do
      use_synth(:bnoise)
      play(:E1, amp: vol*10, release: 0.3)
    end
    sleep (current_beat_duration / 8)
  end
end
define :amen_kick_b do
  kick_amen01b.each do |vol|
    #sample :bd_zum, amp: vol*4    # Not for recorded version (easier to anchor downbeats)
    with_fx :bpf, centre: 40 do
      use_synth(:bnoise)
      play(:E1, amp: vol*10, release: 0.3)
    end
    sleep (current_beat_duration / 8)    
  end
end
define :amen_snare_a do
  use_synth(:gnoise)
  snare_amen01a.each do |vol|
    play(:E1, amp: vol, release: 0.3)
    sleep (current_beat_duration / 8)
  end
end
define :amen_snare_b do
  use_synth(:gnoise)
  snare_amen01b.each do |vol|
    play(:E1, amp: vol, release: 0.3)
    sleep (current_beat_duration / 8)
  end
end
define :amen_hat_a do
  use_synth(:cnoise)
  hat_amen01a.each do |vol|
    play(:E1, amp: vol, release: 0.3)
    sleep (current_beat_duration / 8)
  end
end
define :amen_hat_b do
  use_synth(:cnoise)
  hat_amen01b.each do |vol|
    play(:E1, amp: vol, release: 0.3)
    sleep (current_beat_duration / 8)
  end
end
define :amen_crash_a do
  use_synth(:cnoise)
  crash_amen01a.each do |vol|
    play(:E1, amp: vol, release: 0.5)
    sleep (current_beat_duration / 8)
  end
end
define :amen_crash_b do
  use_synth(:cnoise)
  crash_amen01b.each do |vol|
    play(:E1, amp: vol, release: 0.5)
    sleep (current_beat_duration / 8)
  end
end
define :standard_kick do
  with_fx :bpf, centre: 40 do
    use_synth(:bnoise)
    kick_std01.each do |vol|
      play(:E1, amp: vol*10, release: 0.4)
      sleep (current_beat_duration / 8)
    end
  end
end
define :standard_snare do
  use_synth(:gnoise)
  snare_std02.each do |vol|
    play(:E1, amp: vol, release: 0.3)
    sleep (current_beat_duration / 8)
  end
end
define :standard_hat do
  use_synth(:cnoise)
  hat_std03.each do |vol|
    play(:E1, amp: vol, release: 0.3)
    sleep (current_beat_duration / 8)
  end
end
define :standard_kick_alt do
  kick_type = rrand_i(0,5)
  with_fx :bpf, centre: 40 do
    use_synth(:bnoise)
    if kick_type == 0 then kicks = kick_std02
    elsif kick_type == 1 then kicks = kick_std03
    elsif kick_type == 2 then kicks = kick_amen01a
    elsif kick_type == 3 then kicks = kick_amen01b
    else kicks = kick_std04 end
    kicks.each do |vol|
      play(:E1, amp: vol*10, release: 0.3)
      sleep (current_beat_duration / 8)
    end
  end
end
define :standard_snare_alt do
  snare_type = rrand_i(0,6)
  use_synth(:gnoise)
  if snare_type == 0 then snares = snare_amen01a
  elsif snare_type == 1 then snares = snare_amen01a
  elsif snare_type == 2 then snares = snare_std03
  elsif snare_type == 3 then snares = snare_std04
  elsif snare_type == 4 then snares = snare_std05
  else snares = snare_std02 end
  snare_std02.each do |vol|
    play(:E1, amp: vol, release: 0.2)
    sleep (current_beat_duration / 8)
  end
end
define :standard_hat_alt do
  hat_type = rrand_i(0,5)
  use_synth(:cnoise)
  if hat_type == 0 then hats = hat_std02
  elsif hat_type == 1 then hats = hat_std03
  elsif hat_type == 2 then hats = hat_amen01a
  elsif hat_type == 3 then hats = hat_amen01b
  else hats = hat_std04 end
  hats.each do |vol|
    play(:E1, amp: vol, release: 0.2)
    sleep (current_beat_duration / 8)
  end
end
# ------------------------------- Arangements ----------------------------#
define :intro do
  use_bpm 60
  use_synth(:gnoise)
  play(:E1, release: 8)
  sleep current_beat_duration * 4
  20.times do
    noise_type = rrand_i(0,4)
    duration = rrand_i(2,5)
    pause = rrand(0.5,1.5)
    volume = rrand(0.5,1)
    if noise_type == 0 then
      use_synth(:gnoise)
      play(:E1,amp: volume, release: duration)
      sleep current_beat_duration * pause
    end
    if noise_type == 1 then
      use_synth(:cnoise)
      play(:E1,amp: volume,release: duration)
      sleep current_beat_duration * pause
    end
    if noise_type == 2 then
      use_synth(:bnoise)
      play(:E1,amp: volume,release: duration)
      sleep current_beat_duration * pause
    end
    if noise_type == 3 then
      use_synth(:chipnoise)
      play(:E1,amp: volume,release: duration)
      sleep current_beat_duration * pause
    end
  end
  use_bpm 75
  noise_level1 = 0.8
  noise_level2 = 0.4
  4.times do
    use_synth(:cnoise)
    play(:E1,release: 16,amp: noise_level1)
    with_fx :eq, amp: noise_level2 do
      in_thread do amen_hat_a end
    end
    sleep current_beat_duration * 4
    noise_level2 = noise_level2 + 0.2
    noise_level1 = noise_level1 - 0.1
  end
  noise_level1 = 0.6
  noise_level2 = 0.4
  4.times do
    use_synth(:gnoise)
    play(:E1,release: 16,amp: noise_level1)
    with_fx :eq, amp: noise_level2 do
      in_thread do amen_snare_a end
    end
    in_thread do amen_hat_a end
    sleep current_beat_duration * 4
    noise_level2 = noise_level2 + 0.2
    noise_level1 = noise_level1 - 0.1
  end
  noise_level1 = 0.8
  noise_level2 = 0.4
  4.times do
    use_synth(:bnoise)
    play(:E1,release: 16,amp: noise_level1)
    with_fx :eq, amp: noise_level2 do
      in_thread do amen_kick_a end
    end
    in_thread do amen_hat_a end
    in_thread do amen_snare_a end
    sleep current_beat_duration * 4
    noise_level2 = noise_level2 + 0.2
    noise_level1 = noise_level1 - 0.1
  end
end
define :amen do
  use_bpm 75
  8.times do
    in_thread do amen_kick_a end
    in_thread do amen_snare_a end
    in_thread do amen_hat_a end
    in_thread do amen_crash_a end
    sleep current_beat_duration * 4
    in_thread do amen_kick_b end
    in_thread do amen_snare_b end
    in_thread do amen_hat_b end
    in_thread do amen_crash_b end
    sleep current_beat_duration * 4
  end
end
define :standard do
  use_bpm 105
  8.times do
    3.times do
      in_thread do standard_kick end
      in_thread do standard_snare end
      in_thread do standard_hat end
      sleep current_beat_duration * 4
    end
    in_thread do standard_kick_alt end
    in_thread do standard_snare_alt end
    in_thread do standard_hat_alt end
    sleep current_beat_duration * 4
  end
end
define :solo do
  use_bpm 105
  8.times do
    3.times do
      in_thread do standard_hat end
      sleep current_beat_duration * 4
    end
    in_thread do standard_hat_alt end
    sleep current_beat_duration * 4
  end
end
define :breakdown do
  8.times do
    in_thread do standard_kick_alt end
    in_thread do standard_snare_alt end
    in_thread do standard_hat_alt end
    sleep current_beat_duration * 4
  end
end
define :outro do
  use_synth(:gnoise)
  play(:E1, attack: 16, release: 16)
end
# ----------------------- Song Implementation ----------------------------#
intro
amen
standard
breakdown
solo
amen
standard
in_thread do outro end
breakdown

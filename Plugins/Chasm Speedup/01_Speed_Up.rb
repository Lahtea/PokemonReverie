module Input

  def self.update
    update_KGC_ScreenCapture
    if trigger?(Input::F8)
      pbScreenCapture
    end
    if $CanToggle && triggerex?(:TAB) # Change TAB with any of the other keys to change it. It can be a keyboard key or one of the names of the keys in the F1 menu.
      $GameSpeed += 1
      $GameSpeed = 0 if $GameSpeed >= SPEEDUP_STAGES.size
    end
  end
end

SPEEDUP_STAGES = [1,2,3]
$GameSpeed = 0
$frame = 0
$CanToggle = true

module Graphics
  class << Graphics
    alias fast_forward_update update
  end

  def self.update
    $frame += 1
    return unless $frame % SPEEDUP_STAGES[$GameSpeed] == 0
    fast_forward_update
    $frame = 0
  end
end

#gem install x10-cm17a

require 'x10/cm17a'
require 'rake'

class MediaController

  def initialize(broken_build_music, fixed_build_music)
    @broken_build_music = broken_build_music
    @fixed_build_music = fixed_build_music
  end

  def broken!()
     if(!@sound_has_played)
      build_is_broken()
       turn_on_lamp()
     end
  end

  def fixed!()
    if (!@sound_has_played)
       build_is_back()
      turn_off_lamp()
    end
  end

  private

  def turn_on_lamp()
     puts "BUILD BROKEN! Turning On Lamp"
     #Do it twice because sometimes the first doesn't take
     X10.device('A1').on
     X10.device('A1').on
    end

    def turn_off_lamp()
     #Do it twice because sometimes the first doesn't take
     puts "Build A-Ok! Turning off lamp"
     X10.device('A1').off
     X10.device('A1').off
    end

    def build_is_broken()
     sh "start \"\" #{@fixed_build_music}"
    # sh "start \"\" \"C:\Document\\All Users\\Documents\\My Music\\Standup Music\\failed.wav\""
    end

    def build_is_back()
     sh "start \"\" #{@broken_build_music}"
    # sh "start \"\" \"C:\Document\\All Users\\Documents\\My Music\\Standup Music\\fixed.wav\""
    end

end
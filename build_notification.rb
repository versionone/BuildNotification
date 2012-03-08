#gem install x10-cm17a

require 'x10/cm17a'
require 'rake'

class BuildNotification

  def initialize(media_controller, build_watcher)
    @media_controller = media_controller
    @build_watcher = build_watcher
    run()
  end

  def run!()
    puts "Welcome to the Build Monitor"

    while(true)
      check_the_builds()
      puts "Next status check in 15 seconds..."
      sleep 15
    end
  end

  def check_the_builds()
    if(we_broke_the_build)
       @broken_build = true
       turn_on_lamp()
       play_broken_sound_one_time()
    elsif (we_fixed_the_build)
        @broken_build = false
        turn_off_lamp()
        play_fixed_sound_one_time()
    end
  end

  private

  def we_broke_the_build()
    return (there_are_failing_builds() && !@broken_build)
  end

  def we_fixed_the_build()
    return (the_build_is_ok && @broken_build)
  end


end

if __FILE__ == $0
  require 'open-uri'
  require 'media_controller'
  require 'build_watcher'

  media_controller = MediaController.new(ARGV[0], ARGV[1])
  build_watcher = BuildWatcher.new { open('http://ci-server/view/monitoredBuilds/api/xml') }
  BuildNotification.new(media_controller, build_watcher).run!
end

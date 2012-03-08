require "BuildNotification"
require "test/unit"
require "rspec"

# we need a state change in between the two so we know when things break and work
# test : when build is ok, and goes to broken -- it plays a sound once
# test : when build is busted and goes fixed -- it plays a sound once
# test : when a build state isn't changed -- it doesn't play a sound once
# test : when a build is broken for a while -- it plays a different sound once

class BuildNotification_tests < Test::Unit::TestCase

    class When_a_build_was_broken

      def and_the_build_is_fixed_should_play_a_success_sound_once()
        build = BuildNotification()
        assert_equal(build.we_broke_the_build(), true)
      end

      def and_the_build_is_still_broken_should_not_play_a_sound()

      end
    end

    class When_a_build_is_good
      def and_the_build_is_still_good_should_not_play_a_sound()

      end

      def and_the_build_breaks_should_play_a_failure_sound_once()

      end

    end

end
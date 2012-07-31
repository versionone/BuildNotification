require "./build_notification"
require "./media_controller"
require "rspec"


# we need a state change in between the two so we know when things break and work
# test : when build is ok, and goes to broken -- it plays a sound once
# test : when build is busted and goes fixed -- it plays a sound once
# test : when a build state isn't changed -- it doesn't play a sound once
# test : when a build is broken for a while -- it plays a different sound once

describe BuildNotification do

  describe "when the current build is ok" do

    before(:each) do
      @media = mock_model(MediaController).new()
      @media.stub!(:broken!)
      @media.stub!(:fixed!)

      @watcher = mock_model(BuildWatcher).new()
      @watcher.stub!(:there_are_failing_builds).and_return(false)

    end

    describe "and then the build breaks" do
      it 'it play sound' do
        build = BuildNotification.new(@media, @watcher)
        build.check_the_builds()

        @media.should_recieve(:broken!).exactly(1).times
        @media.should_recieve(:fixed!).exactly(0).times

        @watcher.should_recieve(:there_are_failing_builds).once
      end
    end

    describe "and then the new build is ok" do
      it 'should not play a sound' do

      end
    end
  end
end
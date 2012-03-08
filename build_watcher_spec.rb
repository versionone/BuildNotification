require "rspec"
require './build_watcher'

describe BuildWatcher do

  describe "with an unhappy build"  do

    before(:each) do
      unhappyBuild = <<EOF
              <listView>
                <job>
                  <color>yellow</color>
                </job>
              </listView>
EOF
      @watcher = BuildWatcher.new { unhappyBuild }
    end

    it "should not have be a failing build" do
      @watcher.there_are_failing_builds.should == true
    end

  end

  describe "with a broken build" do

    before(:each) do

      brokenBuild = <<EOF
          <listView>
            <job>
              <color>red</color>
            </job>
          </listView>
EOF
      @watcher = BuildWatcher.new { brokenBuild }
    end

    it "should not have be a failing build" do
      @watcher.there_are_failing_builds.should == true
    end

  end

  describe "with a happy build" do

    before(:each) do
      goodBuild = <<EOF
      <listView>
        <job>
          <color>blue</color>
        </job>
      </listView>
EOF
      @watcher = BuildWatcher.new { goodBuild }
    end

    it "should not have be a failing build" do
      @watcher.there_are_failing_builds.should == false
    end

  end
end
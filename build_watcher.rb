#gem install nokogiri
#gem install x10-cm17a

require 'nokogiri'

class BuildWatcher

  def initialize(&block)
    @get_io = block
  end

  def there_are_failing_builds()
   @retry_count = 0
   begin
     doc = Nokogiri::HTML(@get_io.call())

     return has_elements_of_build_color(doc, "yellow") || has_elements_of_build_color(doc, "red")
   rescue
     retry if should_retry_connection()
     return false
   end
  end

private

  def has_elements_of_build_color(doc, color)
    return (doc.search(''"//job[color = '#{color}']").length > 0)
  end

  def should_retry_connection()
    if @retry_count < 3
       @retry_count += 1
       puts "Network not available. Sleeping for 10 seconds then retrying"
       sleep 10 #Wait for a bit to see if the network will come up
     return true
    else
     puts "Could not open web page (Network is down?)"
     return false
    end
  end
end
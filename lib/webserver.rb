require 'webrick'

include WEBrick    # let's import the namespace so 
                   # I don't have to keep typing 
                   # WEBrick:: in this documentation.

def start_webrick(config = {})
  # always listen on port 8080
  config.update(:Port => 8080)     
  server = HTTPServer.new(config)
  yield server if block_given?
  ['INT', 'TERM'].each {|signal| 
    trap(signal) {server.shutdown}
  }
  server.start

end

doc_root = File.expand_path(File.join([File.dirname(__FILE__), "..", "public"]))
puts "serving up #{doc_root}"
  
start_webrick(:DocumentRoot => doc_root)
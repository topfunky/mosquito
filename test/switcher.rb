$:.reject! { |e| e.include? 'TextMate' }
unless $:.grep(/camping-(.+)\/lib$/).any?
  available_dists = Dir.glob(File.dirname(__FILE__) + '/camping-dist/camping-*').sort

  # TODO - this is very inelegant
  CAMPING_DIST_DIR = available_dists[1]

  STDERR.puts "Testing with #{File.basename(CAMPING_DIST_DIR)}"
  $:.unshift CAMPING_DIST_DIR + '/lib'
end
require 'net_http_ssl_fix'
require 'set'
require 'open-uri'

unvisited  = []      # Queue of pages still to visit
discovered = Set.new # Set of visited pages

ROOT = 'https://www.wikipedia.org/wiki/'
start = "Main_Page"
discovered.add start
unvisited.push(ROOT + start)

MAX_DEPTH = 1
current_depth = 0

until unvisited.empty? || MAX_DEPTH == current_depth
  p link = unvisited.shift
  page = open(link).read
  page.scan(/href=\"\/wiki\/(.+?)"/) do |(topic)|
    unless discovered.include?(topic)
      discovered.add(topic)
      unvisited.push(ROOT + topic)
    end
  end

  current_depth += 1
end

discovered.each { |topic| puts topic }

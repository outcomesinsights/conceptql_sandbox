require_relative 'example'

Pathname.new('statements').children.each do |child|
  next unless child.directory?
  child.children.each do |file|
    next unless file.to_s =~ /\..b$/
    lines = file.readlines
    attribs = {
      title: lines.first.sub(/^#\s*/, ''),
      description: lines.select { |l| l =~ /^#/ }.map { |l| l.sub(/^#\s*/, '') }[1..99].join,
      statement: (eval(lines.select { |l| l !~ /^#/ }.join)).to_json
    }
    Example.find_or_create(attribs)
  end
end

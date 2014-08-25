require_relative 'example'

Example.all.each { |e| e.image_path; e.partial_results }

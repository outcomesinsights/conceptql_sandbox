require_relative 'example'

Example.all.each(&:image_path)

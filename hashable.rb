require 'hashids'

module Hashable
  SALT = "this is my salt, no secrets here!"
  def hash_it(val)
    hashids.encrypt val
  end

  def unhash_it(val)
    hashids.decrypt val
  end

  def hashids
    hashids = Hashids.new SALT
  end
end


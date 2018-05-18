module HashUtils
  def hash_flatten(hash)
    unless hash.present?
      return []
    end
    hash.map do |item, nesteds|
      [item] + hash_flatten(nesteds)
    end.flatten
  end
end

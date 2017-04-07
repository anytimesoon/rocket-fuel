module Slugify
  def slugifier
    self.slug = self.name.gsub(' ', '-').downcase
    self.save
  end
end

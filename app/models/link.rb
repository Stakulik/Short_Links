class Link < ActiveRecord::Base
  validates :original_link, presence: true
  validates :alias_link, presence: true, uniqueness: true
end

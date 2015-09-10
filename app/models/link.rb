class Link < ActiveRecord::Base
  validates :original_link, :alias_link, presence: true
  validates :alias_link, uniqueness: true

  after_initialize :add_protocol_and_alias

  private

  def add_protocol_and_alias
    return false unless /\A(.*)([a-z0-9а-я]+)\.([a-zа-я]{2,})(\/.*)?\z/i =~ original_link
      self.original_link = add_http_protocol(original_link)    
      self.alias_link = create_alias_link
  end

  def add_http_protocol(original_link)
    protocols = %w[http https ftp]

    arr = /\A((https?|ftp)\:\/\/)?(.+)\.([а-яa-z]{2,})\/?(.*)\z/i.match original_link
    original_link.insert(0, 'http://') unless protocols.index(arr[2])

    original_link
  end

  def create_alias_link
    alias_url = ""
    
    while alias_url.empty?
      alias_url = array_with_symbols.sample(5).join
      alias_url = "" if this_alias_link_exists?(alias_url)
    end

    alias_url 
  end

  def array_with_symbols
    ('A'..'Z').to_a + ('a'..'z').to_a + (0..9).to_a.map(&:to_s)
  end

  def this_alias_link_exists?(alias_link)
    arr = /\A([a-zA-Z0-9]{5})\z/.match alias_link
    Link.exists?(:alias_link => "#{arr[1]}")
  end

end

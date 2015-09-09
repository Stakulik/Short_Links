class Link < ActiveRecord::Base
   validates :original_link, :alias_link, presence: true
   validates :alias_link, uniqueness: true

   before_validation :add_protocol_and_alias

  private

  def add_protocol_and_alias
    if /\A(.*)([a-z0-9а-я]+)\.([a-zа-я]{2,})(\/.*)?\z/i =~ self.original_link
      self.original_link = add_http_protocol(self.original_link)    
      self.alias_link = create_alias_link
    else
      false
    end
  end

  def add_http_protocol(original_link)
    protocols = %w[http https ftp]

    /\A((https?|ftp)\:\/\/)?(.+)\.([а-яa-z]{2,})\/?(.*)\z/i.match original_link
    original_link.insert(0, 'http://') unless protocols.index($2) # заменить на массив

    original_link
  end

  def create_alias_link
    alias_url = nil
    
    while alias_url == nil
      alias_url = ""
      5.times { alias_url += array_with_symbols.sample }
      alias_url = nil if this_alias_link_exists?(alias_url)
    end

    alias_url 
  end

  def array_with_symbols
    ('A'..'Z').to_a + ('a'..'z').to_a + (0..9).to_a.map(&:to_s)
  end

  def this_alias_link_exists?(alias_link)
    /\A([a-zA-Z0-9]{5})\z/.match alias_link
    Link.exists?(:alias_link => "#{$1}")
  end











end

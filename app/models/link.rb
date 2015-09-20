class Link < ActiveRecord::Base
  validates :original_link, presence: true
  validates :alias_link, uniqueness: true

  before_validation :add_Protocol_Alias

  def valid_url?
    /\A(.*)([a-z0-9а-я]+)\.([a-zа-я]{2,})(\/.*)?\z/i =~ original_link
  end

  def update_destroy_date
    self.destroy_at = 7.days.from_now
  end

  private

  def add_Protocol_Alias
    return self.original_link = nil unless valid_url?
    
    self.original_link = add_http_protocol(original_link)
    self.alias_link = create_alias_link
    update_destroy_date
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
      new_alias = take_new_alias
      Link.exists?(:alias_link => "#{new_alias}") ? alias_url = "" : alias_url = new_alias
    end

    alias_url
  end

  def take_new_alias
    (('A'..'Z').to_a + ('a'..'z').to_a + (0..9).to_a.map(&:to_s)).sample(5).join
  end

end
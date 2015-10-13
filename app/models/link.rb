class Link < ActiveRecord::Base
  validates :original_link, :alias_link, presence: true
  validates :alias_link, uniqueness: true

  before_validation :add_Protocol_Alias, if: :new_record?

  def valid_url?
    /\A(.*)([a-z0-9а-я]+)\.([a-zа-я]{2,})(\/.*)?\z/i =~ original_link
  end

  def update_destroy_date
    self.destroy_at = 7.days.from_now
  end

  private

  def add_Protocol_Alias
    if valid_url?
      add_http_protocol
      create_alias_link
      update_destroy_date
    end
  end

  def add_http_protocol
    protocols = %w[http https ftp]

    arr = /\A((https?|ftp)\:\/\/)?(.+)\.([а-яa-z]{2,})\/?(.*)\z/i.match self.original_link
    self.original_link.insert(0, 'http://') unless protocols.index(arr[2])
  end

  def create_alias_link
    alias_url = ""
    
    while alias_url.empty?
      new_alias = take_new_alias
      Link.exists?(:alias_link => "#{new_alias}") ? alias_url = "" : alias_url = new_alias
    end

    self.alias_link = alias_url
  end

  def take_new_alias
    (('A'..'Z').to_a + ('a'..'z').to_a + (0..9).to_a.map(&:to_s)).sample(5).join
  end

end
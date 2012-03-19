class Link
  include Snippet

  before_validation { self.url = self.class.clean(url) }
  before_destroy  :can_destroy? 
  before_save :set_id

  identity type: String

  has_many :visits
  has_and_belongs_to_many :pages

  validates_uniqueness_of :data

  mount_uploader :url_screenshot, UrlScreenshotUploader

  scope :with_url, ->(url) { where(:data  => clean(url)) }

  label :title, :description

  alias :url :data
  alias :url= :data=
  alias :surl :_id

  def self.clean(url)
    PostRank::URI.clean(url)
  end

  def record_visit(referrer, ip)
    visits << Visit.new(:referrer  => referrer, :ip  => ip)
    save
  end

  def generate_screenshot?
    !url_screenshot.present?
  end

  def can_destroy?
    pages.empty?
  end

  private 
  def set_id
    self._id = Kawa::Util::Base62.encode(Kawa::Mongo::Sequence.next("links")).to_s if new_record?
  end

end

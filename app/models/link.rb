class Link
  include Snippet

  include Authority::Abilities

  before_validation { self.url = self.class.clean(url) }
  before_destroy  :can_destroy? 
  before_save :set_id

  identity type: String

  has_many :visits
  belongs_to :creator, :class_name  => "User"
  has_and_belongs_to_many :pages

  field :private, type: Boolean

  validates_uniqueness_of :data
  # validates_presence_of :creator, :data

  mount_uploader :url_screenshot, UrlScreenshotUploader

  scope :with_url, ->(url) { where(:data  => clean(url)) }

  label :title, :description

  alias :url :data
  alias :url= :data=
  alias :surl :_id

  self.authorizer_name = "LinkAuthorizer"

  def self.clean(url)
    PostRank::URI.clean(url)
  end

  #temporary until i upgrade to mongoid 3 with association callbacks
  def associate_to_page(page)
    self.creator = page.author unless creator.present?
    self.private = true if page.private && (pages.empty? || pages.all? {|p| p.private })
    self.private = false if !page.private 
    save
  end

  def record_visit(referrer, ip)
    visits << Visit.new(:referrer  => referrer, :ip  => ip)
    save
  end

  def generate_screenshot?
    url_screenshot.file.nil?
  end

  def can_destroy?
    pages.empty?
  end

  private 
  def set_id
    self._id = Kawa::Util::Base62.encode(Kawa::Mongo::Sequence.next("links")).to_s if new_record?
  end

end

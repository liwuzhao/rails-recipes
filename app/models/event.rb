class Event < ApplicationRecord

  #friendly_id 网址id
  validates_presence_of :name, :friendly_id

  validates_uniqueness_of :friendly_id
  validates_format_of :friendly_id, :with => /\A[a-z0-9\-]+\z/

  before_validation :generate_friendly_id, :on => :create

  def to_param
    self.friendly_id
  end

  #status 状态
  STATUS = ["草稿", "公开", "私密"]
  # validates_inclusion_of :status, :in => STATUS

  #分类
  belongs_to :category, :optional => true

  #票种
  has_many :tickets, :dependent => :destroy, :inverse_of => :event
  accepts_nested_attributes_for :tickets, :allow_destroy => true, :reject_if => :all_blank

  #ranked-model
  include RankedModel
  ranks :row_order

  #
  has_many :registrations

  #
  scope :only_public, -> { where( :status => "public" ) }
  scope :only_available, -> { where( :status => ["public", "private"] ) }


  protected

  #生成乱序的网址id
  def generate_friendly_id
    self.friendly_id ||= SecureRandom.uuid
  end


end

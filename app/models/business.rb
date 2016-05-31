class Business < ActiveRecord::Base
  searchkick text_start: [:name], text_middle: [:name],
             settings: { index: { max_result_window: 100_000 } }

  before_save :logo_destroy
  attr_accessor :remove_logo

  belongs_to :user
  has_and_belongs_to_many :tags, join_table: :businesses_tags
  has_and_belongs_to_many :business_types,
                          join_table: "businesses_business_types"
  has_many :products
  has_many :services
  belongs_to :country
  validates :name, presence: true
  has_many :photos, class_name: "BusinessPhoto", dependent: :delete_all

  mount_uploader :logo, LogoUploader
  store_in_background :logo

  def description
    [main_products,
     business_types.map(&:english_title),
     country.english_title].flatten.join(', ')
  end

  def main_products
    tags.map(&:english_title).join(', ')
  end

  def search_data
    attributes.merge(
      tag_names: main_products,
      business_type_ids: business_type
    )
  end

  def business_type
    business_types.ids.join(',')
  end

  private

  def logo_destroy
    self.remove_logo! if remove_logo == '1'
  end
end

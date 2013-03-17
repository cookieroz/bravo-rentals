class Message
  include ActiveAttr::Model

  attribute :name
  attribute :email
  attribute :content
  attribute :tlf
  attribute :dates
  attribute :adults
  attribute :kids
  attribute :nickname
  attribute :property_name

  validates_presence_of :name, :email, :content
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_length_of :content, :minimum => 10, :maximum => 1000
  validates :nickname,
            :format => { :with => /^$/ }
end
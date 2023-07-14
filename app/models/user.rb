class User < ApplicationRecord
  validates :account, presence: true, uniqueness: { case_sensitive: false }
  has_many :articles
  has_one :user_detail

  has_many :user_communities
  has_many :communities, through: :user_communities
  # belongs_to :user #belongs_toは何かしらに属するという意味になる
end

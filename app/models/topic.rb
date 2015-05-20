class Topic < ActiveRecord::Base
	has_many :posts, dependent: :destroy

  scope :visible_to, -> (user) {user ? all : publicly_viewable}
  scope :publicly_viewable,  -> {where(public: true )}
  scope :privately_viewable, -> {where(public: false)}


  validates :name, length: {minimum: 5 }, presence: true

  def index
    @topics = Topic.paginate(page: params[:page], per_page: 10)
    @topics = Topic.visible_to(current_user).paginate(page: params[:page], per_page: 10)
  end


end

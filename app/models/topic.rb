class Topic < ActiveRecord::Base
	has_many :posts, dependent: :destroy

  scope :visible_to, -> (user) {user ? all : where(public: true)}

	validates :name, length: {minimum: 5 }, presence: true

  def index
    @topics = Topic.paginate(page: params[:page], per_page: 10)
    @topics = Topic.visible_to(current_user).paginate(page: params[:page], per_page: 10)
  end
end

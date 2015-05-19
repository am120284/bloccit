class Post < ActiveRecord::Base
	has_many   :comments, dependent: :destroy
  has_many   :votes, dependent: :destroy
  has_many   :favorites
  has_one    :summary, dependent: :destroy
	belongs_to :user
	belongs_to :topic
  mount_uploader :image,  ImageUploader

	default_scope { order('rank DESC') }

	validates :title, length: {minimum: 5 }, presence: true
	validates :body,  length: {minimum: 20}, presence: true

  #after_create :create_vote
	validates :topic, presence: true
	validates :user,  presence: true

  #--------------------------Votes Functions--------------------------------
    def up_votes
      votes.where(value: 1).count
    end

    def down_votes
      votes.where(value: -1).count
    end


    def points
      votes.sum(:value)
    end

    def update_rank
      age_in_days = ( created_at - Time.new(1970,1,1)) / (60 * 60 * 24)
      new_rank = points + age_in_days

      update_attribute(:rank, new_rank)
    end



    def create_vote
      user.votes.create(value: 1, post: self)
      # user.votes.create(value: 1, post: self)
      # self.user.votes.create(value: 1, post: self)
      # votes.create(value: 1, user: user)
      # self.votes.create(value: 1, user: user)

      # vote = Vote.create(value: 1, user: user, post: self)
      # self.votes << vote
      # save
    end

  #-----------------------End of Vote Functions-----------------------------
  def markdown_title
    render_as_markdown title
  end

  def markdown_body
    render_as_markdown body
  end

  def save_with_initial_vote
    ActiveRecord::Base.transaction do
          @post = self
          user.votes.create(value: 1, post: @post)
      end
  end

  private

  def render_as_markdown(markdown)

     renderer   =  Redcarpet::Render::HTML.new
     extensions = {fenced_code_blocks: true }
     redcarpet  =  Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render markdown).html_safe

  end

  def associated_post(options={})
    post_options = {
        title: 'Post title',
        body: 'Post bodies must be pretty long.',
        topic: Topic.create(name: 'Topic name'),
        user: authenticated_user
    }.merge(options)

    Post.create(post_options)
  end

  def authenticated_user(options={})
    user_options = {email: "email#{rand}@fake.com", password: 'password'}.merge(options)
    user = User.new(user_options)
    user.skip_confirmation!
    user.save
    user
  end
end

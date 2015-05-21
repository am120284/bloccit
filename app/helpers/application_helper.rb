module ApplicationHelper
	def form_group_tag(errors, &block)
		if errors.any?
         content_tag :div, capture(&block), class: 'form-group has-error'
    	else
         content_tag :div, capture(&block), class: 'form-group'
   		end
    end

    
 def down_vote_link_classes(post)
    arrow = "glyphicon glyphicon-chevron-down "
    vote = current_user.voted(post)
    arrow += "voted" if vote && vote.down_vote?
    arrow
  end

  def up_vote_link_classes(post)
    arrow = "glyphicon glyphicon-chevron-up "
    vote = current_user.voted(post)
    arrow += "voted" if vote && vote.up_vote?
    arrow
  end
end

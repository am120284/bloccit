 require 'faker'
 
 post_attr = [{title: "Post tets 03", body: "This is another test"}]
 #Create Posts

 post_attr.each do |attributes|
     Post.create!(attributes) unless Post.where(attributes).first
	end

ad_attr = [{title: "Dominos Pizza", copy: "Large Pizza", price: 12.99}, {title: "GameStop", copy: "Arkham Knight", price: 59.99}]

ad_attr.each do |ads|
	Advertisement.create!(ads) unless Advertisement.where(ads).first
end

	 ads = Advertisement.all

	 posts = Post.all

	 #Create Comments
	
	 100.times do
	  Comment.create!(
	   post: posts.sample,
	    body: Faker::Lorem.paragraph
	  )
	 end
	 
	 puts "Seed finished"
	 puts "#{Post.count} posts created"
	 puts "#{Comment.count} comments created"
	 puts "#{Advertisement.count} Ad created"
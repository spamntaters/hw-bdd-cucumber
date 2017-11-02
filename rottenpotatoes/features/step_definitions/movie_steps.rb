# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(movie)
    
    
  end
#  fail "Unimplemented"
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  expect(page.body.match(/.*#{e1}.*#{e2}.*/))
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"
When /I follow "([^"]*)"$/ do |link|
  click_link(link)
end
When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  ratings = rating_list.split(", ")
  
  ratings.each do |rating|
    rating = rating.strip
    if uncheck == "un"
      uncheck("ratings_#{rating}")
    else
      check("ratings_#{rating}")
    end
  end
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  # fail "Unimplemented"
end


When /I press (.*)/ do |button|
  click_button(button)
end

Then /I should(n't)? see the following movies: (.*)/ do |not_see, movies_list|
  movies = movies_list.split(", ")
  
  movies.each do |movie|
    movie = movie.strip
    movie = movie.gsub("\"", "")
    
    if not_see == "n't"
      if page.respond_to? :should
        page.should have_no_content(movie)
      else
        assert page.has_no_content?(movie)
      end
    else
      if page.respond_to? :should
       page.should have_content(movie)
      else
        assert page.has_content?(movie)
      end
    end
    
    
  end
  

end




Then /I should see all the movies/ do
  
  all_movies = Movie.all
  
  all_movies.each do |movie|
      if page.respond_to? :should
        page.should have_content(movie.title)
      else
        assert page.has_content?(movie.title)
      end
  end
  
  # Make sure that all the movies in the app are visible in the table
  # fail "Unimplemented"
end

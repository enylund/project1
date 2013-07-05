module UsersHelper
  def you_check
  	user_signed_in? && current_user == @user
  end

  def who1
  	if you_check
  	  "You"
  	else
      "#{@user.username}'s"
    end
  end

  def who2
    if you_check
  	  "channels you created"
    else
      "#{@user.username}'s channels"
    end
  end

  def who3
  	if you_check
  	  "you follow"
  	else
  	  "#{@user.username} follows"
  	end
  end

end

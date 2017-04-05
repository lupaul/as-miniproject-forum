class UsersController < ApplicationController
  layout "admin"
  def profile
    if current_user.profile.present?
      @profile = current_user.profile
    else
      @profile = Profile.new
    end
    # @new_profile = current_user.build_profile()
    # byebug
  end

  def edit_profile

      @profile = current_user.build_profile(content_params)
      @profile.save

    redirect_to profile_users_path
    # byebug
    # @profie.save

  end

  def post_topics
    @topics = current_user.topics
  end

  def post_comments
    @comments = current_user.comments
  end

  def like_topics
    @topics = current_user.liked_topics
  end

  def stored_topics
    @topics = current_user.store_topics
  end

  

  private

  def content_params
    params.require(:profile).permit(:content)
  end
end

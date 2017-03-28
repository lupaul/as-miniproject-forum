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
    if current_user.profile.present?
      @profile = current_user.profile.update(content_params)
    else
      @profile = current_user.build_profile(content_params)
      @profile.save
    end
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

  private

  def content_params
    params.require(:profile).permit(:content)
  end
end

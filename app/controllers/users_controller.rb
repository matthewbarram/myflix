class UsersController < ApplicationController

  include FollowshipHelper

  before_action :require_user, :current_user, only: [:show]

  def new
    if session[:user_id]
      redirect_to home_path
    else
      @user = User.new
      @years = next_10_years
      user_has_invite_token
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']

    # Get the credit card details submitted by the form
    token = params[:stripeToken]
    begin
      charge = Stripe::Charge.create(
        :amount => 999, # amount in cents, again
        :currency => "aud",
        :card => token,
        :description => @user.email
      )
    rescue Stripe::CardError => e
      flash[:danger] = e.message
      redirect_to register_path
    end
    if @user.save
      flash[:success] = "Your account has been created! And your credit card has been charged."
      send_welcome_email
      session[:user_id] = @user.id
      create_followships_using_token
      redirect_to home_path
    else
      render :new
    end
  end

  private

  def next_10_years
    years = []
    number = 1
    years << Time.now.year
    10.times do
      number = 1 + number
      years << Time.now.year + number
    end
    years
  end

  def send_welcome_email
    UserMailer.delay.welcome_email(@user)
  end

  def user_has_invite_token
    if params[:invite_token] != nil
      @invitation = find_invitation
      if check_valid_invitation
        setup_user_based_on_invitation
      else
        flash[:danger] = "That is not a valid invite token. Please contact the person who invited you for a valid one."
        redirect_to register_path
      end
    end
  end

  def create_followships_using_token
    invitation = find_invitation
    if params[:invite_token]
      create_followship(invitation.user_id, @user.id)
      create_followship(@user.id, invitation.user_id)
      update_invitation(invitation)
    end
  end

  def setup_user_based_on_invitation
    @user.fullname = @invitation.fullname
    @user.email = @invitation.email
  end

  def check_valid_invitation
    @invitation != nil && @invitation.status == "pending"
  end

  def update_invitation(invitation)
    invitation.update_attribute(:status, 'accepted')
  end

  def find_invitation
    Invitation.find_by invite_token: params[:invite_token]
  end

  def user_params
    params.require(:user).permit(:password, :email, :fullname)
  end
end

class ComputeProfilesController < ApplicationController
  include Foreman::Controller::AutoCompleteSearch
  include Foreman::Controller::Parameters::ComputeProfile

  before_action :find_resource, :only => [:show, :edit, :update, :destroy]

  def index
    @compute_profiles = resource_base.search_for(params[:search], :order => params[:order]).paginate(:page => params[:page])
  end

  def show
  end

  def new
    @compute_profile = ComputeProfile.new
  end

  def edit
  end

  def create
    @compute_profile = ComputeProfile.new(compute_profile_params)
    if @compute_profile.save
      process_success :success_redirect => compute_profile_path(@compute_profile)
    else
      process_error
    end
  end

  def update
    if @compute_profile.update_attributes(compute_profile_params)
      process_success
    else
      process_error
    end
  end

  def destroy
    if @compute_profile.destroy
      process_success
    else
      process_error
    end
  end

  private

  def two_pane?
    super && params[:action] != 'show'
  end
end

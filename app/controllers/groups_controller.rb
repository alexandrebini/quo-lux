class GroupsController < ApplicationController
  before_action :set_group, only: %i[show edit update destroy]

  def index
    @groups = current_user.groups.all
  end

  def show; end

  def new
    @group = current_user.groups.new
  end

  def edit; end

  def create
    @group = current_user.groups.new(group_params)

    if @group.save
      redirect_to groups_url, notice: 'Group was successfully created.'
    else
      render :new
    end
  end

  def update
    if @group.update(group_params)
      redirect_to groups_url, notice: 'Group was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_url, notice: 'Group was successfully destroyed.'
  end

  private

  def set_group
    @group = current_user.groups.find(params[:id])
  end

  def group_params
    params.require(:group).permit(
      :name, :product_finder, competitors_attributes: %i[id product_finder]
    )
  end
end

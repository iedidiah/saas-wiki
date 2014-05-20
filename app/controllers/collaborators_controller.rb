class CollaboratorsController < ApplicationController
  def create
   @collaborator = Collaborator.new(post_params)
   if Collaborator.where(user_id: @collaborator.user_id, wiki_id: @collaborator.wiki_id).blank?
      @collaborator.save
      flash[:notice] = "Collaborator added"
      redirect_to edit_wiki_path(@collaborator.wiki)
   else
     flash[:error] = "That user is already a collaborator on this Wiki."
     redirect_to edit_wiki_path(@collaborator.wiki)
   end
  end

  private

  def post_params
    params.require(:collaborator).permit(:wiki_id, :user_name)
  end
end

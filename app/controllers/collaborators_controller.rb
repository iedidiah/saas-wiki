class CollaboratorsController < ApplicationController
  def create
   @collaborator = Collaborator.new(post_params)
   if @collaborator.save
      flash[:notice] = "Collaborator added"
      redirect_to edit_wiki_path(@collaborator.wiki)
   else
#     binding.pry
     flash[:error] = ""
     @collaborator.errors.full_messages.each do |msg|
       flash[:error] += msg
     end
     redirect_to edit_wiki_path(@collaborator.wiki)
   end
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])
    if @collaborator.destroy
      flash[:notice] = "You have removed #{@collaborator.user.user_name} as a collaborator from this Wiki" 
      redirect_to edit_wiki_path(@collaborator.wiki) 
    else
      flash[:error] = "There was an error. Please try again"
      redirect_to edit_wiki_path(@collaborator.wiki)
    end
  end

  private

  def post_params
    params.require(:collaborator).permit(:wiki_id, :user_name)
  end
end

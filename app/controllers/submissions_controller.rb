class SubmissionsController < ApplicationController

  def create
    @assignment = Assignment.find(params[:assignment_id])
    @user = User.find(params[:submission][:user_id])
    @assignment.submissions.create!(user: @user)
    redirect_to @assignment, flash: {notice: "Assignment for #{@user.name} created."}
  end

  def update
    @submission = Submission.find(params[:id])
    @submission.update!(submission_params(request.format))
    respond_to do |format|
      format.json { render json: @submission }
      format.html { redirect_to assignment_path(@submission.assignment, anchor: @submission.id) }
    end
  end

  def destroy
    @submission = Submission.find(params[:id])
    @submission.destroy!
    flash[:notice] = "Deleted the submission for #{@submission.user.name}."
    redirect_to @submission.assignment
  end

  private
  def submission_params format = :html
    params[:submission] = params if format == :json
    params.require(:submission).permit(:status, :grader_notes)
  end

end

class MessagesController < ApplicationController
  inject :messages_sender

  def create
    response = messages_sender.perform(params[:business_id],
                                       current_user,
                                       params[:subject],
                                       params[:body])

    if response.successful?
      head :ok
    else
      render json: ErrorsPresenter.new(response.object),
             status: :conflict
    end
  end
end

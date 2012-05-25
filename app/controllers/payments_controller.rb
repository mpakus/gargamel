class PaymentsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def error
    render :text => Payments.error_text(params[:error])
    # TODO find in db and update
  end

  def ok
    render :text => 'Payment OK'
    # TODO find in db and update
  end

#status, transaction = Payments[params[:pos_id]].cancel params[:session_id]
#status, transaction = Payments[params[:pos_id]].confirm params[:session_id]


  def report
    status, transaction = Payments[params[:pos_id]].get params[:session_id]
    if status == 'OK'
      if transaction.trans_status == '99'
        # paid, money received
      else
        # other stuff
      end
    end
    render :text => 'OK'
  end
end

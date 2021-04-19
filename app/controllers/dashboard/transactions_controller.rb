class Dashboard::TransactionsController < Dashboard::BaseController
  include ActionView::Helpers::NumberHelper

  def index
    @pagy, @transactions = pagy(Transaction.all.order(created_at: :desc))
  end

  def update_status
    @transaction = Transaction.find_by(id: params[:id])

    return redirect_to dashboard_transactions_path, alert: 'Cannot perform this action' if @transaction.status != 'pending'

    if @transaction.update(status: params[:status])
      notify_via_telegram(@transaction) if @transaction.status == "handled"
      redirect_to dashboard_transactions_path, notice: 'Transaction updated succesfully'
    else
      redirect_to dashboard_transactions_path, alert: 'Failure to update transaction'
    end
  end

  private

  def notify_via_telegram(transaction)
    text = if transaction.transaction_type == 'withdraw'
             "#{transaction.user.email} withdrew #{number_to_currency(transaction.amount)}"
           else
             "#{transaction.user.email} deposited #{number_to_currency(transaction.amount)}"
           end

    TelegramNotificationJob.perform_later(text)
  end
end
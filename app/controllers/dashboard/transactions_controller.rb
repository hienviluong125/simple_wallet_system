class Dashboard::TransactionsController < Dashboard::BaseController
  def index
    @transactions = Transaction.all.order(created_at: :desc)
  end

  def update_status
    @transaction = Transaction.find_by(id: params[:id])

    return redirect_to dashboard_transactions_path, alert: 'Cannot perform this action' if @transaction.status != 'pending'

    if @transaction.update(status: params[:status])
      redirect_to dashboard_transactions_path, notice: 'Transaction updated succesfully'
    else
      redirect_to dashboard_transactions_path, alert: 'Failure to update transaction'
    end
  end
end
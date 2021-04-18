class TransactionsController < ApplicationController
  include ActionView::Helpers::NumberHelper

  before_action :authenticate_user!

  def deposit
    @transaction = current_user.transactions.new
  end

  def withdraw
    @transaction = current_user.transactions.new
  end

  def create
    if transactions_params[:transaction_type] == 'deposit'
      create_deposit_transaction
    else
      create_withdraw_transaction
    end
  end

  private

  def transactions_params
    params.require(:transaction).permit(:amount, :status, :transaction_type)
  end

  def create_deposit_transaction
    @transaction = current_user.transactions.new(transactions_params)

    if @transaction.save
      TelegramNotificationJob.perform_later("#{current_user.email} request to deposit #{number_to_currency(@transaction.amount)} to wallet")
      redirect_to profile_users_path, notice: 'The deposit request was created succesfully'
    else
      render :deposit
    end
  end

  def create_withdraw_transaction
    if transactions_params[:amount].to_f > current_user.balance
      return redirect_to withdraw_transactions_path, alert: "You don't have enough balance!"
    end

    @transaction = current_user.transactions.new(transactions_params)

    if @transaction.save
      TelegramNotificationJob.perform_later("#{current_user.email} request to withdraw #{number_to_currency(@transaction.amount)} from wallet")
      redirect_to profile_users_path, notice: 'The withdraw request was created succesfully'
    else
      render :withdraw
    end
  end
end
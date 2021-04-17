class TransactionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @transaction = current_user.transactions.new
  end

  def create
  end
end
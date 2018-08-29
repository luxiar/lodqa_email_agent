# frozen_string_literal: true

# コールバックを受け入れるパスを作る
class ProgressesController < ApplicationController
  def create
    # メールを送信（SMTPサーバ使用）
    ProgressMailer.deliver_email('text mail', params)
  end
end

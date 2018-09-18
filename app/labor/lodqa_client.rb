# frozen_string_literal: true

# LODQA BSにHTTPリクエストを送る
module LodqaClient
  class << self
    SERVER_URL = "http://#{ENV['HOST_LODQA_BS']}/searches"
    def post_query(question, address_to_send, body_option)
      return WarningMailer.deliver_email('warning mail', address_to_send) if question.blank?
      callback_url = "http://#{ENV['HOST_LODQA_EMAIL_AGENT']}/mail/#{address_to_send}/events"
      post_params = { query: question,
                      read_timeout: body_option['global']['read_timeout'],
                      sparql_limit: body_option['global']['sparql_limit'],
                      answer_limit: body_option['global']['answer_limit'],
                      cache: body_option['global']['cache'],
                      callback_url: callback_url }
      RestClient::Request.execute method: :post, url: SERVER_URL, payload: post_params
      puts 'POST succcess.'
    rescue Errno::ECONNREFUSED, Net::OpenTimeout, SocketError
      puts 'POST failed.'
      FailureMailer.deliver_email('failure mail', address_to_send)
    end
  end
end

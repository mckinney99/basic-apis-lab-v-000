class RepositoriesController < ApplicationController

  def search

  end

  def github_search
    begin
    @resp = Faraday.get 'https://developer.github.com/v3/search/#search-repositories' do |req|
        req.params['client_id'] = '303c70dffe3dc17fc725'
        req.params['client_secret'] = '8a1198411520e1aef83dc8c30c0db6303d5d9946'
        req.params['q'] = params[:query]
      end
      body = JSON.parse(@resp.body)
      if @resp.success?
        @repositories = body["items"][0]["html_url"]
        @desc = body["items"][0]["description"]
        @name = body["items"][0]["name"]
      else
        @error = body["meta"]["errorDetail"]
      end

    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
    render 'search'
  end
end

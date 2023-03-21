class UrlsController < ApplicationController
	def new
		@url = Url.new
	end

	def create
		@url = Url.new(url_params)
		if @url.save
			redirect_to @url
		else
			render :new
		end
	end

	def show
			@url = Url.find(params[:id])
	end

	def redirect
	# fetch from cache
		@url = Rails.cache.fetch("url_#{params[:short_url]}", expires_in: 5.minutes) do
		Url.find_by(short_url: params[:short_url])
		end

	# if found, redirect
		if @url
				redirect_to @url.original_url, allow_other_host: true

		else
				render 'errors/not_found', status: 404
		end
	end

	private

	def url_params
		params.require(:url).permit(:original_url)
	end
end

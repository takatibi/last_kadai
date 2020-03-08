class SearchController < ApplicationController

	def search

		# BookかUserか判断する変数
		# モデルで条件分岐
		if params[:search_model] == "book"
			@books = Book.search(params[:search_method],params[:search_content])
		elsif params[:search_model] == "user"
			@users = User.search(params[:search_method],params[:search_content])

		end

	end
end

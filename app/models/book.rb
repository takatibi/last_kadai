class Book < ApplicationRecord
	belongs_to :user
	validates :title, presence: true
	validates :body, presence: true
	validates :body, length: { maximum: 200 }

	has_many :favorites,  dependent: :destroy
	def favorited_by?(user)
          favorites.where(user_id: user.id).exists?
      end
    has_many :comments, dependent: :destroy

    def self.search(search)
      return Book.all unless search
      Book.where([ "(title like ?) or (body like ?)" , "%#{search}%","%#{search}%"])
    end

     def self.search(method,word)
                if method == "forward_match"
                return Book.where("title LIKE?","#{word}%")

                elsif method == "backward_match"
                 return  Book.where("title LIKE?","%#{word}")

                elsif method == "perfect_match"
                 return  Book.where("#{word}")

                elsif method == "partial_match"
                 return   Book.where("title LIKE?","%#{word}%")

                else
                    return   Book.all
                end
    end

end

module LikesHelper
    def likeable_parent(likeable)
        if likeable.is_a?(Post)
          likeable
        elsif likeable.is_a?(Comment)
          likeable.post
        end
      end
end

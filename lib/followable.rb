module Followable
  def self.included(model_class)
    model_class.send(:has_many, :followedships, class_name: "Followship", as: :followable)
    model_class.class_eval <<-EOF
      def followers
        self.followedships.map(&:user)
      end
    EOF
    unless User.instance_methods.include?(:follow)
      User.class_eval <<-EOF
        def follow(model)
          self.followships.create(followable: model)
        end
      EOF
    end
    User.class_eval <<-EOF
      def followed_#{model_class.to_s.downcase.pluralize}
        self.followships.where(followable_type: #{model_class}.to_s).map(&:followable)
      end
    EOF
  end
end

module Followable
  def self.included(model_class)
    model_class.send(:has_many, :followships, as: :followable)
    model_class.class_eval <<-EOF
      def followers
        self.followships.map(&:user)
      end
    EOF
  end
end

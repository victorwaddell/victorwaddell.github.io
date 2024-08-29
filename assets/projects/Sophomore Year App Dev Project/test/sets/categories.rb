module Contexts
  module Categories
    # Context for addresses (assumes customer and user context)
    def create_categories
      @pans        = FactoryBot.create(:category, name: "Pans", active: true)
      @utensils    = FactoryBot.create(:category, name: "Utensils", active: true)
      @ingredients = FactoryBot.create(:category, name: "Ingredients", active: true)
      @decorations = FactoryBot.create(:category, name: "Decorations", active: false)
    end
    
    def destroy_categories
      @pans.delete
      @utensils.delete
      @ingredients.delete
      @decorations.delete 
    end

  end
end
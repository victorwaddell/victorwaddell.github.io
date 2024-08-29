module Contexts
  module Items
    # Context for items (assumes no prior contexts)
    def create_items
      create_pans
      create_utensils
      create_ingredients
    end
    
    def destroy_items
      destroy_pans
      destroy_utensils
      destroy_ingredients
    end

    def create_pans
      @baking_sheet = FactoryBot.create(:item, 
        category: @pans)

      @muffin_tray = FactoryBot.create(:item, 
        name: "GPBO Muffin Tray", 
        description: "A non-stick muffin tray for 12 muffins.", 
        category: @pans, 
        color: "Grey",
        inventory_level: 83,
        reorder_level: 25,
        is_featured: true,
        weight: 1.0)

      @mini_muffin_tray = FactoryBot.create(:item, 
        name: "GPBO Mini Muffin Tray", 
        description: "A non-stick muffin tray for 18 mini muffins.", 
        category: @pans, 
        color: "Grey",
        inventory_level: 0,
        reorder_level: 25,
        weight: 1.0,
        active: false)

      @square_cake_pan = FactoryBot.create(:item, 
        name: "GPBO Square Cake Pan", 
        description: "A square cake pan, measures 8 x 8 inches.", 
        category: @pans, 
        color: "Grey",
        inventory_level: 190,
        reorder_level: 35,
        weight: 0.85)

      @round_cake_pans = FactoryBot.create(:item, 
        name: "GPBO Round Cake Pan Set", 
        description: "A set of 2 round cake pans, each with 8 inch diameter.", 
        category: @pans, 
        color: "Grey",
        inventory_level: 124,
        reorder_level: 30,
        is_featured: true,
        weight: 1.7)
    end

    def create_utensils
      @whisk = FactoryBot.create(:item, 
        name: "GPBO Whisk", 
        description: "A stainless steel whisk for hand-beating eggs and other baking items.", 
        category: @utensils, 
        color: "Silver",
        inventory_level: 84,
        reorder_level: 25,
        weight: 0.45)

      @spatula = FactoryBot.create(:item, 
        name: "Home Hero Spatula Set", 
        description: "A set of two high-grade silcone spatulas, essential for every baker.", 
        category: @utensils, 
        color: "Black",
        inventory_level: 330,
        reorder_level: 50,
        weight: 1.2)

      @shears = FactoryBot.create(:item, 
        name: "Kitchen Shears", 
        description: "A set of heavy-duty kitchen shears, able to cut through chicken bones.", 
        category: @utensils, 
        color: "Red",
        inventory_level: 20,
        reorder_level: 20,
        weight: 0.8,
        active: false)
    end

    def create_ingredients
      @flour = FactoryBot.create(:item, 
        name: "King Arthur All-Purpose Flour", 
        description: "Our all-purpose flour is an essential ingredient for every baker yielding exceptional results. Unbleached and unbromated, this flour is milled to be versatile: strong enough for bread, and gentle enough for tender, delicate scones and cakes.", 
        category: @ingredients, 
        color: "White",
        inventory_level: 221,
        reorder_level: 100,
        weight: 5.0)
    end

    def destroy_pans
      @baking_sheet.delete
      @muffin_tray.delete
      @mini_muffin_tray.delete
      @round_cake_pans.delete
      @square_cake_pan.delete
    end

    def destroy_utensils
      @whisk.delete
      @spatula.delete
      @shears.delete
    end

    def destroy_ingredients
      @flour.delete
    end

  end
end
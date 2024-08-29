module Contexts
  module ItemPrices
    # Context for item_prices (assumes item context)
    def create_item_prices_retail
      create_pan_prices_retail
      create_utensil_prices_retail
      create_ingredient_prices_retail
    end

    # RETAIL PRICES
    def create_pan_prices_retail
      @bs1 = FactoryBot.create(:item_price, item: @baking_sheet, price: 4.95, start_date: 24.months.ago.to_date)
      @bs1.update_attribute(:start_date, 24.months.ago.to_date)
      @bs2 = FactoryBot.create(:item_price, item: @baking_sheet, price: 4.49, start_date: 14.months.ago.to_date)
      @bs2.update_attribute(:start_date, 14.months.ago.to_date)
      @bs1.update_attribute(:end_date, 14.months.ago.to_date - 1)
      @bs3 = FactoryBot.create(:item_price, item: @baking_sheet, price: 4.95, start_date: 42.weeks.ago.to_date)
      @bs3.update_attribute(:start_date, 42.weeks.ago.to_date)
      @bs2.update_attribute(:end_date, 42.weeks.ago.to_date - 1)
      @bs4 = FactoryBot.create(:item_price, item: @baking_sheet, price: 5.25, start_date: 6.months.ago.to_date)
      @bs4.update_attribute(:start_date, 6.months.ago.to_date)
      @bs3.update_attribute(:end_date, 6.months.ago.to_date - 1)
      @bs5 = FactoryBot.create(:item_price, item: @baking_sheet, price: 5.95, start_date: 4.weeks.ago.to_date)
      @bs5.update_attribute(:start_date, 4.weeks.ago.to_date)
      @bs4.update_attribute(:end_date, 4.weeks.ago.to_date - 1)

      @mt1 = FactoryBot.create(:item_price, item: @muffin_tray, price: 4.25, start_date: 24.months.ago.to_date)
      @mt1.update_attribute(:start_date, 24.months.ago.to_date)
      @mt2 = FactoryBot.create(:item_price, item: @muffin_tray, price: 4.75, start_date: 13.months.ago.to_date)
      @mt2.update_attribute(:start_date, 13.months.ago.to_date)
      @mt1.update_attribute(:end_date, 13.months.ago.to_date - 1)
      @mt3 = FactoryBot.create(:item_price, item: @muffin_tray, price: 4.95, start_date: 180.days.ago.to_date)
      @mt3.update_attribute(:start_date, 180.days.ago.to_date)
      @mt2.update_attribute(:end_date, 180.days.ago.to_date - 1)
      @mt4 = FactoryBot.create(:item_price, item: @muffin_tray, price: 5.50, start_date: 3.weeks.ago.to_date)
      @mt4.update_attribute(:start_date, 3.weeks.ago.to_date)
      @mt3.update_attribute(:end_date, 3.weeks.ago.to_date - 1)

      @rcp1 = FactoryBot.create(:item_price, item: @round_cake_pans, price: 7.25, start_date: 24.months.ago.to_date)
      @rcp1.update_attribute(:start_date, 24.months.ago.to_date)
      @rcp2 = FactoryBot.create(:item_price, item: @round_cake_pans, price: 7.75, start_date: 13.months.ago.to_date)
      @rcp2.update_attribute(:start_date, 13.months.ago.to_date)
      @rcp1.update_attribute(:end_date, 13.months.ago.to_date - 1)
      @rcp3 = FactoryBot.create(:item_price, item: @round_cake_pans, price: 7.95, start_date: 180.days.ago.to_date)
      @rcp3.update_attribute(:start_date, 180.days.ago.to_date)
      @rcp2.update_attribute(:end_date, 180.days.ago.to_date - 1)
      @rcp4 = FactoryBot.create(:item_price, item: @round_cake_pans, price: 8.50, start_date: 3.weeks.ago.to_date)
      @rcp4.update_attribute(:start_date, 3.weeks.ago.to_date)
      @rcp3.update_attribute(:end_date, 3.weeks.ago.to_date - 1)

      @scp1 = FactoryBot.create(:item_price, item: @square_cake_pan, price: 4.95, start_date: 14.months.ago.to_date)
      @scp1.update_attribute(:start_date, 14.months.ago.to_date)
      @scp2 = FactoryBot.create(:item_price, item: @square_cake_pan, price: 5.50, start_date: 6.months.ago.to_date)
      @scp2.update_attribute(:start_date, 6.months.ago.to_date)
      @scp1.update_attribute(:end_date, 6.months.ago.to_date - 1)
      @scp3 = FactoryBot.create(:item_price, item: @square_cake_pan, price: 5.75, start_date: 14.days.ago.to_date)
      @scp3.update_attribute(:start_date, 14.days.ago.to_date)
      @scp2.update_attribute(:end_date, 14.days.ago.to_date - 1)
    end

    def create_utensil_prices_retail
      @whk1 = FactoryBot.create(:item_price, item: @whisk, price: 2.95, start_date: 12.months.ago.to_date)
      @whk1.update_attribute(:start_date, 12.months.ago.to_date)
      @whk2 = FactoryBot.create(:item_price, item: @whisk, price: 3.50, start_date: 6.months.ago.to_date)
      @whk2.update_attribute(:start_date, 6.months.ago.to_date)
      @whk1.update_attribute(:end_date, 6.months.ago.to_date - 1)
      @whk3 = FactoryBot.create(:item_price, item: @whisk, price: 4.25, start_date: 2.weeks.ago.to_date)
      @whk3.update_attribute(:start_date, 2.weeks.ago.to_date)
      @whk2.update_attribute(:end_date, 2.weeks.ago.to_date - 1)

      @spt1 = FactoryBot.create(:item_price, item: @spatula, price: 7.95, start_date: 12.months.ago.to_date)
      @spt1.update_attribute(:start_date, 12.months.ago.to_date)
      @spt2 = FactoryBot.create(:item_price, item: @spatula, price: 8.50, start_date: 6.months.ago.to_date)
      @spt2.update_attribute(:start_date, 6.months.ago.to_date)
      @spt1.update_attribute(:end_date, 6.months.ago.to_date - 1)
      @spt3 = FactoryBot.create(:item_price, item: @spatula, price: 8.95, start_date: 1.week.ago.to_date)
      @spt3.update_attribute(:start_date, 1.week.ago.to_date)
      @spt2.update_attribute(:end_date, 1.week.ago.to_date - 1)   
    end

    def create_ingredient_prices_retail
      @fl1 = FactoryBot.create(:item_price, item: @flour, price: 3.95, start_date: 6.months.ago.to_date)
      @fl1.update_attribute(:start_date, 6.months.ago.to_date)
    end

    #MORE PRICES
    def create_item_prices_wholesale
      create_more_pan_prices
      create_more_utensil_prices
      create_more_ingredient_prices
    end

    def create_more_pan_prices
      @bs1w = FactoryBot.create(:item_price, item: @baking_sheet, price: 2.95, start_date: 24.months.ago.to_date)
      @bs1w.update_attribute(:start_date, 24.months.ago.to_date)
      @bs3w = FactoryBot.create(:item_price, item: @baking_sheet, price: 2.75, start_date: 42.weeks.ago.to_date)
      @bs3w.update_attribute(:start_date, 42.weeks.ago.to_date)
      @bs1w.update_attribute(:end_date, 42.weeks.ago.to_date - 1)
      @bs4w = FactoryBot.create(:item_price, item: @baking_sheet, price: 3.25, start_date: 6.months.ago.to_date)
      @bs4w.update_attribute(:start_date, 6.months.ago.to_date)
      @bs3w.update_attribute(:end_date, 6.months.ago.to_date - 1)
      @bs5w = FactoryBot.create(:item_price, item: @baking_sheet, price: 3.95, start_date: 4.weeks.ago.to_date)
      @bs5w.update_attribute(:start_date, 4.weeks.ago.to_date)
      @bs4w.update_attribute(:end_date, 4.weeks.ago.to_date - 1)

      @mt1w = FactoryBot.create(:item_price, item: @muffin_tray, price: 2.25, start_date: 24.months.ago.to_date)
      @mt1w.update_attribute(:start_date, 24.months.ago.to_date)
      @mt2w = FactoryBot.create(:item_price, item: @muffin_tray, price: 2.75, start_date: 13.months.ago.to_date)
      @mt2w.update_attribute(:start_date, 13.months.ago.to_date)
      @mt1w.update_attribute(:end_date, 13.months.ago.to_date - 1)
      @mt3w = FactoryBot.create(:item_price, item: @muffin_tray, price: 2.95, start_date: 180.days.ago.to_date)
      @mt3w.update_attribute(:start_date, 180.days.ago.to_date)
      @mt2w.update_attribute(:end_date, 180.days.ago.to_date - 1)
      @mt4w = FactoryBot.create(:item_price, item: @muffin_tray, price: 2.50, start_date: 3.weeks.ago.to_date)
      @mt4w.update_attribute(:start_date, 3.weeks.ago.to_date)
      @mt3w.update_attribute(:end_date, 3.weeks.ago.to_date - 1)

      @rcp1w = FactoryBot.create(:item_price, item: @round_cake_pans, price: 5.05, start_date: 24.months.ago.to_date)
      @rcp1w.update_attribute(:start_date, 24.months.ago.to_date)
      @rcp2w = FactoryBot.create(:item_price, item: @round_cake_pans, price: 5.55, start_date: 13.months.ago.to_date)
      @rcp2w.update_attribute(:start_date, 13.months.ago.to_date)
      @rcp1w.update_attribute(:end_date, 13.months.ago.to_date - 1)
      @rcp3w = FactoryBot.create(:item_price, item: @round_cake_pans, price: 5.75, start_date: 180.days.ago.to_date)
      @rcp3w.update_attribute(:start_date, 180.days.ago.to_date)
      @rcp2w.update_attribute(:end_date, 180.days.ago.to_date - 1)
      @rcp4w = FactoryBot.create(:item_price, item: @round_cake_pans, price: 6.40, start_date: 3.weeks.ago.to_date)
      @rcp4w.update_attribute(:start_date, 3.weeks.ago.to_date)
      @rcp3w.update_attribute(:end_date, 3.weeks.ago.to_date - 1)

      @scp1w = FactoryBot.create(:item_price, item: @square_cake_pan, price: 2.70, start_date: 14.months.ago.to_date)
      @scp1w.update_attribute(:start_date, 14.months.ago.to_date)
      @scp2w = FactoryBot.create(:item_price, item: @square_cake_pan, price: 3.25, start_date: 6.months.ago.to_date)
      @scp2w.update_attribute(:start_date, 6.months.ago.to_date)
      @scp1w.update_attribute(:end_date, 6.months.ago.to_date - 1)
      @scp3w = FactoryBot.create(:item_price, item: @square_cake_pan, price: 3.60, start_date: 14.days.ago.to_date)
      @scp3w.update_attribute(:start_date, 14.days.ago.to_date)
      @scp2w.update_attribute(:end_date, 14.days.ago.to_date - 1)
    end

    def create_more_utensil_prices
      @whk1w = FactoryBot.create(:item_price, item: @whisk, price: 1.95, start_date: 12.months.ago.to_date)
      @whk1w.update_attribute(:start_date, 12.months.ago.to_date)
      @whk2w = FactoryBot.create(:item_price, item: @whisk, price: 2.50, start_date: 6.months.ago.to_date)
      @whk2w.update_attribute(:start_date, 6.months.ago.to_date)
      @whk1w.update_attribute(:end_date, 6.months.ago.to_date - 1)
      @whk3w = FactoryBot.create(:item_price, item: @whisk, price: 3.25, start_date: 2.weeks.ago.to_date)
      @whk3w.update_attribute(:start_date, 2.weeks.ago.to_date)
      @whk2w.update_attribute(:end_date, 2.weeks.ago.to_date - 1)

      @spt1 = FactoryBot.create(:item_price, item: @spatula, price: 6.95, start_date: 12.months.ago.to_date)
      @spt1.update_attribute(:start_date, 12.months.ago.to_date)
      @spt2 = FactoryBot.create(:item_price, item: @spatula, price: 7.50, start_date: 6.months.ago.to_date)
      @spt2.update_attribute(:start_date, 6.months.ago.to_date)
      @spt1.update_attribute(:end_date, 6.months.ago.to_date - 1)
      @spt3 = FactoryBot.create(:item_price, item: @spatula, price: 7.95, start_date: 1.week.ago.to_date)
      @spt3.update_attribute(:start_date, 1.week.ago.to_date)
      @spt2.update_attribute(:end_date, 1.week.ago.to_date - 1)   
    end

    def create_more_ingredient_prices
      @fl1w = FactoryBot.create(:item_price, item: @flour, price: 1.95, start_date: 6.months.ago.to_date)
      @fl1w.update_attribute(:start_date, 6.months.ago.to_date)
    end

  end
end
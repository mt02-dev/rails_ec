namespace :promotion_code do
  desc "generate promotion codes"
  task generate: :environment do
    chars = [('a'..'z'), ('A'..'Z'), (0..9)].flat_map(&:to_a)
    10.times do 
      PromotionCode.create(code: (0..7).map { chars.sample }.join, discounted_price: rand(100..1000).floor(-2))
    end
  end

end

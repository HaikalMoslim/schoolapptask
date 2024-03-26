module FeesHelper
    def combine_payment_user_id(buyer_phone, user_id)
        "#{buyer_phone}#{user_id}"
    end

    def combine_buyer_phone_user_id(buyer_phone, user_id)
        "#{buyer_phone}#{user_id}"
    end
end

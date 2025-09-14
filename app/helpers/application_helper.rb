module ApplicationHelper
end

module FormattedTimeHelper
  def format_time(time, format = :db, blank_message = "&nbsp;")
    return blank_message if time.blank?
    if I18n.locale == :fr
      time.to_fs(:fr_db)
    else
      time.to_fs(format)
    end
  end
end

module CryptoCurrencyHelper
  def crypto_currency_complete_name(crypto_currency)
    "#{crypto_currency.fullname} (#{crypto_currency.shortname})"
  end
end

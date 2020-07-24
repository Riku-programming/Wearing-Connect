require "csv"

CSV_ID = 0
CSV_ITEM_NAME = 1
CSV_PRICE = 2
CSV_BRAND = 3
CSV_CONTENT = 4


# CSVファイルを読み込み、DB（テーブル）へ保存
CSV.foreach("db/csv/item.csv") do |row|
  id = row[CSV_ID]
  item_name = row[CSV_ITEM_NAME]
  price = row[CSV_PRICE]
  brand = row[CSV_BRAND]
  content = row[CSV_CONTENT]

  Item.find_or_create_by(id: id, item_name: item_name, price: price, brand: brand, content: content)
end

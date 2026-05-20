require 'json'

def count_user_ids(path)
  # 1. Faylı oxuyuruq və JSON olaraq parse edirik
  file_content = File.read(path)
  data = JSON.parse(file_content)

  # 2. Hər bir userId-nin sayını saxlamaq üçün boş bir Hash yaradırıq (ilkin dəyəri 0)
  counts = Hash.new(0)

  # 3. Data üzərində dövr edərək userId-ləri sayırıq
  data.each do |item|
    user_id = item['userId']
    counts[user_id] += 1 if user_id
  end

  # 4. Nəticəni tapşırıqdakı çıxış formatına uyğun ekrana yazdırırıq
  counts.each do |user_id, count|
    puts "#{user_id}: #{count}"
  end
end

class Address < ApplicationRecord
  belongs_to :city
  belongs_to :city_part, optional: true
  belongs_to :street, optional: true
  belongs_to :postcode

  def address
    r = ''
    r << street.name unless street.nil?
    r << city_part.name if street.nil? && !city_part.nil?
    r << " ev. č." if evidence
    r << " #{number}"
    r << "/#{orient}" unless orient.nil?
    r << letter unless letter.nil?
    r << ", #{postcode.number} #{city.name}"
    r << " - #{city_part.name}" if city_part_end?
    r
  end

  def city_part_end?
    !city_part.nil? && !street.nil? && city_part.name != city.name
  end

  def self.subterm_to_words_and_numbers(subterm)
    numbers = []
    words = []

    subterm.split(/\s+/).each do |item|
      if item.match(/\A[0-9]+\z/).nil?
        words << item
      else
        numbers << item
      end
    end

    if numbers.size >= 2 && numbers[0].size == 3 && numbers[1].size == 2
      # postcode '150 00' => '15000'
      a = numbers.shift + numbers.shift
      numbers.unshift(a)
    end

    [numbers, words]
  end

  def self.autocomplete(term)
    obj = Address.joins(:city, :postcode).left_outer_joins(:city_part, :street)
    term.split(/,\s*/).each do |subterm|
      numbers, words = subterm_to_words_and_numbers subterm

      numbers.each do |number|
        obj = obj.where('postcodes.number = ?', number) if number.size == 5
        next if number.size >= 5
        obj = obj.where(number_conditions, number + '%', number + '%')
      end

      next if words.empty?
      name = words.join(' ') + '%'
      obj = obj.where(words_conditions, name, name, name)
    end
    obj.limit(20).all
  end

  def self.number_conditions
    'addresses.number like ? or addresses.orient like ?'
  end

  def self.words_conditions
    'cities.name like ? or streets.name like ? or city_parts.name like ?'
  end
  
  def self.ac_test term
    r = nil
    bm = Benchmark.measure do
     r = autocomplete(term).map(&:address)
    end
    puts "Benchmark: #{term}: #{bm.real}"
    r
  end
end

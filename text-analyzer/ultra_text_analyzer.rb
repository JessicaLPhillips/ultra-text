class UltraTextAnalyzer
  def self.analyze(text)
    return nil unless text.is_a? String
    words = text.downcase.gsub(/[^0-9A-Za-z\s]/, '').split(" ")
    result = "#{words.length} words "
    result += "#{text.length} characters " 
    result += "#{text.length - text.split(" ").join.length} spaces "
    longestword = ""
    words.each do |text|
      if text.length > longestword.length
        longestword = text
      end
    end

    result += " Longest word: #{longestword} "
    result += " Most common word: #{words.max_by {|text| words.count(text)}} "
    
    total = 0
    is_regex = /[a-zA-Z]+\s+is/
    let_us_regex =/let\s+us/i
    i_regex = /(\W|^)I\s+(have|am)/
    have_regex = /(would|could|should|must|you|they)\s+have/
    not_regex = /(have|is|should|can|has|had|could|do|would|did|does|are|must|were|will)\s+not/
    are_regex =/(you|they|we)\s+are/

    total += text.scan(is_regex).length
    total +=text.scan(let_us_regex).length
    total += text.scan(i_regex).length
    total += text.scan(not_regex).length
    total += text.scan(have_regex).length
    total += text.scan(are_regex).length

    result += "Contractible phrases: #{total}"
  end
end
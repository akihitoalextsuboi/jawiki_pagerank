require 'natto'
require 'open-uri'

class FindName
  NUMBER_TO_FIND = 10
  def is_name?(page_title)
    nm = Natto::MeCab.new
    nm.parse(page_title).include? '人名'
  end

  def is_name_alive?(page_title)
    return unless is_name?(page_title)
    url = "http://ja.wikipedia.org/wiki/#{page_title}"
    charset = nil
    html = open(url) do |f|
      charset = f.charset
      f.read
    end

    text = Nokogiri::HTML.parse(html, nil, charset)
    nodes = text.xpath('//tr/td')
    nodes.each do |node|
      return false if node.text.include? '死没'
    end
    return true
  end

  def find_name_alive
    answer = []
    Page.order(page_score: :desc).each do |page|
      title = page.page_title
      if is_name_alive?(title)
        answer << title
      end
      if answer.length <= NUMBER_TO_FIND
        break
      end
    end
    return answer
  end
end

class CalculatePageRank
  DAMPING_FACTOR = 0.85
  LOOP_COUNT = 1

  class << self

    def initialize_page_score
      page_count = Page.count
      Page.all.update_all(page_score: (1.0 / page_count))
    end


    def calculate_pagerank

      i = 0
      while i < LOOP_COUNT
        i += 1
    
       (1..3216300).each do |id|
	  page = Page.find(id)
	  temp_score = 0
	  return if page.blank?
          linked_page_ids = page.pagelinks_by_title.pluck(:pl_from)
          linked_page_ids.each do |linked_page_id|
	    page = Page.where(linked_page_id).first
            temp_score += page.page_score / linked_page_ids.size if page.present?
          end
          temp_score = (1 - DAMPING_FACTOR) / Page.count + DAMPING_FACTOR * temp_score
          page.page_score = temp_score
          page.save
        end

    
      end
    end

    def calc_example(links)
      node_score = Hash.new
      links.each do |node, linked_nodes|
	node_score[node] = 1.0 / links.length
      end
      node_score.each do |node, linked_nodes|
        puts node_score.inspect
      end
      i = 0
      while i < LOOP_COUNT
	i += 1
	links.each do |node, linked_nodes|
	  temp_score = 0
	  linked_nodes.each do |linked_node|

	    temp_score += node_score[linked_node.to_i] / linked_nodes.length
	  end
	  temp_score = (1 - DAMPING_FACTOR) / links.length + DAMPING_FACTOR * temp_score
	  node_score[node] = temp_score
	end
      end
      puts node_score.inspect
    end
  end
end

# links = {
#   1 => [5],
#   2 => [4, 7, 8],
#   3 => [1, 3, 4, 7, 9],
#   4 => [1, 2, 4, 8],
#   5 => [1, 6, 7, 9],
#   6 => [1, 5, 8],
#   8 => [3, 4],
#   9 => [1, 4, 6, 8]
# }
# CalculatePageRank.calc_example(links)
CalculatePageRank.initialize_page_score
CalculatePageRank.calculate_pagerank
